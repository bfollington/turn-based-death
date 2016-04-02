package {

    import flash.display.Screen;
    import flash.display.StageDisplayState;
    import flash.display.StageQuality;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import net.flashpunk.Engine;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    import worlds.DemoRoom;

    [SWF(width = 640, height = 360, frameRate = 60, backgroundColor = "#000000")]

	public class Main extends Engine {

		public static const ASPECT_RATIO:Number = 640/360;

		public static const DEBUG: Boolean = true;

		public static var resolution: Point;

		public static var windowChrome: Point;

		public static const FRAMERATE: uint = 30;

		public function Main () {
			super(C.WIDTH, C.HEIGHT, FRAMERATE, false);

            stage.frameRate = FRAMERATE;
			stage.quality = StageQuality.LOW;

            FP.screen.scale = 1;
            FP.screen.smoothing = false;

			resolution = new Point(640, 360);
			windowChrome = new Point(0, 0);

			FP.world = new DemoRoom();

			setInputDefinitions();

            trace("Running from " + File.applicationDirectory.nativePath);
		}

		override public function update(): void {
			super.update();

			if (Input.pressed(Key.F5)) {
				Main.changeResolution(640, 360);
			}

			if (Input.pressed(Key.F6)) {
				Main.changeResolution(1280, 720);
			}

			if (Input.pressed(Key.F7)) {
				Main.changeResolution(1440, 810);
			}

			if (Input.pressed(Key.F8)) {
				Main.changeResolution(1680, 945);
			}

			if (Input.pressed(Key.F9)) {
				Main.changeResolution(1920, 1080);
			}

			if (Input.pressed(Key.F10)) {
				Main.enterFullscreen();
			}
		}

		override public function init():void {
			super.init();

			// Calculate window borders for resizing
			windowChrome.x = FP.stage.nativeWindow.width - FP.stage.stageWidth;
			windowChrome.y = FP.stage.nativeWindow.height - FP.stage.stageHeight;


			if (DEBUG) {
				// Backtick
				FP.console.enable();
				FP.console.toggleKey = 192;
			}

			centreApp();
		}

		private function centreApp():void
		{
			var screenBounds:Rectangle = Screen.mainScreen.visibleBounds;
			var w:int = stage.nativeWindow.width;
			var h:int = stage.nativeWindow.height;

			var x:int = screenBounds.x + ((screenBounds.width-w)/2);
			var y:int = screenBounds.y + ((screenBounds.height-h)/2);
			stage.nativeWindow.x = x;
			stage.nativeWindow.y = y;

			visible = true;
		}

		public static function enterFullscreen(): void {
			FP.stage.fullScreenSourceRect = new Rectangle(0, 0, resolution.x, resolution.y);
			FP.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}

		public static function isFullscreen(): Boolean {
			return FP.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE || FP.stage.displayState == StageDisplayState.FULL_SCREEN;
		}

		public static function exitFullscreen(): void {
			FP.stage.displayState = StageDisplayState.NORMAL;
		}

		public static function changeResolution(width: uint, height: uint): void {
			var wasFullscreen: Boolean = isFullscreen();

			if (wasFullscreen) {
				exitFullscreen();
			}

			resolution.x = width;
			resolution.y = height;
			FP.stage.nativeWindow.width = resolution.x + windowChrome.x;
			FP.stage.nativeWindow.height = resolution.y + windowChrome.y;

			resize();

			if (wasFullscreen) {
				enterFullscreen();
			}
		}

		/**
		 * Set up the input definition names, initial config.
		 *
		 */
		private function setInputDefinitions():void
		{
			Input.define("Right", Key.RIGHT);
			Input.define("Left", Key.LEFT);
			Input.define("Up", Key.UP);
			Input.define("Down", Key.DOWN);
			Input.define("Jump", Key.UP);
			Input.define("Use", Key.A);
			Input.define("Interact", Key.DOWN);
			Input.define("Cancel", Key.S);
		}

		/**
		 * The world's best resize function! Maintains aspect ratio and scales perfectly.
		 * Also; supports full screen. Yeah boiiii
		 * @param e Event
		 */
		private static function resize(e:Event = null):void
		{
			if (FP.stage.stageWidth / FP.stage.stageHeight < ASPECT_RATIO)
			{
				FP.screen.scale = FP.stage.stageWidth / C.WIDTH;
			} else {
				FP.screen.scale = FP.stage.stageHeight / C.HEIGHT;
			}

			FP.screen.smoothing = false;

			FP.screen.x = (FP.stage.stageWidth - C.WIDTH*(FP.screen.scale)) / 2;
			FP.screen.y = (FP.stage.stageHeight - C.HEIGHT*(FP.screen.scale)) / 2;
		}
	}

}
