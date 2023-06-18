


//hbm.Game.GUI.IngameMail.MailCellFactory

package hbm.Game.GUI.IngameMail
{
    import org.aswing.ListCellFactory;
    import org.aswing.ListCell;

    public class MailCellFactory implements ListCellFactory 
    {


        public function isShareCells():Boolean
        {
            return (false);
        }

        public function isAllCellHasSameHeight():Boolean
        {
            return (true);
        }

        public function createNewCell():ListCell
        {
            return (new MailItemCell());
        }

        public function getCellHeight():int
        {
            return (83);
        }


    }
}//package hbm.Game.GUI.IngameMail

