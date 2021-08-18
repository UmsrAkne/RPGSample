package app.scenes {

    import flash.display.Sprite;
    import flash.events.Event;

    public class BattleScene extends Sprite {

        private var sceneParts:Vector.<IScenePart> = new Vector.<IScenePart>();
        private var currentPartIndex:int;

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

            currentPartIndex++;
            currentPartIndex = (currentPartIndex >= sceneParts.length) ? 0 : currentPartIndex;
            sceneParts[currentPartIndex].start();
        }

        public function addPart(part:IScenePart):void {
            sceneParts.push(part);
        }
    }
}
