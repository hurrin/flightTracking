package dto.backend
{
	
	[RemoteClass(alias = "dto.backend.AirportVO")]
	/**
	 * Class used to communication between frontend and backend. It represents airport object. 
	 * <p> At the start of the application frontend requests for all airports. There is only one such 
	 * request, because we assume that the number of airports doesn't change ;) </p>
	 * @author Adamus
	 * 
	 */
	public class AirportVO {
		
		public var name:String;
		/**
		 * Coordinates, Latitude 
		 */		
		public var positionX:Number;
		/**
		 * Coordinates, Longitude
		 */		
		public var positionY:Number;
	
	}
}