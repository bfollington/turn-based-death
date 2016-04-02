/**
 * Created by Ben on 2/04/2016.
 */
package {
    import flash.utils.Timer;
    import flash.utils.setTimeout;

    import volticpunk.util.Promise;

    public class Wait {
        public function Wait() {
        }

        public static function wait(time: Number): Promise {
            var p: Promise = new Promise();

            setTimeout(function(): void {
                p.resolve();
            }, time * 1000);

            return p;
        }
    }
}
