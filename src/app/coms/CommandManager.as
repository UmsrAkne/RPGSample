package app.coms {

    import app.charas.Character;

    public class CommandManager {

        private var owner:Character;
        private var _skills:Vector.<Skill> = new Vector.<Skill>();
        private var _items:Vector.<Item> = new Vector.<Item>();

        private var nextCommand:ICommand;
        private var target:Character;

        public function CommandManager(owner:Character) {

            this.owner = owner;

            // 全てのキャラクターは、最低限通常攻撃のスキルは使用可能とする。
            var attackSkill:Skill = new Skill();
            attackSkill.displayName = "攻撃";
            _skills.push(attackSkill);
        }
    }
}
