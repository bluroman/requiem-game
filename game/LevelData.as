package game {
	
	public class LevelData {
		
		[Embed(source = "../../res/ogmo/level_0.oel", mimeType = "application/octet-stream")] public static const LEVEL_0:Class;
		[Embed(source = "../../res/ogmo/level_1.oel", mimeType = "application/octet-stream")] public static const LEVEL_1:Class;
		[Embed(source = "../../res/ogmo/level_2.oel", mimeType = "application/octet-stream")] public static const LEVEL_2:Class;
		[Embed(source = "../../res/ogmo/level_3.oel", mimeType = "application/octet-stream")] public static const LEVEL_3:Class;
		[Embed(source = "../../res/ogmo/level_4.oel", mimeType = "application/octet-stream")] public static const LEVEL_4:Class;
		[Embed(source = "../../res/ogmo/level_5.oel", mimeType = "application/octet-stream")] public static const LEVEL_5:Class;
		[Embed(source = "../../res/ogmo/level_6.oel", mimeType = "application/octet-stream")] public static const LEVEL_6:Class;
		[Embed(source = "../../res/ogmo/level_7.oel", mimeType = "application/octet-stream")] public static const LEVEL_7:Class;
		[Embed(source = "../../res/ogmo/level_8.oel", mimeType = "application/octet-stream")] public static const LEVEL_8:Class;
		[Embed(source = "../../res/ogmo/level_9.oel", mimeType = "application/octet-stream")] public static const LEVEL_9:Class;
		[Embed(source = "../../res/ogmo/level_10.oel", mimeType = "application/octet-stream")] public static const LEVEL_10:Class;
		
		private static var levelList:Vector.<Class> = new Vector.<Class>;
		private static var currentLevel:uint = 0;
		private static var deaths:uint = 0;
		private static var totalTime:Number = 0;
		
		public static function getDeaths():uint {
			return deaths;
		}
		
		public static function incrementDeaths():void {
			deaths += 1;
		}
		
		public static function getLevelCounter():uint {
			return currentLevel;
		}
		
		public static function getCurrentLevel():Class {
			return LevelData["LEVEL_" + currentLevel];
		}
		
		public static function nextLevel():Class {
			currentLevel++;
			return getCurrentLevel();
		}
		
		public static function updateTime(time:Number):void {
			totalTime += time;
		}
		
		public static function getTotalTime():Number {
			return totalTime;
		}
		
		public static function resetDefaults():void {
			currentLevel = 0;
			deaths = 0;
			totalTime = 0;
		}
		
	}

}