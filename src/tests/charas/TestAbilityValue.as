package tests.charas {

    import app.charas.AbilityValue;
    import tests.Assert;

    public class TestAbilityValue {
        public function TestAbilityValue() {

            var a:AbilityValue = new AbilityValue();

            Assert.areEqual(a.currentValue, 0);
            a.currentValue = 10;

            Assert.areEqual(a.currentValue, 0);

            a.maxValue = 10;
            a.currentValue = 20;
            Assert.areEqual(a.currentValue, 10);

            Assert.areEqual(a.minValue, 0);

            a.currentValue -= 30;
            Assert.areEqual(a.currentValue, 0);

            a.minValue = 5;
            a.maxValue = -10;
            Assert.areEqual(a.maxValue, 5);

        }
    }
}
