package actors {
	
	import game.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	
	public class Background extends Entity {
		
		protected var backdrop:Backdrop;
		public function Background():void {
			backdrop = new Backdrop(Assets.BACKDROP_GRAPHICS);
			
			graphic = backdrop;
			graphic.scrollX = 0.5;
			graphic.scrollY = 0.5;
			layer = 100;
		}
		
		override public function update():void {
			super.update();
			x -= FP.elapsed * 20;
			y -= FP.elapsed * 20;
		}
		
	}

}