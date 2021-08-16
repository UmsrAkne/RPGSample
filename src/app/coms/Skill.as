package app.coms {

    public class Skill implements ICommand {

        private var name:String = "";
        private var _strength:int;

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
    }
}
