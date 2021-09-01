package app.dataLoaders {

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import app.charas.Character;

    public class CharacterLoader {

        private var _characterXML:XML;
        private var _copySourceCharacters:Vector.<Character>
        private var completeEventDispatcher:EventDispatcher;

        public function CharacterLoader() {
        }

        public function load(xmlFilePath:String):void {
            if (_characterXML == null) {
                var urlLoader:URLLoader = new URLLoader();
                urlLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
                    _characterXML = new XMLList(URLLoader(e.target).data)[0];

                    completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
                });


                urlLoader.load(new URLRequest(xmlFilePath));
                return;
            }

            completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}
