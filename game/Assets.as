package game {
	
	public class Assets {
		// credits
		[Embed(source = "../../doc/credits.txt", mimeType = "application/octet-stream")] public static const CREDITS:Class;
		
		// the player graphic
		[Embed(source = "../../res/img/orangebox.png")] public static const PLAYER:Class;
		
		// the finish area image
		[Embed(source = "../../res/img/finish.png")] public static const FINISH:Class;
		
		// backdrop
		[Embed(source = "../../res/img/backdrop.png")] public static const BACKDROP_GRAPHICS:Class;
		
		// menu input controls
		[Embed(source = "../../res/img/input.png")] public static const INPUTHUD:Class;
		
		// main music
		[Embed(source = "../../res/sfx/music.mp3")] public static const MUSIC:Class;
		
		// portal effect
		[Embed(source = "../../res/sfx/portal.mp3")] public static const PORTAL_SOUND:Class;
		
		// explosion sound
		[Embed(source = "../../res/sfx/explosion.mp3")] public static const EXPLOSION_SOUND:Class;
		
		// choice
		[Embed(source = "../../res/sfx/choice.mp3")] public static const CHOICE:Class;
		
		// particles
		[Embed(source = "../../res/img/particle.png")] public static const PARTICLE:Class;
	}
	
}