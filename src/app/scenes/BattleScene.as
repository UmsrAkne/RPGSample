package app.scenes {

    import flash.display.Sprite;
    import flash.events.Event;
    import app.charas.Party;
    import app.charas.Character;
    import app.coms.TargetType;
    import app.gameEvents.GameEvent;
    import app.gameEvents.GameTextEvent;

    public class BattleScene extends Sprite {

        private var sceneParts:Vector.<IScenePart> = new Vector.<IScenePart>();
        private var currentPartIndex:int;
        private var _party:Party;
        private var ui:UI = new UI();

        public function BattleScene() {
        }

        public function start():void {
            if (sceneParts.length == 0) {
                return;
            }

            sceneParts[currentPartIndex].start();
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

        private function showText(e:GameTextEvent):void {
            switch (e.displayLocation) {
                case GameTextEvent.COMMAND_WINDOW:
                    ui.commandWindow.text = e.text;
                    break;
                case GameTextEvent.SIDE_COMMAND_WINDOW:
                    ui.sideCommandWindow.text = e.text;
                    break;
                case GameTextEvent.MESSAGE_WINDOW:
                    ui.messageWindow.text = ui.messageWindow.text + "\n" + e.text;
                    break;
                case GameTextEvent.STATUS_WINDOW:
                    ui.statusWindow.text = e.text;
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

        private function finish():void {
            // 戦闘の終了処理
        }

    }
}
