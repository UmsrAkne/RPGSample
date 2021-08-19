package app.gameEvents {
    import flash.events.Event;

    public class TextEvent extends Event {

        public static var COMMAND_WINDOW:String = "commandWindow";
        public static var SIDE_COMMAND_WINDOW:String = "sideCommandWindow";
        public static var MESSAGE_WINDOW:String = "messageWindow";
        public static var STATUS_WINDOW:String = "statusWindow";

        public var text:String = "";
        public var displayLocation:String = MESSAGE_WINDOW;

        public function TextEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }

        /**
         * 入力されたテキストに改行を加えてフィールドに追加します。
         * @param lineText
         */
        public function addLine(lineText:String):void {
            text += "\n" + lineText;
        }
    }
}
