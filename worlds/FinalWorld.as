package worlds {
	
	import hud.AnimatedMessage;
	import net.flashpunk.World;
	import game.LevelData;
	import game.Constants;
	import actors.Chronometer;
	import net.flashpunk.FP;
	import com.newgrounds.API;
	
	public class FinalWorld extends World {
		
		protected var xpos:Number;
		
		public function FinalWorld():void {
			xpos = 40;
		}
		
		override public function begin():void {
			super.begin();
			add(new AnimatedMessage(FP.halfWidth, 50, "YOU WIN!", 64, 0x02DAD8, 0x00FFFF, Constants.NONE_ANIMATION));
			add(new AnimatedMessage(FP.halfWidth, 120, "TIME: " + Chronometer.timeToText(LevelData.getTotalTime()), 48, 0xFF69B4, 0x2222AA, Constants.NONE_ANIMATION));
			add(new AnimatedMessage(FP.halfWidth, 160, "DEATHS: " + LevelData.getDeaths(), 48, 0xFF69B4, 0x2222AA, Constants.NONE_ANIMATION));
			add(new AnimatedMessage(FP.halfWidth, 380, "I HOPE YOU ENJOYED THE GAME (:", 32, 0x00BFFF, 0x2F4F4F, Constants.NONE_ANIMATION));
			add(new AnimatedMessage(FP.halfWidth, 420, "FOLLOW ME FOR MORE GAMES", 32, 0x00BFFF, 0x2F4F4F, Constants.NONE_ANIMATION));
			add(new AnimatedMessage(FP.halfWidth, 460, "BYE!", 32, 0x00BFFF, 0x2F4F4F, Constants.NONE_ANIMATION));
			API.postScore(Constants.DEATH_SCOREBOARD, LevelData.getDeaths());
			API.postScore(Constants.TIME_SCOREBOARD, LevelData.getTotalTime() * 1000);
		}
		
	}

}