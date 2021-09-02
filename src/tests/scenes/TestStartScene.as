package tests.scenes {

    import app.scenes.StartScene;
    import flash.events.Event;
    import tests.Assert;

    public class TestStartScene {
        public function TestStartScene() {
            test();
        }

        private function test():void {
            var startScene:StartScene = new StartScene();
            var completeEventDispatched:Boolean;

            startScene.addEventListener(Event.COMPLETE, function(e:Event):void {
                completeEventDispatched = true;
            });

            startScene.exitScene();
            Assert.isTrue(completeEventDispatched);
        }
    }
}
