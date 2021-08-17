package app.coms {

    public class Skill implements ICommand, IAction {

        private var name:String = "";
        private var _strength:int;
        private var _targetType:String = TargetType.ENEMY;

        public function Skill() {
        }

        public function get displayName():String {
            return name;
        }

        public function set displayName(value:String):void {
            name = value;
        }

        public function get strength():int {
            return strength;
        }

        public function set strength(value:int):void {
            strength = value;
        }

        public function set targetType(value:String):void {
            _targetType = value;
        }

        public function get targetType():String {
            return _targetType;
        }
    }
}
