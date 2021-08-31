package app.userInteFace {

    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    public class GraphicsContainer extends Sprite {

        private var bitmaps:Vector.<Bitmap> = new Vector.<Bitmap>();
        private var bitmapsByName:Dictionary = new Dictionary();

        public function GraphicsContainer() {
        }

        /**
         * このオブジェクトに Bitmap を追加し、同時に addChild を行って表示状態にします。
         * @param b 追加したい bitmap を入力します
         * @param key 空文字以外のキーを入力した場合、同時に入力したビットマップが該当キーで辞書にも格納されます。
         */
        public function addBitmap(b:Bitmap, key:String):void {
            addChild(b);
            bitmaps.push(b);
            if (key != "") {
                bitmapsByName[key] = b;
            }
        }

        public function getBitmapFromKey(key:String):Bitmap {
            return bitmapsByName[key];
        }
    }
}
