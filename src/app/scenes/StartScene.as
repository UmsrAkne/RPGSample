package app.scenes {

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.geom.Rectangle;
    import flash.ui.Keyboard;

    public class StartScene extends Sprite {

        private var background:Bitmap;

        public function StartScene() {
        }

        /** シーンを開始します */
        public function start(sceneSize:Rectangle):void {
            background = new Bitmap(new BitmapData(sceneSize.width, sceneSize.height, false, 0x0));
            addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
        }

        /** このシーンを完了します */
        public function exitScene():void {
            // ゲームを開始する処理
            removeEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function keyboardEventHandler(e:KeyboardEvent):void {
            if (e.keyCode == Keyboard.ENTER) {
                exitScene();
            }
        }
    }
}
