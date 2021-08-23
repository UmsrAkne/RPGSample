package app.scenes {

    import flash.display.Sprite;
    import flash.events.KeyboardEvent;

    public interface IScenePart {
        function get eventDispatcher():Sprite;
        function start():void;
        function pause():void;
        function pressKey(e:KeyboardEvent):void;
        function enterFrameProcess():void;
    }
}
