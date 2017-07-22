package worlds {
	
	import actors.Chronometer;
	import hud.FloatingText;
	import hud.SystemMessage;
	import actors.Finish;
	import actors.Map;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import game.Assets;
	import actors.Player;
	import game.Constants;
	import game.LevelData;
	
	public class GameWorld extends World {
		
		protected const STATE_RUNNING:uint = 0;
		protected const STATE_FAILURE:uint = 1;
		protected const STATE_SUCCESS:uint = 2;
		protected const STATE_RESTART:uint = 3;
		
		protected var initialPoint:Point;
		protected var player:Player;
		protected var finish:Finish;
		protected var levelName:String;
		protected var map:Map;
		protected var mapGrid:Grid;
		protected var mapImage:Graphic;
		protected var mapData:Class;
		protected var gameState:uint;
		protected var trailEmitter:Emitter;
		protected var ghost:Entity;
		protected var chronometer:Chronometer;
		
		public function GameWorld(mapData:Class):void {
			this.mapData = mapData;
			gameState = STATE_RUNNING;
			
			loadMap(this.mapData);
			
			if (mapImage == null) {
				var mi:Image = new Image(mapGrid.data);
				mi.scale = 16;
				mi.color = 0x244AAD;
				mapImage = mi;
			}
			
			map = new Map(mapImage, mapGrid);
			
			chronometer = new Chronometer();
		}
		
		override public function begin():void {
			super.begin();
			
			FP.screen.smoothing = true;
			
			add(map);
			add(finish);
			add(player);
			
			add(new FloatingText(levelName));
			add(chronometer);
		}
		
		protected function centerScreenAt(cx:int, cy:int):void {
			camera.x = cx - FP.screen.width * 0.5;
			camera.y = cy - FP.screen.height * 0.5;
		}
		
		protected function updateRunningState():void {
			player.move();
			centerScreenAt(player.x, player.y);
			
			if (map.collideWith(player, 0, 0)) {
				if (!Constants.DEBUG) {
					setGameState(STATE_FAILURE);
				}
			}
			
			var finish:Finish = Finish(player.collide(Constants.FINISH, player.x, player.y));
			if (finish != null) {
				setGameState(STATE_SUCCESS);
			}
		}
		
		protected function updateFailureState():void {
			if (Input.pressed(Constants.UP)) {
				ghost = new Entity(player.x, player.y);
				setGameState(STATE_RESTART);
			}
		}
		
		protected function updateSuccessState():void {
			if (Input.pressed(Constants.UP)) {
				var nxtlvl:Class = LevelData.nextLevel();
				if (nxtlvl != null) {
					FP.world = new GameWorld(nxtlvl);
				} else {
					FP.world = new FinalWorld();
				}
			}
		}
		
		protected function updateRestartState():void {
			var dir:Point = initialPoint.subtract(new Point(ghost.x, ghost.y));
			dir.normalize(1);
			
			ghost.x += dir.x * Constants.GHOST_SPEED;
			ghost.y += dir.y * Constants.GHOST_SPEED;
			centerScreenAt(ghost.x, ghost.y);
			
			if (FP.distance(ghost.x, ghost.y, initialPoint.x, initialPoint.y) <= 8) {
				FP.world = new GameWorld(LevelData.getCurrentLevel());
			}
		}
		
		protected function setGameState(state:uint):void {
			gameState = state;
			
			switch (gameState) {
				case STATE_RUNNING:
					break;
				case STATE_FAILURE:
					player.kill();
					chronometer.isRunning = false;
					LevelData.updateTime(chronometer.time);
					var explosionFX:Sfx = new Sfx(Assets.EXPLOSION_SOUND);
					explosionFX.play();
					LevelData.incrementDeaths();
					add(new SystemMessage("DEATH COUNTER: " + LevelData.getDeaths() +  "\nPRESS UP TO RETRY!"));
					break;
				case STATE_SUCCESS:
					player.teleport();
					chronometer.isRunning = false;
					LevelData.updateTime(chronometer.time);
					var teleportFX:Sfx = new Sfx(Assets.PORTAL_SOUND);
					teleportFX.play();
					add(new SystemMessage("PRESS UP TO ADVANCE!"));
					break;
				case STATE_RESTART:
					break;
				default: break;
			}
		}
		
		override public function update():void {
			super.update();
			
			switch (gameState) {
				case STATE_RUNNING:
					updateRunningState();
					break;
				case STATE_FAILURE:
					updateFailureState();
					break;
				case STATE_SUCCESS:
					updateSuccessState();
					break;
				case STATE_RESTART:
					updateRestartState();
					break;
				default: break;
			}
		}
		
		protected function loadMap(mapData:Class):void {
			var mapXML:XML = FP.getXML(mapData);
			var node:XML = null;
			
			levelName = mapXML.@LevelName;
			mapGrid = new Grid(uint(mapXML.@width), uint(mapXML.@height), 16, 16, 0, 0);
			mapGrid.loadFromString(String(mapXML.Grid), "", "\n");
			player = new Player(int(mapXML.Entities.PlayerStart.@x), int(mapXML.Entities.PlayerStart.@y));
			finish = new Finish(int(mapXML.Entities.Finish.@x), int(mapXML.Entities.Finish.@y));
			initialPoint = new Point(player.x, player.y);
		}
	}
	
}