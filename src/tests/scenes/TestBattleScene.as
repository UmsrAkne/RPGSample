package tests.scenes {

    import app.scenes.BattleScene;
    import app.charas.Party;
    import app.charas.Character;
    import app.coms.TargetType;
    import app.scenes.ActionPart;
    import app.scenes.CommandPart;
    import tests.Assert;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.events.Event;
    import app.utils.Random;
    import app.userInteFace.UI;

    public class TestBattleScene {
        public function TestBattleScene() {
            Random.constant = 0.5;
            test();
            Random.constant = 1.0;
        }

        private function test():void {
            var battleScene:BattleScene = new BattleScene();

            var battleSceneCompleted:Boolean = false;
            battleScene.addEventListener(Event.COMPLETE, function(e:Event):void {
                battleSceneCompleted = true;
            });

            var party:Party = new Party();
            battleScene.party = party;

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

            var commandPartCompleted:Boolean;
            commandPart.eventDispatcher.addEventListener(Event.COMPLETE, function(e:Event):void {
                commandPartCompleted = true;
            });

            battleScene.keyboardEventHandler(enterKeySignal);
            Assert.isTrue(commandPartCompleted);

            var actionPartCompleted:Boolean;
            actionPart.eventDispatcher.addEventListener(Event.COMPLETE, function(e:Event):void {
                actionPartCompleted = true;
            });

            while (!actionPartCompleted) {
                battleScene.enterFrameEventHandler(new Event(Event.ENTER_FRAME));
            }

            // ここまでで１ターン目が全て終了

            while (!battleSceneCompleted) {
                commandPartCompleted = false;
                actionPartCompleted = false;

                Assert.areEqual(ui.commandWindow.text, "攻撃\rスキル\rアイテム", "ここを通過する際は、デフォルトコマンドが表示されているはず");

                while (!commandPartCompleted) {
                    battleScene.keyboardEventHandler(enterKeySignal);
                }

                while (!actionPartCompleted) {
                    battleScene.enterFrameEventHandler(new Event(Event.ENTER_FRAME));
                }
            }

            var looserIsFrieds:Boolean = (f1.ability.hp.currentValue == 0 && f2.ability.hp.currentValue == 0);
            var looserIsEnemys:Boolean = (e1.ability.hp.currentValue == 0 && e2.ability.hp.currentValue == 0);

            Assert.isTrue(looserIsFrieds || looserIsEnemys, "どちらかのチームの全員の HP が 0 の状態になっているか");
        }
    }
}
