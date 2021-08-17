package app.coms {

    public class Item implements ICommand, IAction {

        private var name:String = "";
        private var _targetType:String = TargetType.ENEMY;
        private var _strength:int;

        public function Item() {

        }

        public function get displayName():String {
            return name;
        }

        public function set displayName(value:String):void {
            name = value;
        }

        public function set targetType(value:String):void {
            _targetType = value;
        }

        public function get targetType():String {
            return _targetType;
        }

        public function get strength():int {
            return _strength;
        }

        public function set strength(value:int):void {
            _strength = value;
        }
    }
}
