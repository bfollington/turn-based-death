/**
 * Created by Ben on 2/04/2016.
 */
package entities.move {
    import data.Move;

    import net.flashpunk.utils.Draw;

    public class AttackMoveRenderer implements IMoveRenderer{
        public function AttackMoveRenderer() {
        }

        public function render(move: Move): void {
            Draw.circle(move.getData().x, move.getData().y, 5, 0xFF0000);
        }
    }
}
