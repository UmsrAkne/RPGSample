package tests.scenes {

    import app.scenes.ActionPart;
    import app.charas.Character;
    import app.charas.Party;
    import app.coms.TargetType;
    import flash.events.Event;
    import app.gameEvents.GameEvent;
    import app.gameEvents.GameTextEvent;
    import tests.Assert;

    public class TestActionPart {
        public function TestActionPart() {
            test();
        }

        private function test():void {
            var f1:Character = new Character("f1", true);
            var f2:Character = new Character("f2", true);
            var e1:Character = new Character("e1", false);
            var e2:Character = new Character("e2", false);

            var party:Party = new Party();
            party.members.push(f1, f2, e1, e2);

            for each (var c:Character in party.getMembers(TargetType.ALL)) {
                c.ability.hp.maxValue = 10;
                c.ability.hp.currentValue = 10;
                c.commandManager.party = party;
            }

            var partComplete:Boolean;
            var actionPart:ActionPart = new ActionPart();
            actionPart.eventDispatcher.addEventListener(Event.COMPLETE, function(e:Event):void {
                actionPart.pause();
                partComplete = true;
            });

            var msg:String;
            actionPart.eventDispatcher.addEventListener(GameEvent.MESSAGE, function(e:GameTextEvent):void {
                msg = e.text;
                // trace(msg);
            });

            actionPart.party = party;

            for each (var ch:Character in party.getMembers(TargetType.ALL)) {
                ch.commandManager.party = party;
                ch.commandManager.autoSetting();
            }

            for (var i:int = 0; i < 20; i++) {
                actionPart.start();

                while (!partComplete) {
                    actionPart.enterFrameProcess();
                }

                if (!party.canBattle()) {
                    break;
                }

                for each (ch in party.getMembers(TargetType.ALL)) {
                    ch.commandManager.party = party;
                    ch.commandManager.autoSetting();
                }

                partComplete = false;
            }

            var loserIsFriends:Boolean = (f1.ability.hp.currentValue == 0 && f2.ability.hp.currentValue == 0);
            var loserIsEnemys:Boolean = (e1.ability.hp.currentValue == 0 && e2.ability.hp.currentValue == 0);
            Assert.isTrue(loserIsFriends || loserIsEnemys, "どちらか一方のチーム全員の HP が 0 になっていれば決着がついている");
        }
    }
}
