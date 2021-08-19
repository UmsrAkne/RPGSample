package tests.charas {

    import app.charas.Character;
    import app.charas.Party;
    import tests.Assert;
    import app.coms.TargetType;

    public class TestParty {
        public function TestParty() {
            canBattleTest();
        }

        private function canBattleTest():void {

            var party:Party = new Party();
            var cs:Vector.<Character> = new Vector.<Character>();
            cs.push(new Character("ally1", true), new Character("ally2", true), new Character("enemy1", false), new Character("enemy2", false));

            for each (var c:Character in cs) {
                c.ability.hp.maxValue = 10;
                c.ability.hp.currentValue = 10;
                party.members.push(c);
            }

            // 全員生存状態。戦闘継続可能
            Assert.isTrue(party.canBattle());

            var allys:Vector.<Character> = party.getMembers(TargetType.FRIEND, true);

            for each (var f:Character in allys) {
                Assert.isTrue(party.canBattle());
                f.ability.hp.currentValue = 0;
            }

            // 味方キャラクターが全員 HP == 0 戦闘継続不可
            Assert.isFalse(party.canBattle());

            for each (f in allys) {
                f.ability.hp.currentValue = 10;
            }

            var enemys:Vector.<Character> = party.getMembers(TargetType.ENEMY, true);

            for each (var e:Character in enemys) {
                Assert.isTrue(party.canBattle());
                e.ability.hp.currentValue = 0;
            }

            Assert.isFalse(party.canBattle());
        }
    }
}
