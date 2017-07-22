package {
	
    import com.newgrounds.*;
    import com.newgrounds.components.*;
    import flash.display.MovieClip;
	import flash.media.SoundTransform;
	import game.Constants;
	
    public class Preloader extends MovieClip {
		
		private const id:String = Constants.GAMEID;
		private const key:String = Constants.ENCRYPTKEY;
		
        public function Preloader():void {
            var apiConnector:APIConnector = new APIConnector();
            apiConnector.className = "Main";
            apiConnector.apiId = id;
            apiConnector.encryptionKey = key;
            addChild(apiConnector);
			
            if (stage) {
                apiConnector.x = (stage.stageWidth - apiConnector.width) / 2;
                apiConnector.y = (stage.stageHeight - apiConnector.height) / 2;
            }
			
			var medalPopup:MedalPopup = new MedalPopup();
			medalPopup.soundTransform = new SoundTransform(0);
			addChild(medalPopup);
        }    
    }
}