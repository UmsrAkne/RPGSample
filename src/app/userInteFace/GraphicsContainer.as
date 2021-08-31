package app.userInteFace {

    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    public class GraphicsContainer extends Sprite {

        private var bitmaps:Vector.<Bitmap> = new Vector.<Bitmap>();
        private var bitmapsByName:Dictionary = new Dictionary();
        private var _verticalDirectionStack:Boolean = false;
        private var _spacing:int;

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

            align();
        }

        public function getBitmapFromKey(key:String):Bitmap {
            return bitmapsByName[key];
        }

        public function set verticalDirectionStack(value:Object):void {
            _verticalDirectionStack = value;
            align();
        }

        public function get verticalDirectionStack():Object {
            return _verticalDirectionStack;
        }

        public function set spacing(value:int):void {
            _spacing = value;
            align();
        }

        public function get spacing():int {
            return _spacing;
        }

        private function align():void {
            if (bitmaps.length == 0) {
                return;
            }

            var current:Bitmap = bitmaps[0];
            current.x = 0;
            current.y = 0;

            for (var i:int = 1; i < bitmaps.length; i++) {
                current = bitmaps[i];
                var prev:Bitmap = bitmaps[i - 1];

                if (verticalDirectionStack) {
                    current.x = 0;
                    current.y = prev.y + prev.height + spacing;
                } else {
                    current.y = 0;
                    current.x = prev.x + prev.width + spacing;
                }
            }
        }
    }
}
