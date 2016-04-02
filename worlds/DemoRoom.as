/**
 * Created by Ben on 2/04/2016.
 */
package worlds {
    import entities.TurnManager;
    import entities.level.Block;
    import entities.level.Enemy;
    import entities.level.Player;


    import net.flashpunk.graphics.Image;

    import volticpunk.entities.Camera;

    import volticpunk.worlds.Room;

    public class DemoRoom extends Room {

        private const level: Array = [
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 3, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ];

        public function DemoRoom(fadeIn: Boolean = false) {
            super(fadeIn);
            disableDarknessOverlay();

            levelWidth = 640;
            levelHeight = 360;

            addGraphic(Image.createCircle(32, 0xFFFFFF), 0, 600, 300);
        }
        
        override public function begin(): void {
            super.begin();

            var player: Player;
            
            for (var y: int = 0; y < level.length; y++) {
                for (var x: int = 0; x < level[y].length; x++) {
                    if (level[y][x] == 1) {
                        add( new Block(x * C.GRID, y * C.GRID) );
                    }

                    if (level[y][x] == 2) {
                        add( player = new Player(x * C.GRID, y * C.GRID) );
                    }

                    if (level[y][x] == 3) {
                        add( new Enemy(x * C.GRID, y * C.GRID) );
                    }
                }
            }

            add( new TurnManager(player, cam) );
        }
    }
}
