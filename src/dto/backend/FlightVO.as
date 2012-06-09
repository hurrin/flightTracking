package dto.backend
{
	
	[RemoteClass(alias = "dto.backend.FlightVO")]
	[Bindable]
	public class FlightVO {
		
		public var airline:String;
		public var flightNr:uint;
		public var fromAirport:String;
		public var toAirport:String;
		public var planeId:String;
	}
}