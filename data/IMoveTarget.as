/**
 * Created by Ben on 2/04/2016.
 */
package data {
    import volticpunk.util.Promise;

    public interface IMoveTarget {
        function applyMove(move: Move): Promise;
    }
}
