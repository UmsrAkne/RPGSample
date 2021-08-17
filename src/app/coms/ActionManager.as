package app.coms {

    import app.charas.Character;

    public class ActionManager {

        private var owner:Character;

        public function ActionManager(owner:Character) {
            this.owner = owner;
        }

        public function act():void {
            var nextTarget:Character = owner.commandManager.target;
            nextTarget.actionManager.recieveAction(IAction(owner.commandManager.nextCommand));

            // 行動を実行したのでリセットする。
            owner.commandManager.reset();
        }

        public function recieveAction(action:IAction):void {
            owner.ability.hp.currentValue -= action.strength;
        }
    }
}
