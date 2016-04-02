/**
 * Created by Ben on 2/04/2016.
 */
package data {
    import volticpunk.entities.Camera;
    import volticpunk.util.Promise;
    import volticpunk.util.VectorUtil;

    public class Turn {

        private var moves: Vector.<Move>;
        private var playbackCursor: int = 0;
        private var playbackPromise: Promise;
        private var camera: Camera;

        public function Turn() {
            moves = new <Move>[];
        }

        public function addMove(move: Move) {
            moves.push(move);
        }

        public function getAllMoves(): Vector.<Move> {
            return moves;
        }

        public function undo(): Move {
            return moves.pop();
        }

        private function onNextMove() {
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
            playbackCursor = 0;
            moves[playbackCursor].apply().then(onNextMove);

            playbackPromise = new Promise();

            return playbackPromise;
        }
    }
}
