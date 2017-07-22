package worlds {
	
	import actors.Player;
	import game.Credits;
	import game.Lore;
	import hud.AnimatedMessage;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import game.Constants;
	import net.flashpunk.utils.Input;
	import game.LevelData;
	import game.Assets;
	
	public class MenuWorld extends World {
		
		protected var music:Sfx;
		protected var title:AnimatedMessage;
		protected var start:AnimatedMessage;
		protected var creditsButton:AnimatedMessage;
		protected var credits:AnimatedMessage;
		protected var author:AnimatedMessage;
		protected var controls:AnimatedMessage;
		protected var creditsData:Credits;
		protected var fade:Image;
		protected var inputHUD:Image;
		protected var fadeTween:VarTween;
		
		public function MenuWorld():void {
			title = new AnimatedMessage(FP.halfWidth, 40, "Requiem", 64, 0x02DAD8, 0x00FFFF, Constants.NONE_ANIMATION);
			author = new AnimatedMessage(FP.halfWidth, 100, "A Game by KeizerZilla", 44, 0x819850, 0x627935, Constants.NONE_ANIMATION);
			controls = new AnimatedMessage(FP.halfWidth, 200, "-- CONTROLS --", 32, 0xFF69B4, 0x2222AA, Constants.NONE_ANIMATION);
			
			start = new AnimatedMessage(FP.halfWidth, 420, "Press UP to START", 32, 0x00BFFF, 0x2F4F4F, Constants.NONE_ANIMATION);
			creditsButton = new AnimatedMessage(FP.halfWidth, 460, "Press DOWN to view CREDITS", 32, 0x00BFFF, 0x2F4F4F, Constants.NONE_ANIMATION);
			
			inputHUD = new Image(Assets.INPUTHUD);
			inputHUD.y = 220;
			inputHUD.x = FP.halfWidth - (inputHUD.width / 2);
			
			creditsData = new Credits();
			credits = new AnimatedMessage(FP.halfWidth, FP.halfHeight - 55, creditsData.toString(), 24, 0xFFFF00, 0x000000, Constants.NONE_ANIMATION);
			credits.visible = false;
			
			fade = Image.createRect(FP.width, FP.height, 0x000000);
			fade.alpha = 0;
			fade.scrollX = fade.scrollY = 0;
			fadeTween = new VarTween(startGame);
		}
		
		override public function begin():void {
			super.begin();
			add(title);
			add(author);
			add(controls);
			add(start);
			add(creditsButton);
			add(credits);
			addGraphic(inputHUD);
			addGraphic(fade);
			addTween(fadeTween);
		}
		
		public function startGame():void {
			if (!Constants.DEBUG) {
				music = new Sfx(Assets.MUSIC);
				music.loop();
			}
			LevelData.resetDefaults();
			FP.world = new GameWorld(LevelData.getCurrentLevel());
		}
		
		override public function update():void {
			super.update();
			
			if (Input.pressed(Constants.UP)) {
				var choice:Sfx = new Sfx(Assets.CHOICE);
				choice.play();
				fadeTween.tween(fade, "alpha", 1, 1.8);
			} else if (Input.pressed(Constants.DOWN)) {
				title.visible = !title.visible;
				author.visible = !author.visible;
				credits.visible = !credits.visible;
				controls.visible = !controls.visible;
				inputHUD.visible = !inputHUD.visible;
			}
		}
		
	}

}