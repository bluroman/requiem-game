package hud {
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	public class FloatingText extends Entity {
		
		protected var duration:uint;
		protected var title:String;
		protected var text:Text;
		protected var alphaTween:NumTween;
		
		public function FloatingText(title:String, size:uint = 48, duration:uint = 3):void {
			this.title = title;
			this.duration = duration;
			
			text = new Text(this.title);
			text.size = size;
			text.scrollX = 0;
			text.scrollY = 0;
			
			alphaTween = new NumTween(disappeared);
			alphaTween.tween(1, 0, this.duration, Ease.cubeIn);
			addTween(alphaTween);
			alphaTween.start();
			
			x = FP.halfWidth - text.width / 2;
			y = 60;
			
			graphic = text;
			layer = 0;
		}
		
		override public function update():void {
			super.update();
			text.alpha = alphaTween.value;
		}
		
		public function disappeared():void {
			FP.world.recycle(this);
		}
		
	}

}