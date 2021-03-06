package app.scenes {

    import flash.display.Sprite;
    import flash.events.Event;
    import app.charas.Party;
    import app.charas.Character;
    import app.coms.TargetType;
    import app.gameEvents.GameEvent;
    import app.gameEvents.GameTextEvent;
    import flash.events.KeyboardEvent;
    import app.userInteFace.UI;

    public class BattleScene extends Sprite {

        private var sceneParts:Vector.<IScenePart> = new Vector.<IScenePart>();
        private var currentPartIndex:int;
        private var _party:Party;
        private var _ui:UI = new UI();

        public function BattleScene() {
        }

        public function start():void {
            if (sceneParts.length == 0) {
                return;
            }

            sceneParts[currentPartIndex].start();
            addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
            addEventListener(Event.ENTER_FRAME, enterFrameEventHandler);
        }

        private function startNextPart(e:Event):void {
            sceneParts[currentPartIndex].pause();

            if (!_party.canBattle()) {
                // IScenePart の終了イベントの送出は、パートの全終了時だけでなく、
                // 戦闘継続不可(敵か味方の全滅)時にも送出されるため、都度確認する。

                finish();
                return;
            }

            currentPartIndex++;
            currentPartIndex = (currentPartIndex >= sceneParts.length) ? 0 : currentPartIndex;
            sceneParts[currentPartIndex].start();
        }

        public function addPart(part:IScenePart):void {
            sceneParts.push(part);
            part.eventDispatcher.addEventListener(Event.COMPLETE, startNextPart);
            part.eventDispatcher.addEventListener(GameEvent.MESSAGE, showText);
        }

        public function keyboardEventHandler(e:KeyboardEvent):void {
            sceneParts[currentPartIndex].pressKey(e);
        }

        public function enterFrameEventHandler(e:Event):void {
            sceneParts[currentPartIndex].enterFrameProcess();
        }

        private function showText(e:GameTextEvent):void {
            switch (e.displayLocation) {
                case GameTextEvent.COMMAND_WINDOW:
                    _ui.commandWindow.text = e.text;
                    break;
                case GameTextEvent.SIDE_COMMAND_WINDOW:
                    _ui.sideCommandWindow.text = e.text;
                    break;
                case GameTextEvent.MESSAGE_WINDOW:
                    _ui.messageWindow.text = _ui.messageWindow.text + "\n" + e.text;
                    break;
                case GameTextEvent.STATUS_WINDOW:
                    _ui.statusWindow.text = e.text;
                    break;
                default:
                    throw new Error("GameTextEvent.displayLocation が不正な値です");
                    break;
            }
        }

        /**
         * 内部の _party に一度だけセットが可能。
         * @param value
         */
        public function set party(value:Party):void {
            if (!_party) {
                _party = value;
            }
        }

        public function get ui():UI {
            return _ui;
        }

        private function finish():void {
            // 戦闘の終了処理
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}
