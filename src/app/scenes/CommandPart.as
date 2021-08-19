package app.scenes {

    import flash.display.Sprite;
    import app.charas.Party;
    import app.charas.Character;
    import app.coms.TargetType;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import app.gameEvents.GameEvent;
    import app.gameEvents.GameTextEvent;

    public class CommandPart implements IScenePart {

        private var _eventDispatcher:Sprite = new Sprite();
        private var _party:Party = new Party();

        private var friends:Vector.<Character>;
        private var enemys:Vector.<Character>;
        private var commandUnselectedFriends:Vector.<Character>;
        private var cursorIndex:int;

        public function CommandPart() {
        }

        public function get eventDispatcher():Sprite {
            return _eventDispatcher;
        }

        public function start():void {
            friends = party.getMembers(TargetType.FRIEND);
            enemys = party.getMembers(TargetType.ENEMY);
            commandUnselectedFriends = party.getMembers(TargetType.FRIEND);

            dispatchTextEvent(commandUnselectedFriends[0].commandManager.commandNames, GameTextEvent.COMMAND_WINDOW);

            _eventDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
        }

        public function pause():void {
            _eventDispatcher.removeEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
        }

        private function keyboardEventHandler(e:KeyboardEvent):void {
            switch (e.keyCode) {
                case Keyboard.DOWN:
                    cursorIndex++;
                    break;

                case Keyboard.UP:
                    if (cursorIndex > 0) {
                        cursorIndex--;
                    }
                    break;

                case Keyboard.ENTER:
                    decideCommand(cursorIndex);
                    break;

                default:
                    break;
            }
        }

        public function decideCommand(index:int):void {
        }

        public function set party(value:Party):void {
            _party = value;
        }

        private function dispatchTextEvent(stringVector:Vector.<String>, displayLocation:String):void {
            var textEvent:GameTextEvent = new GameTextEvent(GameEvent.MESSAGE);
            textEvent.displayLocation = displayLocation;
            for each (var t:String in stringVector) {
                textEvent.addLine(t);
            }

            _eventDispatcher.dispatchEvent(textEvent);
        }

        private function get party():Party {
            return _party;
        }
    }
}
