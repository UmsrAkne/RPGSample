package app.charas {

    import app.coms.CommandManager;
    import app.coms.ICommand;
    import app.coms.ActionManager;

    public class Character implements ICommand {

        private var _ability:Ability = new Ability();
        private var _commandManager:CommandManager = new CommandManager(this);
        private var _actionManager:ActionManager = new ActionManager(this);
        private var _isFriend:Boolean;
        private var _name:String;

        public function Character(characterName:String, characterIsFriend:Boolean) {
            _name = characterName;
            _isFriend = characterIsFriend;
        }

        public function get ability():Ability {
            return _ability;
        }

        public function get commandManager():CommandManager {
            return _commandManager;
        }

        public function get actionManager():ActionManager {
            return _actionManager;
        }

        public function get isFriend():Object {
            return _isFriend;
        }

        public function get displayName():String {
            return _name;
        }
    }
}