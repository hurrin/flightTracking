package dto.backend
{
	[RemoteClass(alias = "dto.backend.PlaneVO")]
	/**
	 * Class representing Plane object. It is used to communication between backend and frontend.
	 * Actually at the start of application it is made a request for planes. Backend response contains
	 * collections of objects type PlaneVO <br>
	 * What is more, objects of this type are send when refreshing planes coordinates
	 * @author Adamus 
	 */	
	public class PlaneVO { 
		
		
		/**
		 * Planes' identificator
		 */
		public var aircraftID:String;
		/**
		 * Planes' actual altitude above sea level 
		 */		
		public var altitiude:Number;
		/**
		 * Planes' actual speed
		 */		
		public var speed:Number;
		/**
		 * Planes' actual coordinates 
		 */		
		public var positionX:Number;
		public var positionY:Number;
		
	}
}