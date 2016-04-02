/**
 * Created by Ben on 2/04/2016.
 */
package entities.level {
    import data.IMoveTarget;
    import data.Move;
    import data.MoveTypes;

    import net.flashpunk.graphics.Image;
    import net.flashpunk.masks.Hitbox;
    import net.flashpunk.utils.Ease;

    import volticpunk.entities.VEntity;
    import volticpunk.util.Promise;

    public class Enemy extends VEntity implements IMoveTarget {
        public function Enemy(x: Number = 0, y: Number = 0) {
            super(x, y, Image.createCircle(16, 0x00FF00), new Hitbox(32, 32));

            type = "enemy";
        }

        override public function update(): void {
            super.update();
        }

        public function damage(amount: Number): Promise {
            return room.cam.screenshake(amount / 3, 0.2, true);
        }

        public function applyMove(move: Move): Promise {

            if (move.getType() == MoveTypes.MOVE) {
                return getTweener().tween(this, {x: move.getData().x, y: move.getData().y}, 0.5, Ease.quadOut);
            }

            if (move.getType() == MoveTypes.ATTACK) {
                return Wait.wait(0.5);
            }

            var p = new Promise();
            p.resolve();

            return p;
        }
    }
}
