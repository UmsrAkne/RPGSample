package app.coms {

    public class Item implements ICommand {

        private var name:String = "";

        public function Item() {

        }

        public function get displayName():String {
            return name;
        }

        public function set displayName(value:String):void {
            name = value;
        }
    }
}
