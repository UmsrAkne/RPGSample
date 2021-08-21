package tests.coms {

    import app.coms.CommandManager;
    import app.charas.Character;
    import app.charas.Party;
    import tests.Assert;
    import app.utils.Random;
    import app.coms.TargetType;

    public class TestCommandManager {
        public function TestCommandManager() {
            attackCommandTest();
            skillCommandTest();
            enemyAttackCommandTest();
            commandCancelTest();

            Random.constant = 0.5;
            commandAutoSettingTest();
            Random.constant = 1;
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

            for each (var c:Character in party.getMembers(TargetType.ALL)) {
                c.ability.hp.maxValue = 10;
                c.ability.hp.currentValue = 10;
            }

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

        private function enemyAttackCommandTest():void {
            var owner:Character = new Character("testCharacter", false);
            var ally:Character = new Character("allyChara1", true);
            var ally2:Character = new Character("allyChara2", true);

            var commandManager:CommandManager = new CommandManager(owner);
            var party:Party = new Party();
            party.members.push(owner, ally, ally2);
            commandManager.party = party;

            Assert.areEqual(commandManager.commandNames[0], "攻撃");
            Assert.areEqual(commandManager.commandNames[1], "スキル");
            Assert.areEqual(commandManager.commandNames[2], "アイテム");

            Assert.isFalse(commandManager.commandSelected);

            // 攻撃コマンド選択
            commandManager.select(0);

            // ターゲットの選択肢が２つ
            Assert.areEqual(commandManager.commandNames.length, 2);
            Assert.areEqual(commandManager.commandNames[0], "allyChara1");
            Assert.areEqual(commandManager.commandNames[1], "allyChara2");

            // ターゲットとして allyChara1 を選択
            commandManager.select(0);

            Assert.isTrue(commandManager.commandSelected);
        }

        private function commandCancelTest():void {
            var owner:Character = new Character("testCharacter", true);
            var enemy:Character = new Character("enemyCharacter", false);
            var commandManager:CommandManager = new CommandManager(owner);
            var party:Party = new Party();
            party.members.push(owner, enemy);

            for each (var c:Character in party.getMembers(TargetType.ALL)) {
                c.ability.hp.maxValue = 10;
                c.ability.hp.currentValue = 10;
            }

            commandManager.party = party;

            Assert.areEqual(commandManager.commandNames[1], "スキル");
            Assert.isFalse(commandManager.commandSelected);

            // スキルコマンド選択
            commandManager.select(1);

            Assert.areEqual(commandManager.commandNames.length, 1);
            Assert.areEqual(commandManager.commandNames[0], "攻撃");

            // コマンドをキャンセルする。最初のコマンドに戻る。
            commandManager.cancel();

            Assert.areEqual(commandManager.commandNames[0], "攻撃");
            Assert.areEqual(commandManager.commandNames[1], "スキル");
            Assert.areEqual(commandManager.commandNames[2], "アイテム");

            // 再度スキルコマンドを選択
            commandManager.select(1);
            Assert.areEqual(commandManager.commandNames.length, 1);
            Assert.areEqual(commandManager.commandNames[0], "攻撃");

            // 攻撃コマンド選択でターゲット選択に移行
            commandManager.select(0);
            Assert.areEqual(commandManager.commandNames.length, 1);
            Assert.areEqual(commandManager.commandNames[0], "enemyCharacter");

            // コマンドを再キャンセル。スキル一覧の画面に戻る。
            commandManager.cancel();
            Assert.areEqual(commandManager.commandNames.length, 1);
            Assert.areEqual(commandManager.commandNames[0], "攻撃");

            // 更にキャンセルすると、デフォルトコマンドの状態まで戻る。
            commandManager.cancel();
            Assert.areEqual(commandManager.commandNames[0], "攻撃");
            Assert.areEqual(commandManager.commandNames[1], "スキル");
            Assert.areEqual(commandManager.commandNames[2], "アイテム");

            // これ以降はキャンセルしても状態に変化はない。
            commandManager.cancel();
            Assert.areEqual(commandManager.commandNames[0], "攻撃");
            Assert.areEqual(commandManager.commandNames[1], "スキル");
            Assert.areEqual(commandManager.commandNames[2], "アイテム");

            commandManager.select(1);
            Assert.areEqual(commandManager.commandNames.length, 1);
            Assert.areEqual(commandManager.commandNames[0], "攻撃");

            commandManager.select(0);
            Assert.areEqual(commandManager.commandNames.length, 1);
            Assert.areEqual(commandManager.commandNames[0], "enemyCharacter");

            commandManager.select(0);

            Assert.isTrue(commandManager.commandSelected);
        }

        private function commandAutoSettingTest():void {
            var owner:Character = new Character("testCharacter", true);
            var enemy:Character = new Character("enemyCharacter", false);
            var commandManager:CommandManager = new CommandManager(owner);
            var party:Party = new Party();
            party.members.push(owner, enemy);
            commandManager.party = party;

            commandManager.autoSetting();
            Assert.isTrue(commandManager.commandSelected);
            Assert.areEqual(commandManager.target.displayName, "enemyCharacter");
            Assert.areEqual(commandManager.nextCommand.displayName, "攻撃");
        }
    }
}
