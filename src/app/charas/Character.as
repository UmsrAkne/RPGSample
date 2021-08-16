package app.charas {

    import app.coms.CommandManager;

    public class Character {

        private var _ability:Ability = new Ability();
        private var _commandManager:CommandManager = new CommandManager(this);

        public function Character() {
        }

        public function get ability():Ability {
            return ability;
        }

        public function get commandManager():CommandManager {
            return _commandManager;
        }
    }
}
