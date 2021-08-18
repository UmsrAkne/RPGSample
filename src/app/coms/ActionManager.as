package app.coms {

    import app.charas.Character;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import app.gameEvents.GameEvent;
    import app.gameEvents.MessageEvent;

    public class ActionManager {

        private var owner:Character;
        private var _eventDispatcher:EventDispatcher = new EventDispatcher();

        public function ActionManager(owner:Character) {
            this.owner = owner;
        }

        public function act():void {
            var nextTarget:Character = owner.commandManager.target;
            nextTarget.actionManager.recieveAction(IAction(owner.commandManager.nextCommand));

            var messageEvent:MessageEvent = new MessageEvent(GameEvent.MESSAGE);
            messageEvent.message = IAction(owner.commandManager.nextCommand).message;
            eventDispatcher.dispatchEvent(messageEvent);

            // 行動を実行したのでリセットする。
            owner.commandManager.reset();
        }

        public function recieveAction(action:IAction):void {

            var messageEvent:MessageEvent = new MessageEvent(GameEvent.MESSAGE);

            switch (action.effectType) {
                case EffectType.DAMAGE:
                    owner.ability.hp.currentValue -= action.strength;
                    messageEvent.message = owner.displayName + "は" + action.strength + "ダメージを受けた";
                    break;

                case EffectType.RECOVERY:
                    owner.ability.hp.currentValue += action.strength;
                    messageEvent.message = owner.displayName + "はHPが" + action.strength + "回復した";
                    break;

                default:
                    break;
            }

            eventDispatcher.dispatchEvent(messageEvent);
        }

        public function get eventDispatcher():EventDispatcher {
            return _eventDispatcher;
        }
    }
}