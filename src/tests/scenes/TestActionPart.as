package tests.scenes {

    import app.scenes.ActionPart;
    import app.charas.Character;
    import app.charas.Party;
    import app.coms.TargetType;
    import flash.events.Event;
    import app.gameEvents.GameEvent;
    import app.gameEvents.GameTextEvent;

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

            var actionPart:ActionPart = new ActionPart();
            actionPart.eventDispatcher.addEventListener(Event.COMPLETE, function(e:Event):void {
                actionPart.pause();
            });

            var msg:String;
            actionPart.eventDispatcher.addEventListener(GameEvent.MESSAGE, function(e:GameTextEvent):void {
                msg = e.text;
            });

            actionPart.party = party;

            for each (var c:Character in party.getMembers(TargetType.ALL)) {
                c.commandManager.party = party;
                c.commandManager.autoSetting();
            }

            actionPart.start();
            for (var i:int = 0; i < actionPart.longWait * 4; i++) {
                actionPart.eventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
            }
        }
    }
}
