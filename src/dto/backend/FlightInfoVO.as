package dto.backend
{
	
	/**
	 * Class used to communication between backend and fronted. It exchanges essential informations
	 * to present object on map
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
		/**
		 * Plane height above the sea level 
		 */		
		public var altitiude:Number;
		/**
		 * Plane speed  
		 */		
		public var speed:Number;
		/**
		 * Coordinates, Latitude 
		 */		
		public var positionX:Number;
		/**
		 * Coordinates, Longitude 
		 */		
		public var positionY:Number;
		
		public function FlightInfoVO() {
		}
	}
}