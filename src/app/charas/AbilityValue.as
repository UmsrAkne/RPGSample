package app.charas {

    public class AbilityValue {

        private var _currentValue:int;
        private var _maxValue:int;
        private var _minValue:int;

        public function AbilityValue() {
        }

        public function get currentValue():int {
            return _currentValue;
        }

        public function set currentValue(value:int):void {
            if (value < minValue) {
                _currentValue = minValue;
                return;
            }

            if (value > maxValue) {
                _currentValue = maxValue;
                return;
            }

            _currentValue = value;
        }

        public function get maxValue():int {
            return _maxValue;
        }

        public function set maxValue(value:int):void {
            if (value < _minValue) {
                _maxValue = minValue;
                return;
            }

            _maxValue = value;
        }

        public function get minValue():int {
            return _minValue;
        }

        public function set minValue(value:int):void {
            if (value > maxValue) {
                _minValue = maxValue
            }

            _minValue = value;
        }
    }
}
