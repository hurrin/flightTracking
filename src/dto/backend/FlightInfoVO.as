package dto.backend
{
	[RemoteClass(alias = "dto.backend.FlightInfoVO")]
	/**
	 * Class used to communication between backend and fronted. It contains essential informations
	 * to present object on map. Objects of this type are sent when frontend request for actual
	 * flights between airports.
	 * @author Adamus
	 * 
	 */	
	public class FlightInfoVO {
		
		
		/**
		 * It's airline name which plane belongs to
		 */		
		public var airline:String;
		/**
		 * Flight ID 
		 */		
		public var flightNr:uint;
		/**
		 * Airports' name from which plane is flying 
		 */		
		public var fromAirport:String;
		/**
		 * Plane destination airport name 
		 */		
		public var toAirport:String;
		
		/**
		 * Plane ID
		 */		
		public var aircraft:String;

		
	}
}