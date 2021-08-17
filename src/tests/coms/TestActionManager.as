package tests.coms {

    import app.charas.Character;
    import app.charas.Party;
    import tests.Assert;

    public class TestActionManager {
        public function TestActionManager() {
            attackTest();
        }

        private function attackTest():void {
            var allyCharacter:Character = new Character("allyCharacter", true);
            var enemyCharacter:Character = new Character("enemyCharacter", false);
            var party:Party = new Party();
            party.members.push(allyCharacter, enemyCharacter);

            allyCharacter.commandManager.party = party;

            enemyCharacter.ability.hp.maxValue = 10;
            enemyCharacter.ability.hp.currentValue = 10;

            allyCharacter.commandManager.select(0);
            allyCharacter.commandManager.select(0);

            Assert.isTrue(allyCharacter.commandManager.commandSelected);

            allyCharacter.actionManager.act();

            Assert.isTrue(enemyCharacter.ability.hp.currentValue < 10);

            // 行動実行後はコマンド未選択の状態になる。
            Assert.isFalse(allyCharacter.commandManager.commandSelected);
        }
    }
}
