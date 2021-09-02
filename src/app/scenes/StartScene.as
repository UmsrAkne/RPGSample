package app.scenes {

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class StartScene extends Sprite {
        public function StartScene() {
        }

        /** シーンを開始します */
        public function start():void {
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
