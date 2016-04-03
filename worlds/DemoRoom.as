/**
 * Created by Ben on 2/04/2016.
 */
package worlds {
    import entities.TurnManager;
    import entities.level.Block;
    import entities.level.Enemy;
    import entities.level.Player;

    import volticpunk.worlds.Room;

    public class DemoRoom extends Room {

        private const level: Array = [
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 3, 0, 0, 0, 1],
            [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 0, 0, 0, 0, 0, 0, 2, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ];

        public function DemoRoom(fadeIn: Boolean = false) {
            super(fadeIn);
            disableDarknessOverlay();

            levelWidth = 640;
            levelHeight = 360;
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

            var energyBar: EnergyBar = new EnergyBar(10, 360 - 26);
            add(energyBar);
            add( new TurnManager(player, cam, energyBar) );

        }
    }
}
