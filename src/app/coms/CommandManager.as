package app.coms {

    import app.charas.Character;
    import app.charas.Party;
    import app.utils.Random;

    public class CommandManager {

        private var owner:Character;
        private var _skills:Vector.<Skill> = new Vector.<Skill>();
        private var _items:Vector.<Item> = new Vector.<Item>();
        private var _party:Party;

        private var _currentCommands:Vector.<ICommand> = new Vector.<ICommand>();
        private var previousCommands:Vector.<ICommand> = new Vector.<ICommand>();
        private var firstCommandNames:Vector.<String> = new Vector.<String>();

        private var _nextCommand:ICommand;
        private var _target:Character;

        public function CommandManager(owner:Character) {

            this.owner = owner;

            // 全てのキャラクターは、最低限通常攻撃のスキルは使用可能とする。
            var attackSkill:Skill = new Skill();
            attackSkill.displayName = CommandName.ATTACK;
            attackSkill.strength = 1;
            attackSkill.message = owner.displayName + "の攻撃";
            _skills.push(attackSkill);

            firstCommandNames.push(CommandName.ATTACK);
            firstCommandNames.push(CommandName.SKILL);
            firstCommandNames.push(CommandName.ITEM);
        }

        public function select(index:int):void {
            if (_currentCommands.length == 0) {
                // 最初のコマンド選択は firstCommandNames を参照する。

                switch (firstCommandNames[index]) {
                    case CommandName.ATTACK:
                        _nextCommand = _skills[0];
                        for each (var character:Character in _party.getMembers(_skills[0].targetType, owner.isFriend)) {
                            _currentCommands.push(ICommand(character));
                        }
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

            } else if (!_nextCommand) {
                _nextCommand = _currentCommands[index];

                // 確実に skill or item が入っているのでキャスト可能
                var action:IAction = IAction(_nextCommand);

                // コマンドのキャンセルができるように、直近のベクターをコピーしておく
                previousCommands = _currentCommands.concat();

                _currentCommands = new Vector.<ICommand>();
                var targets:Vector.<Character> = _party.getMembers(action.targetType, owner.isFriend);
                for each (var c:Character in targets) {
                    _currentCommands.push(ICommand(c));
                }
            } else {
                // target の設定
                _target = _currentCommands[index] as Character;
            }
        }

        public function autoSetting():void {
            _nextCommand = ICommand(_skills[Random.getRandomRange(0, _skills.length - 1)]);
            var targetList:Vector.<Character> = _party.getMembers(IAction(_nextCommand).targetType, owner.isFriend);
            _target = targetList[Random.getRandomRange(0, targetList.length - 1)];
        }

        public function cancel():void {
            if (_nextCommand) {
                _nextCommand = null;
                _currentCommands = previousCommands.concat();
                previousCommands = new Vector.<ICommand>();
                return;
            } else {
                _currentCommands = new Vector.<ICommand>();
            }
        }

        public function reset():void {
            _nextCommand = null;
            _target = null;
            _currentCommands = new Vector.<ICommand>();
            previousCommands = new Vector.<ICommand>();
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
            return _nextCommand && _target;
        }

        public function get nextCommand():ICommand {
            return _nextCommand;
        }

        public function get target():Character {
            return _target;
        }

        public function set party(value:Party):void {
            _party = value;
        }
    }
}
