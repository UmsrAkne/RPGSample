package app.charas {

    public class Party {

        private var _members:Vector.<Character> = new Vector.<Character>();

        public function Party() {
        }

        public function getOnesideMembers(isFriend:Boolean):Vector.<Character> {
            return _members.filter(function(c:Character, i:int, v:Vector.<Character>):Boolean {
                return c.isFriend == isFriend;
            });
        }

        public function get members():Vector.<Character> {
            return _members;
        }
    }
}
