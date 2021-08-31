package tests.userInterface {

    import app.userInteFace.GraphicsContainer;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import tests.Assert;

    public class TestGraphicsContainer {
        public function TestGraphicsContainer() {
            test();
            getBitmapFromKeyTest();
        }

        private function test():void {
            var gContainer:GraphicsContainer = new GraphicsContainer();

            var ba:Bitmap = new Bitmap(new BitmapData(10, 15));
            var bb:Bitmap = new Bitmap(new BitmapData(10, 15));
            var bc:Bitmap = new Bitmap(new BitmapData(10, 15));
            var bd:Bitmap = new Bitmap(new BitmapData(10, 15));

            gContainer.addBitmap(ba, "ba");
            gContainer.addBitmap(bb, "bb");
            gContainer.addBitmap(bc, "bc");
            gContainer.addBitmap(bd, "bd");

            Assert.isFalse(gContainer.verticalDirectionStack, "スタックは横方向");

            Assert.areEqual(ba.y, 0, "横方向のスタックなので y の位置は 0");
            Assert.areEqual(bb.y, 0, "横方向のスタックなので y の位置は 0");
            Assert.areEqual(bc.y, 0, "横方向のスタックなので y の位置は 0");
            Assert.areEqual(bd.y, 0, "横方向のスタックなので y の位置は 0");

            Assert.areEqual(ba.x, 0, "先頭のグラフィックスの x 座標は 0");
            Assert.areEqual(bb.x, 10, "画像の横幅は全て 10 であるので、前の画像の右端の位置");
            Assert.areEqual(bc.x, 20, "更に前の画像の右端");
            Assert.areEqual(bd.x, 30);

            gContainer.spacing = 3;

            Assert.areEqual(ba.x, 0, "スペーシングは 3 に設定されているが、先頭の画像には適用されない。");
            Assert.areEqual(bb.x, 13, "隣の画像の横幅 + スペーシング");
            Assert.areEqual(bc.x, 26, "隣の画像の右端の座標 + スペーシング");
            Assert.areEqual(bd.x, 39, "隣の画像の右端の座標 + スペーシング");
        }

        private function getBitmapFromKeyTest():void {
            var gContainer:GraphicsContainer = new GraphicsContainer();

            var ba:Bitmap = new Bitmap(new BitmapData(10, 15));
            var bb:Bitmap = new Bitmap(new BitmapData(10, 15));
            var bc:Bitmap = new Bitmap(new BitmapData(10, 15));

            gContainer.addBitmap(ba, "ba");
            gContainer.addBitmap(bb, "bb");
            gContainer.addBitmap(bc, "bc");

            Assert.areEqual(gContainer.getBitmapFromKey("ba"), ba);
            Assert.areEqual(gContainer.getBitmapFromKey("bb"), bb);
            Assert.areEqual(gContainer.getBitmapFromKey("bc"), bc);
        }
    }
}
