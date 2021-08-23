package app.scenes {

    import flash.text.TextField;
    import flash.geom.Rectangle;
    import flash.text.TextFormat;
    import flash.display.Sprite;

    public class UI extends Sprite {

        private var _messageWindow:TextField = new TextField();
        private var _commandWindow:TextField = new TextField();
        private var _sideCommandWindow:TextField = new TextField();
        private var _statusWindow:TextField = new TextField();
        private const fontSize:int = 20;

        public function UI() {
            var textFormat:TextFormat = new TextFormat();
            textFormat.size = fontSize;

            var tfs:Vector.<TextField> = new Vector.<TextField>();
            tfs.push(messageWindow, commandWindow, sideCommandWindow, statusWindow);
            for each (var tf:TextField in tfs) {
                tf.defaultTextFormat = textFormat;
                tf.multiline = true;
                addChild(tf);
            }
        }

        public function align(screenSize:Rectangle):void {
        }

        public function get messageWindow():TextField {
            return _messageWindow;
        }

        public function get commandWindow():TextField {
            return _messageWindow;
        }

        public function get sideCommandWindow():TextField {
            return _messageWindow;
        }

        public function get statusWindow():TextField {
            return _messageWindow;
        }
    }
}
