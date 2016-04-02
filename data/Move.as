/**
 * Created by Ben on 2/04/2016.
 */
package data {
    import volticpunk.util.Promise;

    public class Move {

        private var target: IMoveTarget;
        private var cost: Number;
        private var content: Object;
        private var type: String;

        public function Move(entity: IMoveTarget, type: String, energy: Number, data: Object) {
            target = entity;
            cost = energy;
            content = data;
            this.type = type;
        }

        public function getType(): String {
            return type;
        }

        public function apply(): Promise {
            return target.applyMove(this);
        }

        public function getData(): Object {
            return content;
        }

        public function getCost(): Number {
            return cost;
        }
    }
}
