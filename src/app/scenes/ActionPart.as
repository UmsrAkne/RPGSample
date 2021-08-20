package app.scenes {

    import flash.display.Sprite;
    import app.charas.Party;
    import flash.events.Event;
    import app.gameEvents.GameTextEvent;
    import app.gameEvents.GameEvent;

    public class ActionPart implements IScenePart {

        private var _eventDispatcher:Sprite = new Sprite();
        private var _party:Party;
        private var frameCount:int;

        public function ActionPart() {

        }

        public function get eventDispatcher():Sprite {
            return _eventDispatcher;
        }

        public function start():void {
            _eventDispatcher.addEventListener(Event.ENTER_FRAME, enterFrameEventHandler);
        }

        public function pause():void {
        }

        public function moveForward():void {
        }

        public function set party(value:Party):void {
            _party = value;
        }

        private function enterFrameEventHandler(event:Event):void {
            frameCount++;
        }

        private function dispatchTextEvent(stringVector:Vector.<String>, displayLocation:String):void {
            var textEvent:GameTextEvent = new GameTextEvent(GameEvent.MESSAGE);
            textEvent.displayLocation = displayLocation;
            for each (var t:String in stringVector) {
                textEvent.addLine(t);
            }

            _eventDispatcher.dispatchEvent(textEvent);
        }
    }
}
