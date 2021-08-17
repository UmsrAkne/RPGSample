package app.coms {

    import app.charas.Character;

    public class CommandManager {

        private var owner:Character;
        private var _skills:Vector.<Skill> = new Vector.<Skill>();
        private var _items:Vector.<Item> = new Vector.<Item>();

        private var _currentCommands:Vector.<ICommand> = new Vector.<ICommand>();
        private var firstCommandNames:Vector.<String> = new Vector.<String>();

        private var nextCommand:ICommand;
        private var target:Character;

        public function CommandManager(owner:Character) {

            this.owner = owner;

            // 全てのキャラクターは、最低限通常攻撃のスキルは使用可能とする。
            var attackSkill:Skill = new Skill();
            attackSkill.displayName = CommandName.ATTACK;
            _skills.push(attackSkill);

            firstCommandNames.unshift(CommandName.ATTACK);
            firstCommandNames.unshift(CommandName.SKILL);
            firstCommandNames.unshift(CommandName.ITEM);
        }

        public function select(index:int):void {
            if (_currentCommands.length == 0) {
                // 最初のコマンド選択は firstCommandNames を参照する。

                switch (firstCommandNames[index]) {
                    case CommandName.ATTACK:

                        break;

                    case CommandName.SKILL:
                        for each (var skill:Skill in _skills) {
                            _currentCommands.push(ICommand(skill));
                        }
                        break;

                    case CommandName.ITEM:
                        for each (var item:Item in _items) {
                            _currentCommands.push(ICommand(item));
                        }
                        break;
                }
            } else if (!nextCommand) {
                nextCommand = _currentCommands[index];
            } else {
                // target の設定
            }
        }

        public function cancel():void {
            if (nextCommand) {
                nextCommand = null;
                return;
            } else {
                _currentCommands = new Vector.<ICommand>();
            }
        }

        public function reset():void {
            nextCommand = null;
            target = null;
            _currentCommands = new Vector.<ICommand>();
        }

        public function get commandNames():Vector.<String> {
            if (_currentCommands.length == 0) {
                return firstCommandNames;
            }

            var v:Vector.<String> = new Vector.<String>();
            for each (var c:ICommand in _currentCommands) {
                v.push(c.displayName);
            }

            return v
        }

        public function get commandSelected():Boolean {
            return nextCommand && target;
        }
    }
}
