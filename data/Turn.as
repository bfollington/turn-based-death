/**
 * Created by Ben on 2/04/2016.
 */
package data {
    import flash.events.Event;
    import flash.events.EventDispatcher;

    import volticpunk.entities.Camera;
    import volticpunk.util.Promise;

    public class Turn extends EventDispatcher {

        private var moves: Vector.<Move>;
        private var playbackCursor: int = 0;
        private var playbackPromise: Promise;
        private var camera: Camera;

        private var energyBar: EnergyBar;

        public function Turn(energyBar: EnergyBar) {
            this.energyBar = energyBar;
            energyBar.set(energyBar.getMax());

            moves = new <Move>[];
        }

        public function addMove(move: Move): void {
            energyBar.remove(move.getCost());
            moves.push(move);
        }

        public function getAllMoves(): Vector.<Move> {
            return moves;
        }

        public function undo(): Move {

            if (moves.length <= 0) return null;

            var undone: Move = moves.pop();

            energyBar.add(undone.getCost());

            return undone;
        }

        private function onPlaybackEnd(): void {
            this.dispatchEvent(new Event("PlaybackEnd"));
        }

        private function onNextMove(): void {
            playbackCursor++;

            if (playbackCursor < moves.length) {
                camera.panTo(0.5, moves[playbackCursor].getData().x, moves[playbackCursor].getData().y);
                moves[playbackCursor].apply().then(onNextMove);
            } else {
                playbackPromise.resolve();
            }
        }

        public function play(camera: Camera): Promise {
            this.camera = camera;

            if (moves.length > 0) {
                playbackCursor = 0;
                moves[playbackCursor].apply().then(onNextMove);
            }

            playbackPromise = new Promise();
            playbackPromise.then(onPlaybackEnd);

            if (moves.length == 0) {
                playbackPromise.resolve();
            }

            return playbackPromise;
        }
    }
}
