package map.features
{
	import dto.Flight;
	
	import events.FlightEvent;
	
	import flash.events.MouseEvent;
	
	import org.openscales.core.feature.Feature;
	import org.openscales.core.feature.PointFeature;
	import org.openscales.core.style.Rule;
	import org.openscales.core.style.Style;
	import org.openscales.core.style.marker.DisplayObjectMarker;
	import org.openscales.core.style.symbolizer.PointSymbolizer;
	import org.openscales.geometry.Geometry;
	import org.openscales.geometry.Point;
	
	
	/**
	 * Feature opakowujący lot. Reprezentowany jest na mapie jako samolocik. 
	 * @author Adamus
	 * 
	 */	
	public class PlaneMarker extends PointFeature {
		
		private var _flight:Flight;
		
		private var _graphic:DisplayObjectMarker;
		
		/**
		 * Boolean used to know if that marker has been draw. This is used to draw markers only
		 *  when all the map and layer stuff are ready
		 */
		private var _drawn:Boolean = false;
		
		/**
		 * Obrazek reprezentujacy obiekt
		 */
		[Embed(source="/assets/images/plane_small_icon.png")]
		private var _image:Class;
		
		/**
		 *  Konstruktor
		 */		
		public function PlaneMarker( f:Flight, geom:Point=null, data:Object=null, style:Style=null) {
			super(geom, data, style);
			
			flight = f;
			
			// przygotowanie obiektu do wyświetlenia na mapie. 
			this._graphic = new DisplayObjectMarker(this._image, 0, 0, 16);
			var rule:Rule = new Rule();
			var symbolizer:PointSymbolizer = new PointSymbolizer(this._graphic);
			rule.symbolizers.push(symbolizer);
			this.style = new Style();
			this.style.rules.push(rule);
			
			if( !geom ){
				this.geometry = new Point(f.plane.position.x, f.plane.position.y);
				this.geometry.projection =  f.plane.position.projection;
			}
			
			// nasłuchujemy na klik myszką
			addEventListener(MouseEvent.CLICK, onClick);
		}

		
		/**
		 * Funkcja zmieniająca pozycję samolota na mapie. 
		 * @param newX
		 * @param newY
		 * 
		 */		
		public function changePosition(newX:Number, newY:Number):void {
			(this.geometry as Point).x = newX;
			(this.geometry as Point).y = newY;
		}
		
		/**
		 * Kliknięcie myszką na samolot powoduje pojawienie się okienka z danymi lotu.
		 * W tym celu dispatchowany jest event do głównego okienka aplikacji, gdzie jest
		 * tworzone i wyświetlane docelowe okno. 
		 * @param e
		 * 
		 */		
		private function onClick(e:MouseEvent):void {
			
			dispatchEvent(new FlightEvent(FlightEvent.SEND_FLIGHT_INFO, this._flight, true ));			
		}
		
		override public function clone():Feature {
			var geoClone:Geometry = this.geometry.clone();
			var planeClone:PlaneMarker = new PlaneMarker(flight, geoClone as Point, null, this.style);
			planeClone.image = image;
			return planeClone;
		}
		
		public function get image():Class {
			return this._image;
		}
		
		public function set image(value:Class):void {
			this._image = value;
			this._graphic.image = value;
			this._drawn = false;
		}
		

		public function get flight():Flight	{
			return _flight;
		}

		public function set flight(value:Flight):void {
			_flight = value;
		}
	}
}