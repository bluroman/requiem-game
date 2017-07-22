package actors {
	
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import game.Assets;
	import game.Constants;
	import net.flashpunk.utils.Ease;
	
	public class Finish extends Entity {
		
		protected var emitter:Emitter;
		
		public function Finish(xpos:Number, ypos:Number) {
			x = xpos;
			y = ypos;
			
			setHitbox(Constants.PORTAL_SIZE * Constants.PORTAL_SCALE, Constants.PORTAL_SIZE * Constants.PORTAL_SCALE);
			type = Constants.FINISH;
			
			emitter = new Emitter(new BitmapData(4, 4), 4, 4);
			emitter.newType("shiny", [0]);
			emitter.setAlpha("shiny", 1, 0.5);
			emitter.setMotion("shiny", 0, Constants.PORTAL_SIZE, 2.4, 360);
			emitter.setColor("shiny", 0xFFF8E3, 0x3F80A8, Ease.circInOut);
			emitter.relative = false;
			
			graphic = emitter;
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < 2; i++) {
				emitter.emit("shiny", centerX, centerY);
			}
		}
		
	}

}