package dto
{
	import org.openscales.geometry.basetypes.Location;

	/**
	 * Klasa reprezentujaca samolot. 
	 * @author Adamus
	 * 
	 */	
	public class Plane {
		
		private var _aircraft:String;
		private var _altitude:Number;
		private var _speed:Number;
		private var _position:Location;
		
		
		public function Plane(arcft:String, alt:Number, spd:Number, pstn:Location) {
			aircraft = arcft;
			altitude = alt;
			speed = spd;
			position = pstn;
		}

		
		/*
		 * Getters & Setters 
		 */
		
		/**
		 * Pozycja samolotu. 
		 */
		public function get position():Location {
			return _position;
		}

		/**
		 * @private
		 */
		public function set position(value:Location):void {
			_position = value;
		}

		/**
		 * Predkosc samolotu.
		 */
		public function get speed():Number {
			return _speed;
		}

		/**
		 * @private
		 */
		public function set speed(value:Number):void {
			_speed = value;
		}

		/**
		 * Wysokosc nad poziomem morza samolotu. 
		 */
		public function get altitude():Number {
			return _altitude;
		}

		/**
		 * @private
		 */
		public function set altitude(value:Number):void	{
			_altitude = value;
		}

		/**
		 * Nazwa samolotu. 
		 */
		public function get aircraft():String {
			return _aircraft;
		}

		/**
		 * @private
		 */
		public function set aircraft(value:String):void {
			_aircraft = value;
		}

	}
}