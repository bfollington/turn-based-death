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

    public class Player extends VEntity implements IMoveTarget {
        public function Player(x: Number = 0, y: Number = 0) {
            super(x, y, Image.createCircle(16, 0xFF0000), new Hitbox(32, 32));

            type = "player";
        }

        override public function update(): void {
            super.update();
        }

        private function onAttack(move: Move): Promise {

            var enemy: Enemy = collide("enemy", x, y) as Enemy;

            if (enemy) {
                return enemy.damage(move.getData().damage);
            } else {
                return Wait.wait(0.5);
            }

        }

        public function applyMove(move: Move): Promise {

            if (move.getType() == MoveTypes.MOVE) {
                return getTweener().tween(this, {x: move.getData().x, y: move.getData().y}, 0.5, Ease.quadOut);
            }

            if (move.getType() == MoveTypes.ATTACK) {
                return onAttack(move);
            }

            var p = new Promise();
            p.resolve();

            return p;
        }
    }
}
