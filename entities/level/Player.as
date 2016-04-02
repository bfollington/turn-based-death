/**
 * Created by Ben on 2/04/2016.
 */
package entities.level {
    import data.IMoveTarget;
    import data.Move;
    import data.MoveTypes;

    import net.flashpunk.graphics.Image;
    import net.flashpunk.masks.Hitbox;

    import volticpunk.entities.VEntity;
    import volticpunk.util.Promise;

    public class Player extends VEntity implements IMoveTarget {
        public function Player(x: Number = 0, y: Number = 0) {
            super(x, y, Image.createCircle(16, 0xFF0000), new Hitbox(32, 32));
        }

        override public function update(): void {
            super.update();
        }

        public function applyMove(move: Move): Promise {

            if (move.getType() == MoveTypes.MOVE) {
                return getTweener().tween(this, {x: move.getData().x, y: move.getData().y}, 30);
            }

            if (move.getType() == MoveTypes.ATTACK) {
                
            }

            var p = new Promise();
            p.resolve();

            return p;
        }
    }
}
