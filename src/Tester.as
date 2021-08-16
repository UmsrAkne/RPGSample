package {

    import flash.display.Sprite;
    import tests.Assert;
    import tests.charas.TestAbilityValue;
    import flash.desktop.NativeApplication;
    import tests.charas.TestCharacter;

    public class Tester extends Sprite {
        public function Tester() {

            new TestAbilityValue();
            new TestCharacter();

            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");

            NativeApplication.nativeApplication.exit();
        }
    }
}
