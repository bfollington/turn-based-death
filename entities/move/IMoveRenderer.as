/**
 * Created by Ben on 2/04/2016.
 */
package entities.move {
    import data.Move;

    public interface IMoveRenderer {
        function render(move: Move): void;
    }
}
