package {

    import flash.display.Sprite;
    import tests.Assert;
    import tests.charas.TestAbilityValue;
    import flash.desktop.NativeApplication;
    import tests.charas.TestCharacter;
    import tests.coms.TestCommandManager;
    import tests.coms.TestActionManager;

    public class Tester extends Sprite {
        public function Tester() {

            new TestAbilityValue();
            new TestCharacter();
            new TestCommandManager();
            new TestActionManager();

            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");

            NativeApplication.nativeApplication.exit();
        }
    }
}
