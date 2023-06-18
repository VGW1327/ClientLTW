


//hbm.Game.GUI.PartyList.PartyListCellFactory

package hbm.Game.GUI.PartyList
{
    import org.aswing.ListCellFactory;
    import org.aswing.ListCell;

    public class PartyListCellFactory implements ListCellFactory 
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
            return (new PartyListCell());
        }

        public function getCellHeight():int
        {
            return (PartyMemberPanel.ELEMENT_HEIGHT);
        }


    }
}//package hbm.Game.GUI.PartyList

