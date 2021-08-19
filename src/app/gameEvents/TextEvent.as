package app.gameEvents {
    import flash.events.Event;

    public class TextEvent extends Event {

        public var message:String = "";

        public function TextEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }
    }
}
