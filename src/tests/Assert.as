package tests {

    /**
     * ...
     * @author
     */
    public final class Assert {

        private static var testCounter:int;

        public function Assert() {

        }

        public static function areEqual(a:*, b:*, comment:String = ""):void {
            if (a != b) {
                trace(a + " != " + b);
                trace(comment);
                trace(getCaller(new Error()));
                trace("--");
            }
            testCounter++;
        }

        public static function areNotEqual(a:*, b:*, comment:String = ""):void {
            if (a == b) {
                trace(a + " == " + b);
                trace(comment);
                trace(getCaller(new Error()));
                trace("--");
            }
            testCounter++;
        }


        public static function isTrue(value:Boolean, comment:String = ""):void {
            if (!value) {
                trace("value is false");
                trace(comment);
                trace(getCaller(new Error()));
                trace("--");
            }
            testCounter++;
        }

        public static function isFalse(value:Boolean, comment:String = ""):void {
            if (value) {
                trace("value is true");
                trace(comment);
                trace(getCaller(new Error()));
                trace("--");
            }
            testCounter++;
        }

        /**
         * パラメーターが全て真でない場合にAssert失敗と判定します
         * @param ...value
         */
        public static function areTrue(... args:Array):void {
            if (args.every(function(b:Boolean, i:int, array:Array):Boolean {
                return b;
            }) == false) {
                trace("parameter containes false");
                trace(getCaller(new Error()));
                trace("--");
            }
            testCounter++;
        }

        /**
         * パラメーターが全て偽でない場合にAssert失敗と判定します
         * @param ...args
         */
        public static function areFalse(... args:Array):void {
            if (args.every(function(b:Boolean, i:int, array:Array):Boolean {
                return !b;
            }) == false) {
                trace("parameter containes true");
                trace(getCaller(new Error()));
                trace("--");
            }
            testCounter++;
        }

        public static function isNull(value:*, comment:String = ""):void {
            if (value != null) {
                trace("value is Not null");
                trace(comment);
                trace(getCaller(new Error()));
                trace("--");
            }
            testCounter++;
        }

        public static function isNotNull(value:*, comment:String = ""):void {
            if (value == null) {
                trace("value is null");
                trace(comment);
                trace(getCaller(new Error()));
                trace("--");
            }
            testCounter++;
        }

        public static function get TestCounter():int {
            return testCounter;
        }

        private static function getCaller(e:Error):String {
            var callerNames:Array = e.getStackTrace().split("\n");
            var name:String = callerNames[2];
            var regExp:RegExp = /\[.*\\/;
            name = name.replace(regExp, " ");
            name = name.replace("]", "");
            return name;
        }
    }
}
