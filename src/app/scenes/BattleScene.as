package app.scenes {

    import flash.display.Sprite;
    import flash.events.Event;
    import app.charas.Party;
    import app.charas.Character;
    import app.coms.TargetType;

    public class BattleScene extends Sprite {

        private var sceneParts:Vector.<IScenePart> = new Vector.<IScenePart>();
        private var currentPartIndex:int;
        private var _party:Party;

        public function BattleScene() {
        }

        public function start():void {
            if (sceneParts.length == 0) {
                return;
            }

            sceneParts[currentPartIndex].eventDispatcher.addEventListener(Event.COMPLETE, startNextPart);
            sceneParts[currentPartIndex].start();
        }

        private function startNextPart(e:Event):void {
            sceneParts[currentPartIndex].pause();

            if (isGameOver()) {
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

        /**
         * @return パーティ全員の HP を確認。片方、または両サイドの全員が死んでいたら true を返却する。
         */
        private function isGameOver():Boolean {
            var enemys:Vector.<Character> = _party.getMembers(TargetType.ENEMY, true);
            var friends:Vector.<Character> = _party.getMembers(TargetType.FRIEND, true);
            var checkFunc:Function = function(c:Character, i:int, v:Vector.<Character>):Boolean {
                return c.ability.hp.currentValue <= 0;
            }

            return friends.every(checkFunc) || enemys.every(checkFunc);
        }
    }
}
