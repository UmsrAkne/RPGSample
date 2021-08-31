package app.gameEvents {
    import flash.events.Event;
    import app.charas.Character;

    public class GameTextEvent extends Event {

        public static var COMMAND_WINDOW:String = "commandWindow";
        public static var SIDE_COMMAND_WINDOW:String = "sideCommandWindow";
        public static var MESSAGE_WINDOW:String = "messageWindow";
        public static var STATUS_WINDOW:String = "statusWindow";

        public var text:String = "";
        public var displayLocation:String = MESSAGE_WINDOW;
        private var _dispatcher:Character;

        public function GameTextEvent(type:String, sender:Character) {
            super(type, false, false);
            _dispatcher = sender;
        }

        /**
         * 入力されたテキストに改行を加えてフィールドに追加します。
         * @param lineText
         */
        public function addLine(lineText:String):void {
            text += ((text != "") ? "\n" : "") + lineText;
        }

        /**
         *
         * @param source ソースとなるゲームイベントから各プロパティをコピーします。
         */
        public function copyPropeties(source:GameTextEvent):void {
            text = source.text;
            displayLocation = source.displayLocation;
            _dispatcher = source.dispatcher;
        }

        /**
         * このメッセージの送出元のキャラクターを取得します。
         * メッセージがシステムメッセージである場合は null を取得します。
         * @return
         */
        public function get dispatcher():Character {
            return _dispatcher;
        }
    }
}
