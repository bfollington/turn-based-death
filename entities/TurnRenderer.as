/**
 * Created by Ben on 2/04/2016.
 */
package entities {
    import data.Move;
    import data.MoveTypes;
    import data.Turn;

    import entities.move.AttackMoveRenderer;

    import entities.move.MoveMoveRenderer;

    import net.flashpunk.utils.Draw;

    import volticpunk.entities.VEntity;

    public class TurnRenderer extends VEntity {

        private var turn: Turn;

        private static var moveRenderers: Object;

        public function TurnRenderer(turn: Turn = null) {
            super();

            setTurn(turn);
            initMoveRenderLookup();
        }

        private function initMoveRenderLookup(): void {
            if (moveRenderers == null) {
                moveRenderers = {};
                moveRenderers[MoveTypes.MOVE] = new MoveMoveRenderer();
                moveRenderers[MoveTypes.ATTACK] = new AttackMoveRenderer();
            }
        }

        public function setTurn(turn: Turn): void {
            this.turn = turn;
        }

        override public function render(): void {
            super.render();

            if (turn == null) return;

            for each (var move: Move in turn.getAllMoves()) {
                moveRenderers[move.getType()].render(move);
            }
        }
    }
}
