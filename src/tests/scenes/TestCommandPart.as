package tests.scenes {

    import app.charas.Character;
    import app.charas.Party;
    import app.scenes.CommandPart;
    import app.gameEvents.GameEvent;
    import app.gameEvents.GameTextEvent;

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

            f1.commandManager.party = party;
            f2.commandManager.party = party;
            e1.commandManager.party = party;
            e2.commandManager.party = party;

            var commandPart:CommandPart = new CommandPart();
            commandPart.party = party;
            commandPart.eventDispatcher.addEventListener(GameEvent.MESSAGE, function(e:GameTextEvent):void {
                trace(e.text);
                trace("------------------------");
            })

            commandPart.start();
            commandPart.decideCommand(0);
            commandPart.decideCommand(0);
        }
    }
}
