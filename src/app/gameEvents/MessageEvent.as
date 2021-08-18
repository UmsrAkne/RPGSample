package app.gameEvents {
    import flash.events.Event;

    public class MessageEvent extends Event {

        public var message:String = "";

        public function MessageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }
    }
}
