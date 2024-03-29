package service
{
	import dto.Airport;
	import dto.Flight;
	import dto.Plane;
	import dto.backend.AirportVO;
	import dto.backend.FlightInfoVO;
	import dto.backend.PlaneVO;
	
	import map.features.AirportFeature;
	import map.features.PlaneMarker;
	
	import mx.collections.ArrayCollection;
	
	import org.openscales.core.Map;
	import org.openscales.core.layer.VectorLayer;
	import org.openscales.geometry.basetypes.Location;
	import org.openscales.proj4as.ProjProjection;

	/**
	 * Klasa zarządzająca obiektami znajdującymi się na mapie. <br> 
	 * Jej zadaniem jest utworzenie obiektow na mapie i ich rysowanie.
	 *  Implementuje wzorzec singletona. 
	 * @author Adamus
	 * 
	 */	
	public class ObjectsManager
	{
		private static var _instance:ObjectsManager;
		
		private var _flightsService:BackendService;
		private var _planes:Vector.<Plane>
		private var _flights:Vector.<Flight>;
		private var _airports:Vector.<Airport>;
		
		private var _map:Map;
		private var _drawLayer:VectorLayer;

		
		public function ObjectsManager(enforcer:SingletonEnforcer) {
			if( !enforcer ){
				throw new Error("Singleton can only be accessed through Singleton.getInstance()");
			}
			
			_planes = new Vector.<Plane>();
			_flights = new Vector.<Flight>();
			_airports = new Vector.<Airport>();
			_flightsService = BackendService.instance;
		}
		
		public static function get instance():ObjectsManager {
			if( ! ObjectsManager._instance ){
				ObjectsManager._instance = new ObjectsManager(new SingletonEnforcer());
			}
			return ObjectsManager._instance; 
		}
		
		/**
		 * Funkcja dodająca obiekt ( samolot, lot lub lotnisko ) do aplikacji. Jeżeli dodawany jest 
		 * nowy lot, to automatycznie zostaje on reprezentowany na mapie w postaci samolotu. Podobnie
		 * dzieje sie w przypadku lotniska, które reprezentowane jest przez małe niebieskie kółko. 
		 * @param o
		 * 
		 */		
		private function addObject(o:Object):void {
			var pFeature:PlaneMarker;
			var aFeature:AirportFeature;
			var fl:Flight;
			
			if( o is Plane ){
				_planes.push( o as Plane);
			} else if( o is Flight ){
				fl = o as Flight;
					
				fl.fromAirport.addFlight(fl, Airport.DEPARTURE);
				fl.toAirport.addFlight(fl, Airport.ARRIVAL);
					
				// dodajemy obiekt do mapy.
				pFeature = new PlaneMarker(o as Flight);
				drawLayer.addFeature(pFeature);
					
			} else if( o is Airport ){
				_airports.push( o as Airport )
					
				aFeature = new AirportFeature(o as Airport);
				drawLayer.addFeature(aFeature);
			}
		}
		
		/**
		 * Funkcja usuwajaca samolot z mapy.
		 * Po usunięciu z mapy, obiekt także jest usuwany z odpowiednich kolekcji. Także
		 * informajca na lotnisku musi zostać uaktualniona. 
		 * @param name - nazwa samolotu 
		 * 
		 */		
		private function remPlane(name:String):void {
			var pFlight:Flight;
			
			// szukamy nr lotu tego samolotu
			for(var i:int = 0; i < _flights.length; i++ ){
				if( _flights[i].plane.aircraft == name ){
					pFlight = _flights[i];
					break;
				}
			}
			
			// usuwamy lot z mapy
			for each( var pf:PlaneMarker in drawLayer.features ){
				if( pf.flight.fligthNr == pFlight.fligthNr){
					drawLayer.removeFeature(pf);
				}
			}
			
			// usuwamy lot z odpowiednich lotnisk
			pFlight.fromAirport.remFlight(pFlight.fligthNr, Airport.DEPARTURE);
			pFlight.toAirport.remFlight(pFlight.fligthNr, Airport.ARRIVAL);
			
			
			// usuwamy lot i lotnisko z kolekcji.
			_flights.splice(i,1);
			
			
			// TODO -> czy usuwać obiekty po zakończeniu lotu ???
			/*for( i = 0; i < _planes.length; i++ ){
				if( _planes[i].aircraft == name ){
					_planes.splice(i, 1);
					return;
				}
			}
			trace("nie znaleziono samolotu o nazwie:" + name );*/
		}
		
		/**
		 * Funkcja czyszcząca mapę z wszystkich obiektów. 
		 */		
		public function clearMap():void {
			drawLayer.clear();
		}
		
		/**
		 * Funkcja kasująca wszystkie obiekty dodane do ObjectsManager'a 
		 */		
		public function clean():void {
			_planes.splice(0, _planes.length-1);
			_airports.splice(0, _airports.length-1);
			_flights.splice(0, _flights.length-1);
		}
		
		
		/**
		 * Function to make a request for all objects from backend at the very beginning 
		 * of the application. 
		 */		
		public function initializeMap():void {
			
			// TODO: It is very important to get Planes objects before getting FlightsInfo objects.
			// That is because Flight object need already existing Plane objects!
			// don't know if we get them in right order
			_flightsService.getAirports(mapAirportsObjects);
			_flightsService.getPlanes(mapPlaneObjects);
			_flightsService.getFlightsInfo(mapFlightsObjects);
			
		}
		
		/**
		 * Function to get new planes coordinates
		 */		
		public function refreshPlanesCoords():void {
			_flightsService.getPlanes(mapPlaneObjects);
		}
		
		
		/*
		 *	Mapping functions 
		 */
		
		private function mapPlaneObjects(o:Object):void {
			[ArrayElementType="PlaneVO"]
			var list:ArrayCollection = new ArrayCollection(o as Array);
			var newPlane:Boolean = true;
			
			for each(var p:PlaneVO in list){
				for each(var p2:Plane in _planes){
					// if we found one
					if( p.aircraftID == p2.aircraft ){
						p2.position = new Location(p.positionX, p.positionY, p2.position.projection);
						newPlane = false;
						break;
					}
				}
				
				// if we havent received object, lets create it
				if( newPlane ){
					addObject(new Plane(p.aircraftID,p.altitiude,p.speed,new Location(p.positionX,p.positionY, new ProjProjection("EPSG:900913"))));
					newPlane = true;
				}
			}
		}
		
		
		private function mapAirportsObjects(o:Object):void {
			[ArrayElementType="AirportVO"]
			var list:ArrayCollection = new ArrayCollection(o as Array);

			
			// airports are received only one, at the startup, and assume that they don't repeat
			for each(var a:AirportVO in list){
				addObject(new Airport(a.name, new Location(a.positionX, a.positionY, new ProjProjection("EPSG:900913"))));
			}
			
		}

		private function mapFlightsObjects(o:Object):void {
			[ArrayElementType="FlightInfoVO"]
			var list:ArrayCollection = new ArrayCollection(o as Array);
			
			var dstArp:Airport;
			var strArp:Airport;
			var pl:Plane;
			
			for each(var f:FlightInfoVO in list){
				
				// searching for specified objects
				for each( var p:Plane in _planes ){
					if( f.aircraft == p.aircraft ){
						pl = p;
						break;
					}
				}
				
				for each(var a:Airport in _airports ){
					if( f.fromAirport == a.name ){
						strArp = a;
					} else if(f.toAirport == a.name){
						dstArp = a;
					}
				}
				
				addObject(new Flight(f.flightNr, f.airline, strArp, dstArp, pl));
			}
		}
		
		/*
		 * Other stuff 
		 */
		
		public function get map():Map {
			return _map;
		}

		public function set map(value:Map):void {
			_map = value;
		}

		/**
		 * Warstwa robocza, na której rysowac bedziemy obiekty. 
		 * @return 
		 * 
		 */		
		public function get drawLayer():VectorLayer {
			return _drawLayer;
		}

		public function set drawLayer(value:VectorLayer):void {
			_drawLayer = value;
		}
	}
}

class SingletonEnforcer{}