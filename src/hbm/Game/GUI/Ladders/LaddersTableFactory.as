


//hbm.Game.GUI.Ladders.LaddersTableFactory

package hbm.Game.GUI.Ladders
{
    import org.aswing.table.TableCellFactory;
    import org.aswing.table.TableCell;

    public class LaddersTableFactory implements TableCellFactory 
    {


        public function createNewCell(_arg_1:Boolean):TableCell
        {
            return (new LaddersTableCell());
        }


    }
}//package hbm.Game.GUI.Ladders

