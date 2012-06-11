package service
{
	import dto.backend.AirportVO;
	import dto.backend.FlightInfoVO;
	import dto.backend.PlaneVO;
	
	import flash.events.SecurityErrorEvent;
	
	import mx.controls.Alert;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	/**
	 * Service to communicate with backend through RemoteObject and pyAMF.
	 * Implements singleton pattern.
	 * @author Adamus
	 * 
	 */	
	public class BackendService {
		
		private static const URL:String = "http://localhost:8080/gateway/";
		private static var _instance:BackendService;
		
		private var _flightsService:RemoteObject;
		private var _getPlanesOperation:AbstractOperation;
		private var _getFlightsOperation:AbstractOperation;
		private var _getAirportsOperation:AbstractOperation;
		
		private var _onGetPlanesSuccess:Function;
		private var _onGetFlightsSuccess:Function;
		private var	_onGetAirportsSuccess:Function;
		
		public function BackendService(enforcer:SingletonEnforcer){
			_flightsService = initializeService();
			
		}
		
		/**
		 * Static function used to get instance of service.
		 * There is only one instance becaouse it implements singleton pattern.
		 * @return 
		 * 
		 */		
		public static function get instance():BackendService {
			if( ! BackendService._instance ){
				BackendService._instance = new BackendService(new SingletonEnforcer());
			}
			return BackendService._instance; 
		}
		
		private function initializeService():RemoteObject {
			
			var channel:AMFChannel = new AMFChannel("pyamfChannel", URL);
			var channels:ChannelSet = new ChannelSet();
			channels.addChannel(channel);
			
			var remoteObject:RemoteObject = new RemoteObject("FlightsService");  
			remoteObject.showBusyCursor = true;
			remoteObject.channelSet = channels;
			remoteObject.destination = "flightsService"
			remoteObject.addEventListener(FaultEvent.FAULT, onRemoteServiceFault);
			remoteObject.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onRemoteServiceFault);
			
			
			// registering backend methods
			_getPlanesOperation = remoteObject.getOperation("getPlanes");
			_getAirportsOperation = remoteObject.getOperation("getAirports");
			_getFlightsOperation = remoteObject.getOperation("getFlights");
			
			// setting result handlers
			_getPlanesOperation.addEventListener(ResultEvent.RESULT, onGetPlanesResult);
			_getAirportsOperation.addEventListener(ResultEvent.RESULT, onGetAirportsResult);
			_getFlightsOperation.addEventListener(ResultEvent.RESULT, onGetFlightsInfoResult);
			
			return remoteObject;
			
		}
		
		
		public function getPlanes(callback:Function):void {
			_onGetPlanesSuccess = callback;	
			_getPlanesOperation.send();
		}
		
		public function getAirports(callback:Function):void {
			_onGetAirportsSuccess = callback;
			_getAirportsOperation.send();
		}
		
		public function getFlightsInfo(callback:Function):void {
			_onGetFlightsSuccess = callback;
			_getFlightsOperation.send();
		}
		
		
		/*
		 *	Functions handling results from backend and passing data 
		 */
		private function onGetPlanesResult(e:ResultEvent):void {
			_onGetPlanesSuccess(e.result);
		}
		
		private function onGetAirportsResult(e:ResultEvent):void {
			_onGetAirportsSuccess(e.result);
		}

		private function onGetFlightsInfoResult(e:ResultEvent):void {
			_onGetFlightsSuccess(e.result);	
		}
		
		
		/*
		 * Handling service errors and informing user about it.
		 */
		private function onRemoteServiceFault(event:FaultEvent):void {
			var errorMsg:String = "Service error:\n" + event.fault.faultCode;
			Alert.show(event.fault.faultDetail, errorMsg);	
		}
		
		private function onRemoteServiceSecurityError(event:SecurityErrorEvent):void {
			var errorMsg:String = "Service security error";
			Alert.show(event.text, errorMsg);	
		}
		
	}
}

class SingletonEnforcer{}