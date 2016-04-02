/**
 * Created by Ben on 2/04/2016.
 */
package entities.level {
    import data.IMoveTarget;
    import data.Move;
    import data.MoveTypes;

    import flash.geom.Point;

    import net.flashpunk.FP;

    import net.flashpunk.graphics.Image;
    import net.flashpunk.masks.Hitbox;
    import net.flashpunk.utils.Ease;

    import volticpunk.components.PlatformerMovement;

    import volticpunk.entities.VEntity;
    import volticpunk.util.Promise;

    public class Enemy extends VEntity implements IMoveTarget {

        private var health: Number = 50;
        private var canMakeMoves: Boolean = false;

        public function Enemy(x: Number = 0, y: Number = 0) {
            super(x, y, Image.createCircle(16, 0x00FF00), new Hitbox(32, 32, -16, -16));
            getImage().centerOrigin();

            addComponent(new PlatformerMovement(new Point(0, 0), new Point(0.5, 0.5), new Point(2, 2)));
            getPlatformMovement().setCollisionTypes(C.COLLISION_TYPES);

            type = "enemy";
        }

        override public function update(): void {
            if (!canMakeMoves) return;

            super.update();

            var player: Player = room.getInstanceByClass(Player) as Player;

            if (canMakeMoves) {
                var angle =  FP.RAD * (FP.angle(x, y, player.x, player.y) + 180);
                getPlatformMovement().velocity.x = 2 * Math.cos(angle);
                getPlatformMovement().velocity.y = 2 * Math.sin(angle);
            }

        }

        public function startActivePhase(): void {
            canMakeMoves = true;
        }

        public function endActivePhase(): void {
            canMakeMoves = false;
        }

        private function onDeath(): void {
            room.cam.screenshake(10, 0.2, true);
            removeFromWorld();
        }

        public function damage(amount: Number): Promise {
            trace("OW", (new Date()).getMilliseconds());
            var me: Enemy = this;

            if (getTweener().isActive()) {
                getTweener().cancel();
            }

            getTweener().tween(getImage(), {scale: 0.5}, 0.1, Ease.quadOut)
                .then(function(): void {
                    getTweener().tween(me.getImage(), {scale: 1}, 0.1, Ease.quadOut);
                });

            health -= amount;

            if (health <= 0) {
                onDeath();
            }

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
