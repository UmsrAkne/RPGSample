package {

    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import tests.Assert;
    import tests.charas.TestAbilityValue;
    import tests.charas.TestCharacter;
    import tests.charas.TestParty;
    import tests.coms.TestActionManager;
    import tests.coms.TestCommandManager;
    import tests.scenes.TestCommandPart;
    import tests.scenes.TestActionPart;
    import tests.scenes.TestBattleScene;

    public class Tester extends Sprite {
        public function Tester() {

            new TestAbilityValue();
            new TestCharacter();
            new TestCommandManager();
            new TestActionManager();
            new TestParty();
            new TestCommandPart();
            new TestActionPart();
            new TestBattleScene();

            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");

            NativeApplication.nativeApplication.exit();
        }
    }
}
