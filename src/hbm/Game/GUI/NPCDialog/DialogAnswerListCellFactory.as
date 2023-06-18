


//hbm.Game.GUI.NPCDialog.DialogAnswerListCellFactory

package hbm.Game.GUI.NPCDialog
{
    import org.aswing.ListCellFactory;
    import org.aswing.ListCell;

    public class DialogAnswerListCellFactory implements ListCellFactory 
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
            return (new DialogAnswerListCell());
        }

        public function getCellHeight():int
        {
            return (DialogAnswerListCell.HEIGHT + 2);
        }


    }
}//package hbm.Game.GUI.NPCDialog

