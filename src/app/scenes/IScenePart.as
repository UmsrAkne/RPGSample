package app.scenes {

    import flash.display.Sprite;

    public interface IScenePart {
        function get eventDispatcher():Sprite;
        function start():void;
        function pause():void;
    }
}
