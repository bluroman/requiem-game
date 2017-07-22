package hud {
	
	import net.flashpunk.FP;
	import game.Constants;
	
	public class SystemMessage extends AnimatedMessage {
		
		public function SystemMessage(string:String = "") {
			super(FP.halfWidth, 200, string, 48, 0xC7D5E2, 0x7294AD, Constants.NONE_ANIMATION);
		}
		
	}

}