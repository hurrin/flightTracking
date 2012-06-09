package dto.backend
{
	[RemoteClass(alias = "dto.backend.PlaneVO")]
	[Bindable]
	public class PlaneVO { 
		
		public var aircraft:String;
		public var altitiude:Number;
		public var speed:Number;
		public var positionX:Number;
		public var positionY:Number;
		
	}
}