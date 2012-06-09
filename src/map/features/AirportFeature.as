package map.features
{
	import dto.Airport;
	
	import flash.display.DisplayObject;
	
	import org.openscales.core.feature.PointFeature;
	import org.openscales.core.style.Rule;
	import org.openscales.core.style.Style;
	import org.openscales.core.style.marker.DisplayObjectMarker;
	import org.openscales.core.style.symbolizer.PointSymbolizer;
	import org.openscales.core.style.symbolizer.Symbolizer;
	import org.openscales.geometry.Point;
	import org.openscales.geometry.basetypes.Location;
	
	/**
	 * Feature opakowujacy lotnisko, reprezentowane na mapie jako kropka. 
	 * @author Adamus
	 * 
	 */	
	public class AirportFeature extends PointFeature {
		
		private var _airport:Airport;
		
		public function AirportFeature(arp:Airport, geom:Point=null, data:Object=null, style:Style=null) {
			super(geom, data, style);
			
			airport = arp;
			if( !geom ){
				this.geometry = new Point(arp.location.x, arp.location.y);
				this.geometry.projection = arp.location.projection;
			}
			
			var rule:Rule = new Rule();
			var symbolizer:PointSymbolizer = new PointSymbolizer();
			rule.symbolizers.push(symbolizer);
			this.style = new Style();
			this.style.rules.push(rule);
		}
		
		override public function get lonlat():Location{
			var value:Location = null;
			if( _airport != null ){
				value = new Location( _airport.location.x, _airport.location.y);
			}
			return value;
		}
		
		override public function draw():void{
			super.draw();
		}
		
		/**
		 * Funkcja odpowiedzialna za rysowanie obiektu. Wywoływana automatycznie za każdym odświerzeniem mapy. 
		 * @param symbolizer
		 * 
		 */		
		override protected function executeDrawing(symbolizer:Symbolizer):void {
			if(!this.layer || !this.layer.map)
				return;
			
			var x:Number;
			var y:Number;
			var resolution:Number = this.layer.map.resolution.value;
			var dX:int = -int(this.layer.map.x) + this.left;
			var dY:int = -int(this.layer.map.y) + this.top;
			
			x = dX + point.x / resolution;
			y = dY - point.y / resolution;
			
			with(this.graphics){
				clear();
				beginFill(0x0000ff, 0.6);
				drawCircle(x, y, 4);
				beginFill(0xffffff, 0.8);
				drawCircle(x, y, 1);
				endFill();
			}
			
			if (symbolizer is PointSymbolizer) {
				var pointSymbolizer:PointSymbolizer = (symbolizer as PointSymbolizer);
				if (pointSymbolizer.graphic) {
					var render:DisplayObject = pointSymbolizer.graphic.getDisplayObject(this);
					render.x += x;
					render.y += y;
					this.addChild(render);
				}
			}
		}
		
		
		
		
		public function get airport():Airport {
			return _airport;
		}

		public function set airport(value:Airport):void {
			_airport = value;
		}

	}
}