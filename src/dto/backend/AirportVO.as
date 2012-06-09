package dto.backend
{
	
	[RemoteClass(alias = "dto.backend.AirportVO")]
	[Bindable]
	/**
	 * Class used to communication between frontend and backend. It represents airport object.  
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