package tests.coms {

    import app.charas.Character;
    import app.charas.Party;
    import tests.Assert;
    import app.coms.Skill;

    public class TestActionManager {
        public function TestActionManager() {
            attackTest();
            canActTest();
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

        private function canActTest():void {
            var allyCharacter:Character = new Character("allyCharacter", true);
            var enemyCharacter:Character = new Character("enemyCharacter", false);
            var party:Party = new Party();
            party.members.push(allyCharacter, enemyCharacter);

            allyCharacter.commandManager.party = party;

            enemyCharacter.ability.hp.maxValue = 10;
            enemyCharacter.ability.hp.currentValue = 10;

            allyCharacter.ability.hp.maxValue = 10;
            allyCharacter.ability.hp.currentValue = 10;
            allyCharacter.ability.sp.maxValue = 10;
            allyCharacter.ability.sp.currentValue = 10;

            var skill:Skill = new Skill();
            skill.cost = 5;
            skill.displayName = "強い攻撃";
            allyCharacter.commandManager.skills.push(skill);

            Assert.areEqual(allyCharacter.commandManager.commandNames[1], "スキル");
            allyCharacter.commandManager.select(1);

            Assert.areEqual(allyCharacter.commandManager.commandNames[1], "強い攻撃");
            allyCharacter.commandManager.select(1);

            Assert.areEqual(allyCharacter.commandManager.commandNames[0], "enemyCharacter");
            allyCharacter.commandManager.select(0);

            Assert.isTrue(allyCharacter.actionManager.canAct);

            allyCharacter.ability.hp.currentValue = 0;
            Assert.isFalse(allyCharacter.actionManager.canAct, "キャラが死んでいる状態なので false");

            allyCharacter.ability.hp.currentValue = 10;
            allyCharacter.ability.sp.currentValue = 0;

            Assert.isFalse(allyCharacter.actionManager.canAct, "sp が切れている状態なので false");
        }
    }
}
