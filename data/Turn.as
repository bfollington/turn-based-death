/**
 * Created by Ben on 2/04/2016.
 */
package data {
    import volticpunk.util.Promise;
    import volticpunk.util.VectorUtil;

    public class Turn {

        private var moves: Vector.<Move>;
        private var playbackCursor: int = 0;
        private var playbackPromise: Promise;

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
                moves[playbackCursor].apply().then(onNextMove);
            } else {
                playbackPromise.resolve();
            }
        }
        
        public function play(): Promise {
            playbackCursor = 0;
            moves[playbackCursor].apply().then(onNextMove);

            playbackPromise = new Promise();

            return playbackPromise;
        }
    }
}
