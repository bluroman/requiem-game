package actors {
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	
	public class Chronometer extends Entity {
		
		public var time:Number;
		public var display:Text;
		public var isRunning:Boolean;
		
		public function Chronometer():void {
			time = 0;
			isRunning = true;
			
			display = new Text(timeToText(time));
			display.size = 64;
			display.color = 0x02EC02;
			display.scrollX = display.scrollY = 0;
			display.x = 0;
			display.y = 0;
			
			setHitbox(display.width, display.height);
			
			x = display.x;
			y = display.y;
			graphic = display;
		}
		
		public static function timeToText(timet:Number):String {
			var minutes:int = (timet / 60) % 60;
			var seconds:int = timet % 60;
			var minutesString:String = minutes < 10 ? "0" + minutes : "" + minutes;
			var secondsString:String = seconds < 10 ? "0" + seconds : "" + seconds;
			var str:String = minutesString + ":" + secondsString;
			return str;
		}
		
		override public function update():void {
			super.update();
			
			if (isRunning) {
				time += FP.elapsed;
				display.text = timeToText(time);
			}
		}
	}

}