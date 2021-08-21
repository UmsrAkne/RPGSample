package app.scenes {

    import flash.display.Sprite;
    import app.charas.Party;
    import flash.events.Event;
    import app.gameEvents.GameTextEvent;
    import app.gameEvents.GameEvent;
    import app.charas.Character;
    import app.coms.TargetType;

    public class ActionPart implements IScenePart {

        private var _eventDispatcher:Sprite = new Sprite();
        private var _party:Party;
        private var frameCount:int;
        private var waitingCharacters:Vector.<Character> = new Vector.<Character>();

        public var longWait:int = 16;
        public var shortWait:int = 8;

        public function ActionPart() {
        }

        public function get eventDispatcher():Sprite {
            return _eventDispatcher;
        }

        public function start():void {
            waitingCharacters = _party.getMembers(TargetType.ALL);
            for each (var c:Character in waitingCharacters) {
                c.actionManager.eventDispatcher.addEventListener(GameEvent.MESSAGE, receiveReaction);
            }

            _eventDispatcher.addEventListener(Event.ENTER_FRAME, enterFrameEventHandler);
        }

        public function pause():void {
            _eventDispatcher.removeEventListener(Event.ENTER_FRAME, enterFrameEventHandler);
        }

        public function moveForward():void {
        }

        public function set party(value:Party):void {
            _party = value;
        }

        private function enterFrameEventHandler(event:Event):void {
            frameCount++;
            if (frameCount % longWait == 0) {
                if (waitingCharacters.length == 0) {
                    _eventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
                    return;
                }

                waitingCharacters[0].actionManager.act();
                waitingCharacters.shift();
            }
        }

        private function receiveReaction(e:GameTextEvent):void {
            var newEv:GameTextEvent = new GameTextEvent(GameEvent.MESSAGE);
            newEv.copyPropeties(e);

            // 詳細は不明だが、引数で回ってきた event を再度送出することができない
            // (target が関係？)
            // このため、新しいイベントを生成して、そこにプロパティをコピーし、それを送出する。

            _eventDispatcher.dispatchEvent(newEv);
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
