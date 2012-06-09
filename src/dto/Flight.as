package dto
{
	/**
	 * Klasa reprezentujaca lot ( tj. lot samolotem )
	 * Agreguje samolot i lotniska pomiędzy którymi następuje przelot.
	 * @author Adamus
	 * 
	 */	
	public class Flight	{
		
		private var _airline:String;
		private var _fligthNr:uint;
		private var _fromAirport:Airport;
		private var _toAirport:Airport;
		private var _plane:Plane;
			
		
		
		public function Flight(id:uint, airline:String, from:Airport, to:Airport, plane:Plane) {
			fligthNr = id;
			this.airline = airline;
			fromAirport = from;
			toAirport = to;
			this.plane = plane;
		}

		
		
		/**
		 * Linia lotnicza 
		 */
		public function get airline():String {
			return _airline;
		}

		/**
		 * @private
		 */
		public function set airline(value:String):void {
			_airline = value;
		}

		/**
		 * Identyfikator lotu. 
		 */
		public function get fligthNr():uint {
			return _fligthNr;
		}

		/**
		 * @private
		 */
		public function set fligthNr(value:uint):void {
			_fligthNr = value;
		}

		/**
		 * Lotnisko startowe. 
		 */
		public function get fromAirport():Airport {
			return _fromAirport;
		}

		/**
		 * @private
		 */
		public function set fromAirport(value:Airport):void {
			_fromAirport = value;
		}

		/**
		 * Lotnisko docelowe. 
		 */
		public function get toAirport():Airport {
			return _toAirport;
		}

		/**
		 * @private
		 */
		public function set toAirport(value:Airport):void {
			_toAirport = value;
		}

		/**
		 * Samolot. 
		 */
		public function get plane():Plane {
			return _plane;
		}

		/**
		 * @private
		 */
		public function set plane(value:Plane):void {
			_plane = value;
		}


	}
}