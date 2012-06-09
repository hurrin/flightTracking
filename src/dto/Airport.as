package dto
{
	import org.openscales.geometry.basetypes.Location;
	

	/**
	 * Klasa reprezentujaca Lotnisko. 
	 * @author Adamus
	 * 
	 */	
	public class Airport {
		
		// typy lotów
		public static const ARRIVAL:String = "ARRIVAL";
		public static const DEPARTURE:String = "DEPARTURE";
		
		private var _name:String;
		private var _location:Location;
		private var _arrivals:Vector.<Flight>;
		private var _departures:Vector.<Flight>;
				
		public function Airport(n:String, loc:Location){
			name = n;
			_location = loc;
			_arrivals = new Vector.<Flight>();
			_departures = new Vector.<Flight>();
		}

		/**
		 * Funkcja dodajaca lot do lotniska.
		 * Mamy do wyboru dwa rodzaje lotow : przyloty i odloty. W zaleznosci
		 * od wybranego typu lotu jest on dodawany do odpowiedniej kolekcji. 
		 * @param flight - obiekt lotu
		 * @param type - typ lotu
		 * 
		 */		
		public function addFlight(flight:Flight, type:String):void {
			if( type == ARRIVAL ){
				arrivals.push(flight);
			} else if( type == DEPARTURE ){
				departures.push(flight);
			}
		}
		
		/**
		 * Funkcja usuwajaca dany lot z lotniska. Oznacza to, ze lot sie zakonczyl. 
		 * @param id - identyfikator lotu.
		 * 
		 */		
		public function remFlight(id:uint, type:String):void {
			
			if( type == ARRIVAL ){
				for( var i:int = 0; i < _arrivals.length; i++ ){
					if( _arrivals[i].fligthNr == id ){
						_arrivals.splice(i,1);
					}
				}
			} else if( type == DEPARTURE ){
				for( i = 0; i < _departures.length; i++ ){
					if( _departures[i].fligthNr == id ){
						_departures.splice(i,1);
					}
				}
			}
		}
		
		/*
		 * Getters & Setters 
		 */
		
		/**
		 * Kolekcja odlotów z danego lotniska. 
		 */
		public function get departures():Vector.<Flight> {
			return _departures;
		}

		/**
		 * @private
		 */
		public function set departures(value:Vector.<Flight>):void {
			_departures = value;
		}

		/**
		 * Kolekcja przylotów na dane lotnisko. 
		 */
		public function get arrivals():Vector.<Flight> {
			return _arrivals;
		}

		/**
		 * @private
		 */
		public function set arrivals(value:Vector.<Flight>):void {
			_arrivals = value;
		}

		/**
		 * Nazwa lotniska 
		 */
		public function get name():String {
			return _name;
		}

		/**
		 * @private
		 */
		public function set name(value:String):void {
			_name = value;
		}

		/**
		 * Lokalizacja lotniska na mapie. 
		 */		
		public function get location():Location	{
			return _location;
		}

		/**
		 * @private
		 */
		public function set location(value:Location):void {
			_location = value;
		}


	}
}