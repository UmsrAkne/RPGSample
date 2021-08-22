package app.charas {

    import app.coms.CommandManager;
    import app.coms.ICommand;
    import app.coms.ActionManager;

    public class Character implements ICommand {

        private var _ability:Ability = new Ability();
        private var _commandManager:CommandManager;
        private var _actionManager:ActionManager;
        private var _isFriend:Boolean;
        private var _name:String;

        public function Character(characterName:String, characterIsFriend:Boolean) {
            _name = characterName;
            _isFriend = characterIsFriend;
            _commandManager = new CommandManager(this);
            _actionManager = new ActionManager(this);
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

        /** キャラクターが持つ CommandManager, ActionManager に party をセットします。
         * @param value
         */
        public function set party(value:Party):void {
            _commandManager.party = value;
            _actionManager.party = value;
        }
    }
}
