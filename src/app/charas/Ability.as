package app.charas {

    public class Ability {

        private var _hp:AbilityValue = new AbilityValue();
        private var _sp:AbilityValue = new AbilityValue();
        private var _atk:AbilityValue = new AbilityValue();

        public function get hp():AbilityValue {
            return _hp;
        }

        public function get sp():AbilityValue {
            return _sp
        }

        public function get atk():AbilityValue {
            return _atk;
        }
    }
}
