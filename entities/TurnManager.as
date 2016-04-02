/**
 * Created by Ben on 2/04/2016.
 */
package entities {
    import data.Move;
    import data.MoveTypes;
    import data.Turn;

    import entities.level.Enemy;

    import entities.level.Player;

    import flash.events.Event;

    import flash.geom.Point;

    import net.flashpunk.Entity;

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
        private var energyBar: EnergyBar;

        public function TurnManager(player: Player, camera: Camera, energyBar: EnergyBar) {
            super(0, 0);

            this.player = player;
            this.camera = camera;
            this.energyBar = energyBar;
            position = new Point();
            add( renderer = new TurnRenderer() );
        }

        override public function added(): void {
            super.added();

            newTurn();
        }

        public function newTurn(): void {
            if (currentTurn) {
                currentTurn.removeEventListener("PlaybackEnd", onPlaybackOver);
            }

            currentTurn = new Turn(energyBar);

            currentTurn.addEventListener("PlaybackEnd", onPlaybackOver);
            renderer.setTurn(currentTurn);
        }

        private function onPlaybackStart(e: Event = null): void {
            room.getMembersByClass(Enemy).doToEachObject(function(e: Enemy) {
                e.startActivePhase();
            });
        }

        private function onPlaybackOver(e: Event = null): void {
            room.getMembersByClass(Enemy).doToEachObject(function(e: Enemy) {
                e.endActivePhase();
            });
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
                
                onPlaybackStart();
                
                currentTurn.play(camera).then(function(): void {
                    trace("Turn OVER!");
                    newTurn();
                });
            }
        }
    }
}
