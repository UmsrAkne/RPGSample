package app.utils {

    public class Random {

        public static var constant:Number = 1;

        /**
         * Random.constant の値が 1 よりも小さい場合は Random.constant の値を返却
         * そうでない場合は Math.random() を実行した結果を返却します。
         * @return
         */
        public static function random():Number {
            return (constant < 1) ? constant : Math.random();
        }

        /**
         * 引数で指定した範囲のランダムな整数を取得します。
         * 内部で行う乱数取得の処理に Random.random() を使用しています。
         * @param min 取得範囲の最小値です
         * @param range min から取得する範囲です
         * @return
         */
        public static function getRandomRange(min:int, range:int):int {
            return Math.floor(Random.random() * range - min) + min;
        }

    }
}
