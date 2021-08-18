package app.scenes {

    import flash.display.Sprite;

    public class CommandPart implements IScenePart {

        private var _eventDispatcher:Sprite = new Sprite();

        public function CommandPart() {
        }

        public function get eventDispatcher():Sprite {
            return _eventDispatcher;
        }

        public function start():void {
        }

        public function pause():void {
        }
    }
}
