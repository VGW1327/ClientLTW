


//hbm.Game.GUI.IngameMail.IngameMail

package hbm.Game.GUI.IngameMail
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.PagingArrayModel;
    import org.aswing.JList;
    import hbm.Game.GUI.Tools.Flipper;
    import org.aswing.JLabel;
    import hbm.Game.GUI.CashShopNew.ButtonPrototype;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.BorderLayout;
    import org.aswing.Component;
    import org.aswing.BoxLayout;
    import org.aswing.event.ListItemEvent;
    import hbm.Engine.Actors.MailHeaderData;
    import flash.display.Bitmap;
    import org.aswing.AssetBackground;
    import org.aswing.geom.IntDimension;
    import org.aswing.CenterLayout;
    import org.aswing.AssetIcon;
    import org.aswing.Icon;
    import hbm.Game.Utility.HtmlText;
    import flash.events.Event;
    import org.aswing.FlowLayout;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;

    public class IngameMail extends WindowPrototype 
    {

        private const WIDTH:int = 490;
        private const HEIGHT:int = 430;
        private const _titleStr:String = ClientApplication.Localization.MAIL_WINDOW_HEADER;

        private var _itemsPerPage:int = 3;
        private var _pagingData:PagingArrayModel;
        private var _mailList:JList;
        private var _flipper:Flipper;
        private var _mailCountLabel:JLabel;
        private var _lastMailId:int = -1;
        private var _removeButton:ButtonPrototype;
        private var _graphicsLib:AdditionalDataResourceLibrary;
        private var _localisationLib:LocalizationResourceLibrary;

        public function IngameMail()
        {
            super(null, this._titleStr, modal, this.WIDTH, this.HEIGHT);
            this._graphicsLib = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localisationLib = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this.InitGUI();
        }

        private function InitGUI():void
        {
            this.Body.append(this.CreateMailList());
            this.Bottom.removeAll();
            this.Bottom.append(this.CreateBottomPane());
            setLocationXY(((ClientApplication.stageWidth - this.WIDTH) / 2), 90);
        }

        private function CreateMailList():Component
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_1.setBorder(new EmptyBorder(null, new Insets(0, 12)));
            _local_1.setPreferredWidth(438);
            _local_1.setPreferredHeight(350);
            _local_1.append(this.CreateListPanel(), BorderLayout.CENTER);
            _local_1.append(this.CreateFlipper(), BorderLayout.SOUTH);
            return (_local_1);
        }

        private function CreateListPanel():Component
        {
            var _local_1:JPanel = new JPanel(new BoxLayout());
            _local_1.setBackgroundDecorator(this.GetBackgroundDecorator("IngameMailListBackground"));
            _local_1.setPreferredHeight(275);
            this._mailList = new JList();
            this._mailList.setBorder(new EmptyBorder(null, new Insets(12, 8, 5, 8)));
            this._mailList.setCellFactory(new MailCellFactory());
            this._mailList.addEventListener(ListItemEvent.ITEM_CLICK, this.OnMailSelected, false, 0, true);
            _local_1.append(this._mailList);
            return (_local_1);
        }

        private function OnMailSelected(_arg_1:ListItemEvent):void
        {
            var _local_2:MailHeaderData = this._mailList.getSelectedValue();
            if (_local_2)
            {
                if (this._lastMailId == _local_2.MailId)
                {
                    ClientApplication.Instance.MailInstance.OpenMailBody(_local_2.MailId);
                };
                this._lastMailId = _local_2.MailId;
                this._removeButton.visible = true;
            };
        }

        private function GetBackgroundDecorator(_arg_1:String):AssetBackground
        {
            var _local_2:Bitmap = this._graphicsLib.GetBitmapAsset(("AdditionalData_Item_" + _arg_1));
            return (new AssetBackground(_local_2));
        }

        private function CreateFlipper():Component
        {
            this._flipper = new Flipper();
            this._flipper.SetText("");
            this._flipper.addEventListener(Flipper.ON_FORWARD, this.OnFlipForward);
            this._flipper.addEventListener(Flipper.ON_BACKWARD, this.OnFlipBack);
            this._flipper.setPreferredSize(new IntDimension(150, 25));
            var _local_1:JPanel = new JPanel(new CenterLayout());
            _local_1.append(this._flipper);
            _local_1.setPreferredWidth(478);
            _local_1.setPreferredHeight(45);
            return (_local_1);
        }

        private function GetADIcon(_arg_1:String):Icon
        {
            var _local_2:Bitmap = this._localisationLib.GetBitmapAsset(("Localization_Item_" + _arg_1));
            return (new AssetIcon(_local_2));
        }

        private function OnFlipBack(_arg_1:Event):void
        {
            if (this._pagingData)
            {
                this._pagingData.MoveBackward();
                this.SetPageToList(this._pagingData.CurrentPage);
                this._flipper.SetText(HtmlText.GetText(ClientApplication.Localization.LOADING_ADDITIONAL_WINDOW_INFO_PART1, this._flipper.CurrentPage, this._flipper.Pages));
            };
        }

        private function OnFlipForward(_arg_1:Event):void
        {
            if (this._pagingData)
            {
                this._pagingData.MoveForward();
                this.SetPageToList(this._pagingData.CurrentPage);
                this._flipper.SetText(HtmlText.GetText(ClientApplication.Localization.LOADING_ADDITIONAL_WINDOW_INFO_PART1, this._flipper.CurrentPage, this._flipper.Pages));
            };
        }

        private function SetPageToList(_arg_1:Array):void
        {
            this._removeButton.visible = false;
            this._lastMailId = -1;
            this._mailList.setSelectedIndex(-1);
            this._mailList.setListData(_arg_1);
        }

        private function CreateBottomPane():Component
        {
            var _local_1:JPanel = new JPanel(new BoxLayout());
            this._mailCountLabel = new JLabel("");
            var _local_2:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            _local_2.setBorder(new EmptyBorder(null, new Insets(2)));
            this._removeButton = new ButtonPrototype();
            this._removeButton.addActionListener(this.OnRemove);
            this._removeButton.setIcon(this.GetADIcon("IngameMailButtonRemoveInactive"));
            this._removeButton.setRollOverIcon(this.GetADIcon("IngameMailButtonRemoveActive"));
            this._removeButton.setPressedIcon(this.GetADIcon("IngameMailButtonRemovePressed"));
            this._removeButton.setPreferredWidth(70);
            this._removeButton.setPreferredHeight(25);
            this._removeButton.setOpaque(false);
            this._removeButton.addActionListener(this.OnDeletePressed, 0, true);
            _local_2.append(this._removeButton);
            _local_1.append(this._mailCountLabel);
            _local_1.append(_local_2);
            return (_local_1);
        }

        private function OnRemove(_arg_1:Event):void
        {
        }

        public function SetData(_arg_1:Array):void
        {
            var _local_2:int;
            if (_arg_1)
            {
                _local_2 = ((this._pagingData) ? int(Math.min(this._pagingData.CurrentPageIndex, ((_arg_1.length - 1) / this._itemsPerPage))) : 0);
                this._pagingData = new PagingArrayModel(_arg_1, this._itemsPerPage);
                this._pagingData.MoveToPage(_local_2);
                this.SetPageToList(this._pagingData.CurrentPage);
                this._mailCountLabel.setText(HtmlText.GetText((ClientApplication.Localization.MAIL_WINDOW_MAILCOUNT + ClientApplication.Localization.LOADING_ADDITIONAL_WINDOW_INFO_PART1), _arg_1.length, 50));
                this._flipper.CurrentPage = (this._pagingData.CurrentPageIndex + 1);
                this._flipper.Pages = ((_arg_1.length > 0) ? int(Math.ceil(Number((_arg_1.length / this._itemsPerPage)))) : 1);
                this._flipper.SetText(HtmlText.GetText(ClientApplication.Localization.LOADING_ADDITIONAL_WINDOW_INFO_PART1, this._flipper.CurrentPage, this._flipper.Pages));
            };
        }

        private function OnDeletePressed(evt:Event):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.MAIL_WINDOW_DELETE_MESSAGE, function OnAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendMailDelete(_lastMailId);
                };
            }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }


    }
}//package hbm.Game.GUI.IngameMail

