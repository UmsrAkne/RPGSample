package tests.dataLoaders {

    import app.dataLoaders.CharacterLoader;
    import tests.Assert;
    import app.charas.Character;

    public class TestCharacterLoader {
        public function TestCharacterLoader() {
            makeCharacterTest();
        }

        private function makeCharacterTest():void {
            var xmlText:String = "<root> ";
            xmlText += "<character name=\"testChara1\" isFriend=\"true\" hp=\"10\" sp=\"15\" atk=\"5\" />";
            xmlText += "<character name=\"testChara2\" isFriend=\"true\" hp=\"10\" sp=\"15\" atk=\"5\" />";
            xmlText += "<character name=\"testChara3\" isFriend=\"false\" hp=\"10\" sp=\"15\" atk=\"5\" />";
            xmlText += "</root> "

            var loader:CharacterLoader = new CharacterLoader();
            loader.characterXML = new XML(xmlText);
            loader.load("dummy");

            var v:Vector.<Character> = loader.copySourceCharacters;
            Assert.areEqual(v.length, 3);
            Assert.isTrue(v[0].isFriend);

            Assert.areEqual(v[0].ability.hp.currentValue, 10);
            Assert.areEqual(v[1].ability.sp.currentValue, 15);

            Assert.isFalse(v[2].isFriend);
        }
    }
}
