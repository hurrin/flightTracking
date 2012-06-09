package events
{
	import dto.Flight;
	
	import flash.events.Event;
	
	/**
	 * Klasa reprezentująca zdarzenia zwiazane z lotami.
	 * <p>SEND_FLIGHT_INFO jest wywolywany w momencie gdy uzytkownik klika na samolot. Wtedy za pomoca
	 * tego zdarzenia przekazujemy dane opisujace wskazany lot do wyswietlanego okienka.</p> 
	 * @author Adamus
	 * 
	 */	
	public class FlightEvent extends Event {
		
		public static const SEND_FLIGHT_INFO:String = "SEND_FLIGHT_INFO";
		
		private var _flight:Flight;
		
		public function FlightEvent(type:String, f:Flight, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			
			_flight = f;
		}

		/**
		 * Dane opisujace lot samolotu.
		 */
		public function get flight():Flight {
			return _flight;
		}

	}
}