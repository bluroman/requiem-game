package actors {
	
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import game.Assets;
	import game.Constants;
	
	public class Player extends Entity {
		
		private const SPEED:Number = 8;
		private const EXPLOSION_SIZE:uint = 100;
		private const RUN_SIZE:uint = 1;
		
		public var sprite:Image;
		public var emitter:Emitter;
		public var vx:Number;
		public var vy:Number;
		public var animationTween:NumTween;
		
		public function Player(xpos:Number, ypos:Number):void {
			super(xpos, ypos);
			type = "player";
			
			sprite = new Image(Assets.PLAYER);
			sprite.centerOrigin();
			setHitbox(sprite.width * Constants.PLAYER_SCALE, sprite.height * Constants.PLAYER_SCALE);
			centerOrigin();
			
			vx = 0;
			vy = 0;
			
			emitter = new Emitter(Assets.PARTICLE, 32, 32);
			
			emitter.newType(Constants.RUN, [0, 1, 2, 3, 4, 5]);
			emitter.setAlpha(Constants.RUN, 0.5, 0, Ease.circInOut);
			emitter.setMotion(Constants.RUN, 0, 30, 0.5, 360, 20, 0.5, Ease.cubeInOut);
			
			emitter.relative = false;
			
			animationTween = new NumTween();
			animationTween.tween(1, 0, 1);
			animationTween.active = false;
			addTween(animationTween);
			
			graphic = new Graphiclist(emitter, sprite);
		}
		
		public function move():void {
			if (Input.pressed(Constants.UP)) {
				vy = -SPEED;
				vx = 0;
			} else if (Input.pressed(Constants.DOWN)) {
				vy = SPEED;
				vx = 0;
			} else if (Input.pressed(Constants.LEFT)) {
				vy = 0;
				vx = -SPEED;
			} else if (Input.pressed(Constants.RIGHT)) {
				vy = 0;
				vx = SPEED;
			}
			
			if (Constants.DEBUG) {
				moveBy(vx, vy, Constants.MAP);
			} else {
				moveBy(vx, vy);
			}
			
			for (var i:uint = 0; i < RUN_SIZE; i++) {
				emitter.emit(Constants.RUN, centerX - 16, centerY - 16);
			}
		}
		
		override public function update():void {
			super.update();
			if (animationTween.active) {
				sprite.alpha = animationTween.value;
				sprite.scale += animationTween.value * 0.01;
			}
		}
		
		public function teleport():void {
			collidable = false;
			animationTween.start();
		}
		
		public function kill():void {
			collidable = false;
			sprite.visible = false;
		}
		
	}

}