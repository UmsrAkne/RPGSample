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
        public function getMembers(targetType:String, rev:Boolean = true):Vector.<Character> {
            if (targetType == TargetType.ALL) {
                return members.concat();
            }

            var targetIsFriend:Boolean = (targetType == TargetType.FRIEND);
            targetIsFriend = (rev) ? targetIsFriend : !targetIsFriend

            return getOnesideMembers(targetIsFriend);
        }

        public function get members():Vector.<Character> {
            return _members;
        }

        /**
         * @return BattleScene への移行、または BattleScene を継続可能かどうかを取得します。
         */
        public function canBattle():Boolean {
            var enemys:Vector.<Character> = getMembers(TargetType.ENEMY);
            var friends:Vector.<Character> = getMembers(TargetType.FRIEND);

            if (enemys.length == 0 || friends.length == 0) {
                return false;
            }

            var checkFunc:Function = function(c:Character, i:int, v:Vector.<Character>):Boolean {
                return c.ability.hp.currentValue > 0;
            }

            return friends.some(checkFunc) && enemys.some(checkFunc);
        }

        private function getOnesideMembers(isFriend:Boolean):Vector.<Character> {
            return _members.filter(function(c:Character, i:int, v:Vector.<Character>):Boolean {
                return c.isFriend == isFriend;
            });
        }

    }
}
