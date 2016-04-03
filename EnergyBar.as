/**
 * Created by Ben on 2/04/2016.
 */
package {
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.utils.Draw;
    import net.flashpunk.utils.Ease;

    import volticpunk.entities.VEntity;

    public class EnergyBar extends VEntity {

        private var barWidth: Number = 620;
        private var barHeight: Number = 16;

        private var max: Number = 100;
        private var min: Number = 0;
        private var value: Number = 100;
        public var displayedValue: Number = 100;

        public function EnergyBar(x: Number = 0, y: Number = 0) {
            super(x, y);

        }

        public function getMax(): Number {
            return max;
        }

        public function add(amount: Number): void {
            set(value + amount);
        }

        public function remove(amount: Number): void {
            set(value - amount);
        }

        public function set(amount: Number): void {
            value = amount;
            getTweener().tween(this, {displayedValue: amount}, 0.5, Ease.quadOut);
        }

        public function getPercentage(): Number {
            return (value - min) / max;
        }

        public function getDisplayPercentage(): Number {
            return (displayedValue - min) / max;
        }

        override public function render(): void {
            super.render();

            Draw.rect(x, y, barWidth, barHeight, 0x333333);
            Draw.rect(x, y, barWidth * getDisplayPercentage(), barHeight, 0xFFC800);
            Draw.rect(x + barWidth * getDisplayPercentage(), y, Math.abs(value - displayedValue), barHeight, 0xFFFFFF);
        }
    }
}
