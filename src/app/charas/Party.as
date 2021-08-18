package app.charas {

    import app.coms.TargetType;

    public class Party {

        private var _members:Vector.<Character> = new Vector.<Character>();

        public function Party() {
        }

        /**
         * 入力した targetType に対応したキャラクターを取得します。
         * @param targetType 取得したいキャラクターに応じて TargetType クラスのメンバーの文字列を入力します。
         * FRIEND : 味方
         * ENEMY  : 敵
         * ALL    : 全キャラクター
         *
         * @param rev targetType Friend or Enemy の場合に指定を反転します。
         * 例えば、targetType = enemy, rev = false を入力した場合 targetType == friend が返却されます。
         *
         * @return 指定したキャラクターを詰めたベクターを返します。
         */
        public function getMembers(targetType:String, rev:Boolean):Vector.<Character> {
            if (targetType == TargetType.ALL) {
                return members;
            }

            var targetIsFriend:Boolean = (targetType == TargetType.FRIEND);
            targetIsFriend = (rev) ? targetIsFriend : !targetIsFriend

            return getOnesideMembers(targetIsFriend);
        }

        public function get members():Vector.<Character> {
            return _members;
        }

        private function getOnesideMembers(isFriend:Boolean):Vector.<Character> {
            return _members.filter(function(c:Character, i:int, v:Vector.<Character>):Boolean {
                return c.isFriend == isFriend;
            });
        }

    }
}
