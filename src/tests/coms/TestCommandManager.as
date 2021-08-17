package tests.coms {

    import app.coms.CommandManager;
    import app.charas.Character;
    import app.charas.Party;
    import tests.Assert;

    public class TestCommandManager {
        public function TestCommandManager() {
            attackCommandTest();
            skillCommandTest();
        }

        private function attackCommandTest():void {
            var owner:Character = new Character("testCharacter", true);
            var enemy:Character = new Character("enemyCharacter", false);
            var enemy2:Character = new Character("enemyCharacter2", false);
            var enemy3:Character = new Character("enemyCharacter3", false);
            var commandManager:CommandManager = new CommandManager(owner);
            var party:Party = new Party();
            party.members.push(owner, enemy, enemy2, enemy3);
            commandManager.party = party;

            Assert.areEqual(commandManager.commandNames[0], "攻撃");
            Assert.areEqual(commandManager.commandNames[1], "スキル");
            Assert.areEqual(commandManager.commandNames[2], "アイテム");

            Assert.isFalse(commandManager.commandSelected);

            // 攻撃コマンド選択
            commandManager.select(0);

            // ターゲットの選択肢が３つ 名前は enemyCharacter
            Assert.areEqual(commandManager.commandNames.length, 3);
            Assert.areEqual(commandManager.commandNames[0], "enemyCharacter");
            Assert.areEqual(commandManager.commandNames[1], "enemyCharacter2");
            Assert.areEqual(commandManager.commandNames[2], "enemyCharacter3");

            // ターゲットとして enemyCharacter を選択
            commandManager.select(0);

            Assert.isTrue(commandManager.commandSelected);
        }

        private function skillCommandTest():void {
            var owner:Character = new Character("testCharacter", true);
            var enemy:Character = new Character("enemyCharacter", false);
            var commandManager:CommandManager = new CommandManager(owner);
            var party:Party = new Party();
            party.members.push(owner, enemy);
            commandManager.party = party;

            Assert.areEqual(commandManager.commandNames[1], "スキル");

            Assert.isFalse(commandManager.commandSelected);

            // スキルコマンド選択
            commandManager.select(1);

            Assert.areEqual(commandManager.commandNames.length, 1);
            Assert.areEqual(commandManager.commandNames[0], "攻撃");

            // 攻撃スキルを選択
            commandManager.select(0);

            Assert.areEqual(commandManager.commandNames.length, 1);
            Assert.areEqual(commandManager.commandNames[0], "enemyCharacter");

            // ターゲットを enemyCharacter に選択
            commandManager.select(0);

            Assert.isTrue(commandManager.commandSelected);
        }
    }
}
