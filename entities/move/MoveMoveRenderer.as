/**
 * Created by Ben on 2/04/2016.
 */
package entities.move {
    import data.Move;

    import net.flashpunk.utils.Draw;

    public class MoveMoveRenderer implements IMoveRenderer{
        public function MoveMoveRenderer() {
        }

        public function render(move: Move): void {
            Draw.circle(move.getData().x, move.getData().y, 3, 0x00FF00);
        }
    }
}
