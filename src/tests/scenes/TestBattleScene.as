package tests.scenes {

    import app.scenes.BattleScene;
    import app.charas.Party;
    import app.charas.Character;
    import app.coms.TargetType;
    import app.scenes.ActionPart;
    import app.scenes.CommandPart;
    import tests.Assert;
    import app.scenes.UI;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class TestBattleScene {
        public function TestBattleScene() {
            test();
        }

        private function test():void {
            var battleScene:BattleScene = new BattleScene();
            battleScene.party = party;

            var party:Party = new Party();

            var f1:Character = new Character("friend1", true);
            var f2:Character = new Character("friend2", true);
            var e1:Character = new Character("enemy1", false);
            var e2:Character = new Character("enemy2", false);

            party.members.push(f1, f2, e1, e2);
            party.getMembers(TargetType.ALL).forEach(function(c:Character, i:int, v:*):void {
                c.party = party;
                c.ability.hp.maxValue = 10;
                c.ability.hp.currentValue = 10;
            });

            var commandPart:CommandPart = new CommandPart();
            commandPart.party = party;

            var actionPart:ActionPart = new ActionPart();
            actionPart.party = party;

            battleScene.addPart(commandPart);
            battleScene.addPart(actionPart);

            var ui:UI = battleScene.ui;

            battleScene.start();
            Assert.areEqual(ui.commandWindow.text, "攻撃\rスキル\rアイテム", "最初にコマンドパート。コマンドウィンドウにテキスト");

            var enterKeySignal:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, false, false, 0, Keyboard.ENTER);
            battleScene.keyboardEventHandler(enterKeySignal);

            Assert.areEqual(ui.commandWindow.text, "enemy1\renemy2");
            battleScene.keyboardEventHandler(enterKeySignal);

            Assert.areEqual(ui.commandWindow.text, "攻撃\rスキル\rアイテム", "二人目のコマンド選択");
            battleScene.keyboardEventHandler(enterKeySignal);

            Assert.areEqual(ui.commandWindow.text, "enemy1\renemy2");
        }
    }
}
