package tests.scenes {

    import app.charas.Character;
    import app.charas.Party;
    import app.scenes.CommandPart;
    import app.gameEvents.GameEvent;
    import app.gameEvents.GameTextEvent;
    import tests.Assert;
    import flash.events.Event;
    import app.coms.TargetType;

    public class TestCommandPart {
        public function TestCommandPart() {
            test();
        }

        private function test():void {
            var cs:Vector.<Character> = new Vector.<Character>();
            var f1:Character = new Character("f1", true);
            var f2:Character = new Character("f1", true);
            var e1:Character = new Character("e1", false);
            var e2:Character = new Character("e2", false);

            var party:Party = new Party();
            party.members.push(f1, f2, e1, e2);

            for each (var c:Character in party.getMembers(TargetType.ALL)) {
                c.ability.hp.maxValue = 10;
                c.ability.hp.currentValue = 10;
                c.commandManager.party = party;
            }

            var commandPart:CommandPart = new CommandPart();
            commandPart.party = party;

            var gameTextEvent:GameTextEvent;
            var commandSelectCompleted:Boolean;

            commandPart.eventDispatcher.addEventListener(GameEvent.MESSAGE, function(e:GameTextEvent):void {
                gameTextEvent = e;
            });

            commandPart.eventDispatcher.addEventListener(Event.COMPLETE, function(e:Event):void {
                commandSelectCompleted = true;
            });

            commandPart.start();
            Assert.areEqual(gameTextEvent.text, "攻撃\nスキル\nアイテム");

            commandPart.decideCommand(0);
            Assert.areEqual(gameTextEvent.text, "e1\ne2");

            // 一人目のコマンド選択が終了
            commandPart.decideCommand(0);
            Assert.isTrue(f1.commandManager.commandSelected);

            // コマンド選択シーンはまだ未完了
            Assert.isFalse(commandSelectCompleted);

            // 続いて二人目のコマンド選択に移行
            Assert.areEqual(gameTextEvent.text, "攻撃\nスキル\nアイテム");

            // スキルを選択
            commandPart.decideCommand(1);
            Assert.areEqual(gameTextEvent.text, "攻撃");

            commandPart.decideCommand(0);
            Assert.areEqual(gameTextEvent.text, "e1\ne2");

            commandPart.decideCommand(1);

            // コマンド選択完了を確認
            Assert.isTrue(commandSelectCompleted);
        }
    }
}
