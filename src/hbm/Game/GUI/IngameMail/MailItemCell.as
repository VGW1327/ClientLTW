


//hbm.Game.GUI.IngameMail.MailItemCell

package hbm.Game.GUI.IngameMail
{
    import org.aswing.ListCell;
    import org.aswing.Component;
    import hbm.Engine.Actors.MailHeaderData;
    import org.aswing.JList;
    import hbm.Application.ClientApplication;

    public class MailItemCell implements ListCell 
    {

        private var _itemPanel:MailListItem;

        public function MailItemCell()
        {
            this._itemPanel = new MailListItem();
        }

        public function getCellValue():*
        {
            return (null);
        }

        public function getCellComponent():Component
        {
            return (this._itemPanel);
        }

        public function setCellValue(_arg_1:*):void
        {
            var _local_2:MailHeaderData;
            if (((_arg_1) && (_arg_1 is MailHeaderData)))
            {
                _local_2 = (_arg_1 as MailHeaderData);
                this._itemPanel.SetMailId(_local_2.MailId);
                this._itemPanel.SetSender(this.convertText(_local_2.From));
                this._itemPanel.SetTitle(this.convertText(_local_2.Title));
                this._itemPanel.SetTime(_local_2.TimeStamp);
                this._itemPanel.SetStatus((_local_2.Status == 0));
            };
        }

        public function setListCellStatus(_arg_1:JList, _arg_2:Boolean, _arg_3:int):void
        {
            this._itemPanel.SetSelected(_arg_2);
        }

        private function convertText(_arg_1:String):String
        {
            if (_arg_1 == "#a0")
            {
                return (ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG0);
            };
            return (_arg_1);
        }


    }
}//package hbm.Game.GUI.IngameMail

