package app.coms {

    public class Skill implements ICommand, IAction {

        private var name:String = "";
        private var _strength:int;
        private var _targetType:String = TargetType.ENEMY;
        private var _effectType:String = EffectType.DAMAGE;
        private var _cost:int = 0;
        private var _message:String;

        public function Skill() {
        }

        public function get displayName():String {
            return name;
        }

        public function set displayName(value:String):void {
            name = value;
        }

        public function get strength():int {
            return _strength;
        }

        public function set strength(value:int):void {
            _strength = value;
        }

        public function set targetType(value:String):void {
            _targetType = value;
        }

        public function get targetType():String {
            return _targetType;
        }

        public function set effectType(value:String):void {
            _effectType = value;
        }

        public function get effectType():String {
            return _effectType;
        }

        public function set message(value:String):void {
            _message = value;
        }

        public function get message():String {
            return _message;
        }
    }
}
