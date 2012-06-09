package service
{
	import dto.Airport;
	import dto.Flight;
	import dto.Plane;
	
	import map.features.AirportFeature;
	import map.features.PlaneMarker;
	
	import org.openscales.core.Map;
	import org.openscales.core.layer.VectorLayer;

	/**
	 * Klasa zarządzająca obiektami znajdującymi się na mapie. <br> 
	 * Jej zadaniem jest utworzenie obiektow na mapie i ich rysowanie. Powinna odświerzać pozycje obiektow
	 * na mapie co np 1 sekunde. <br> 
	 *  Implementuje wzorzec singletona. 
	 * @author Adamus
	 * 
	 */	
	public class ObjectsManager
	{
		private static var _instance:ObjectsManager;
		
		private var _planes:Vector.<Plane>;
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
		public function addObject(o:Object):void {
			var pFeature:PlaneMarker;
			var aFeature:AirportFeature;
			
			if( o is Plane ){
				_planes.push( o as Plane);
			} else if( o is Flight ){
				_flights.push( o as Flight )
					
				// dodajemy obiekt do mapy.
				pFeature = new PlaneMarker(o as Flight);
				drawLayer.addFeature(pFeature);
				//TODO: nie wiem czy potrzebne
				//drawLayer.redraw(true);
					
			} else if( o is Airport ){
				_airports.push( o as Airport )
					
				aFeature = new AirportFeature(o as Airport);
				drawLayer.addFeature(aFeature);
				//TODO: nie wiem czy potrzebne
//				drawLayer.redraw(true);
			}
		}
		
		/**
		 * Funkcja usuwajaca samolot z mapy.
		 * Po usunięciu z mapy, obiekt także jest usuwany z odpowiednich kolekcji. Także
		 * informajca na lotnisku musi zostać uaktualniona. 
		 * @param name - nazwa samolotu 
		 * 
		 */		
		public function remPlane(name:String):void {
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
			
//			
//			for( i = 0; i < _planes.length; i++ ){
//				if( _planes[i].aircraft == name ){
//					_planes.splice(i, 1);
//					return;
//				}
//			}
//			trace("nie znaleziono samolotu o nazwie:" + name );
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