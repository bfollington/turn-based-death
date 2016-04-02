/**
 * Created by Ben on 2/04/2016.
 */
package entities {
    import data.Move;
    import data.MoveTypes;
    import data.Turn;

    import entities.level.Player;

    import flash.geom.Point;

    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    import volticpunk.entities.Camera;

    import volticpunk.entities.Group;

    import volticpunk.entities.VEntity;

    public class TurnManager extends Group {

        private var player: Player;
        private var currentTurn: Turn;
        private var renderer: TurnRenderer;
        private var position: Point;
        private var camera: Camera;

        public function TurnManager(player: Player, camera: Camera) {
            super(0, 0);

            this.player = player;
            this.camera = camera;
            position = new Point();
            add( renderer = new TurnRenderer() );
        }

        override public function added(): void {
            super.added();

            currentTurn = new Turn();
            renderer.setTurn(currentTurn);
        }

        override public function update(): void {
            super.update();

            if (Input.mousePressed) {
                currentTurn.addMove(new Move(player, MoveTypes.MOVE, 10, {
                    x: Input.mouseX,
                    y: Input.mouseY
                }));

                position.x = Input.mouseX;
                position.y = Input.mouseY;
            }

            if (Input.pressed(Key.A)) {
                currentTurn.addMove(new Move(player, MoveTypes.ATTACK, 10, {
                    x: position.x,
                    y: position.y,
                    damage: 10
                }));
            }

            if (Input.check(Key.CONTROL) && Input.pressed(Key.Z)) {
                currentTurn.undo();
            }
            
            if (Input.pressed(Key.ENTER)) {
                currentTurn.play(camera).then(function(): void {
                    trace("Turn OVER!");
                });
            }
        }
    }
}
