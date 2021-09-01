package app.dataLoaders {

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import app.charas.Character;

    public class CharacterLoader {

        private var _characterXML:XML;
        private var _copySourceCharacters:Vector.<Character> = new Vector.<Character>();
        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();

        public function CharacterLoader() {
        }

        public function load(xmlFilePath:String):void {
            if (_characterXML == null) {
                var urlLoader:URLLoader = new URLLoader();
                urlLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
                    _characterXML = new XMLList(URLLoader(e.target).data)[0];
                    makeCharacters();
                    completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
                });


                urlLoader.load(new URLRequest(xmlFilePath));
                return;
            }

            makeCharacters();
            completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
        }

        public function set characterXML(value:XML):void {
            _characterXML = value;
        }

        public function get copySourceCharacters():Vector.<Character> {
            return _copySourceCharacters;
        }

        private function makeCharacters():void {
            for each (var charaData:XML in _characterXML["character"]) {
                var c:Character = new Character(charaData["@name"], charaData["@isFriend"] == "true");

                var hp:int = parseInt(charaData["@hp"]);
                c.ability.hp.maxValue = hp;
                c.ability.hp.currentValue = hp;

                var sp:int = parseInt(charaData["@sp"]);
                c.ability.sp.maxValue = sp;
                c.ability.sp.currentValue = sp;

                var atk:int = parseInt(charaData["@atk"]);
                c.ability.atk.maxValue = atk;
                c.ability.atk.currentValue = atk;

                _copySourceCharacters.push(c);
            }
        }
    }
}
