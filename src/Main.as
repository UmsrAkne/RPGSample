package {
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import app.userInteFace.WindowInfo;

    /**
     * ...
     * @author
     */
    public class Main extends Sprite {

        public function Main() {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            // 1280 * 720 ウィンドウ部分のサイズ + ui のサイズ

            stage.nativeWindow.width = 1296;
            stage.nativeWindow.height = 759;

            WindowInfo.width = 1280;
            WindowInfo.height = 720;
        }
    }
}
