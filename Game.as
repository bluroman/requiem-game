package {
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.MenuWorld;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import game.Constants;
	
	public class Game extends Engine {
		
		public function Game():void {
			super(640, 480);
		}
		
		override public function init():void {
			super.init();
			Input.define(Constants.UP, Key.UP, Key.W);
			Input.define(Constants.DOWN , Key.DOWN, Key.S);
			Input.define(Constants.LEFT, Key.LEFT, Key.A);
			Input.define(Constants.RIGHT, Key.RIGHT, Key.D);
			FP.screen.color = 0x070C1F;
			FP.world = new MenuWorld();
		}
	}
	
}