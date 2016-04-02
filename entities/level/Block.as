/**
 * Created by Ben on 2/04/2016.
 */
package entities.level {
    import net.flashpunk.graphics.Image;
    import net.flashpunk.masks.Hitbox;

    import volticpunk.entities.VEntity;

    public class Block extends VEntity {
        public function Block(x: Number = 0, y: Number = 0) {
            super(x, y, Image.createRect(32, 32), new Hitbox(32, 32));

            type = "level";
        }
    }
}
