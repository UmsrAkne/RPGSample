package app.scenes {

    import flash.display.Sprite;
    import app.charas.Party;
    import app.charas.Character;
    import app.coms.TargetType;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import app.gameEvents.GameEvent;
    import app.gameEvents.GameTextEvent;
    import app.coms.CommandManager;
    import flash.events.Event;

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
            friends = _party.getMembers(TargetType.FRIEND);
            enemys = _party.getMembers(TargetType.ENEMY);
            commandUnselectedFriends = _party.getMembers(TargetType.FRIEND);

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
            var currentCM:CommandManager = commandUnselectedFriends[0].commandManager
            currentCM.select(index);

            if (commandUnselectedFriends.length <= 1 && currentCM.commandSelected) {
                _eventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
                return;
            }

            if (currentCM.commandSelected) {
                commandUnselectedFriends.shift();
                dispatchTextEvent(commandUnselectedFriends[0].commandManager.commandNames, GameTextEvent.COMMAND_WINDOW);
            } else {
                dispatchTextEvent(commandUnselectedFriends[0].commandManager.commandNames, GameTextEvent.SIDE_COMMAND_WINDOW);
            }
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
    }
}
