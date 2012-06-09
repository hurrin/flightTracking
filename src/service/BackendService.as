package service
{
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	/**
	 * Komunikacja z backandem za pomocą RemoteObject i pyAMF. 
	 * @author Adamus
	 * 
	 */	
	public class BackendService {
		
		private var channels:ChannelSet;
		private var getPlanePositionService:RemoteObject;
		
		public function BackendService(){
			
			var pyAMF:AMFChannel;
			pyAMF.uri = "http://127.0.0.1:8000/gateway/";
			channels.addChannel(pyAMF);
			
			getPlanePositionService.channelSet = channels;
			getPlanePositionService.destination = "myservice";
			getPlanePositionService.showBusyCursor = true;
			
			
		}
	}
}