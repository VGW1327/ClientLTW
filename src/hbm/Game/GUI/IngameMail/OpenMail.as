


//hbm.Game.GUI.IngameMail.OpenMail

package hbm.Game.GUI.IngameMail
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import hbm.Application.ClientApplication;
    import org.aswing.JLabel;
    import org.aswing.JTextArea;
    import org.aswing.JPanel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Game.GUI.CashShopNew.ButtonPrototype;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.SoftBoxLayout;
    import org.aswing.Component;
    import org.aswing.BoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import flash.display.Bitmap;
    import org.aswing.AssetBackground;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.AssetIcon;
    import org.aswing.Icon;
    import hbm.Game.GUI.Cart.InventoryVendingItem;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Actors.MailHeaderData;
    import flash.events.Event;
    import hbm.Game.Utility.HtmlText;

    public class OpenMail extends WindowPrototype 
    {

        private var _winWidth:int = 500;
        private var _winHeight:int = 390;
        private var _windowTitle:String = ClientApplication.Localization.MAIL_WINDOW_BODY_HEADER;
        private var _senderString:String = ClientApplication.Localization.MAIL_WINDOW_SENDER;
        private var _titleString:String = ClientApplication.Localization.MAIL_WINDOW_TITLE;
        private var _messageString:String = ClientApplication.Localization.MAIL_WINDOW_MESSAGE;
        private var _attachedString:String = ClientApplication.Localization.MAIL_WINDOW_ITEM;
        private var _senderLabel:JLabel;
        private var _titleLabel:JLabel;
        private var _messageLabel:JLabel;
        private var _attachedItemLabel:JLabel;
        private var _senderField:JLabel;
        private var _titleField:JLabel;
        private var _messageArea:JTextArea;
        private var _attachedItem:JPanel;
        private var _mailId:int;
        private var _graphicsLib:AdditionalDataResourceLibrary;
        private var _localisationLib:LocalizationResourceLibrary;
        protected var _itemsLibrary:ItemsResourceLibrary;
        private var _labelsWidth:int = 40;
        private var _getItemButton:ButtonPrototype;

        public function OpenMail()
        {
            super(null, this._windowTitle, true, this._winWidth, this._winHeight);
            this._graphicsLib = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localisationLib = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this._itemsLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            this.InitGUI();
        }

        private function InitGUI():void
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 6));
            _local_1.append(this.CreateMailPanel());
            _local_1.append(this.CreateAttachmentPanel());
            this.Body.append(_local_1);
            this.Bottom.removeAll();
            this.Bottom.append(this.CreateButtonsPanel());
            setLocationXY((((ClientApplication.stageWidth - this._winWidth) / 2) + 20), 110);
        }

        private function CreateMailPanel():Component
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_1.append(this.CreateSenderField());
            _local_1.append(this.CreateTitleField());
            _local_1.append(this.CreateMessageArea());
            return (_local_1);
        }

        private function CreateSenderField():JPanel
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout());
            this._senderLabel = new JLabel(this._senderString);
            this.PrepareLabel(this._senderLabel);
            var _local_2:JPanel = new JPanel(new BoxLayout());
            _local_2.setPreferredHeight(27);
            _local_2.setPreferredWidth(391);
            _local_2.setBackgroundDecorator(this.GetBackgroundDecorator("IngameMailStringFieldBackground"));
            this._senderField = new JLabel("");
            this._senderField.setBorder(new EmptyBorder(null, new Insets(0, 5)));
            this._senderField.setHorizontalAlignment(JLabel.LEFT);
            this._senderField.setVerticalAlignment(JLabel.CENTER);
            _local_2.append(this._senderField);
            _local_1.append(this._senderLabel);
            _local_1.append(_local_2);
            return (_local_1);
        }

        private function CreateTitleField():JPanel
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout());
            this._titleLabel = new JLabel(this._titleString);
            this.PrepareLabel(this._titleLabel);
            var _local_2:JPanel = new JPanel(new BoxLayout());
            _local_2.setPreferredHeight(27);
            _local_2.setPreferredWidth(391);
            _local_2.setBackgroundDecorator(this.GetBackgroundDecorator("IngameMailStringFieldBackground"));
            this._titleField = new JLabel("");
            this._titleField.setBorder(new EmptyBorder(null, new Insets(0, 5)));
            this._titleField.setHorizontalAlignment(JLabel.LEFT);
            this._titleField.setVerticalAlignment(JLabel.CENTER);
            this._titleField.setOpaque(false);
            _local_2.append(this._titleField);
            _local_1.append(this._titleLabel);
            _local_1.append(_local_2);
            return (_local_1);
        }

        private function CreateMessageArea():JPanel
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout());
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            this._messageLabel = new JLabel(this._messageString);
            this.PrepareLabel(this._messageLabel);
            _local_2.append(this._messageLabel);
            var _local_3:JPanel = new JPanel(new BoxLayout());
            _local_3.setPreferredHeight(156);
            _local_3.setPreferredWidth(391);
            _local_3.setBackgroundDecorator(this.GetBackgroundDecorator("IngameMailStringAreaBackground"));
            this._messageArea = new JTextArea("");
            this._messageArea.setBorder(new EmptyBorder(null, new Insets(4, 6, 4, 6)));
            this._messageArea.setOpaque(false);
            this._messageArea.setEditable(false);
            this._messageArea.getTextField().selectable = false;
            this._messageArea.setWordWrap(true);
            _local_3.append(this._messageArea);
            _local_1.append(_local_2);
            _local_1.append(_local_3);
            return (_local_1);
        }

        private function GetBackgroundDecorator(_arg_1:String):AssetBackground
        {
            var _local_2:Bitmap = this._graphicsLib.GetBitmapAsset(("AdditionalData_Item_" + _arg_1));
            return (new AssetBackground(_local_2));
        }

        private function PrepareLabel(_arg_1:JLabel):void
        {
            _arg_1.setBorder(new EmptyBorder(null, new Insets(4)));
            _arg_1.setPreferredWidth(this._labelsWidth);
            _arg_1.setPreferredHeight(25);
            _arg_1.setHorizontalAlignment(JLabel.RIGHT);
            _arg_1.setVerticalAlignment(JLabel.TOP);
        }

        private function CreateAttachmentPanel():Component
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 5, SoftBoxLayout.RIGHT));
            _local_1.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 10)));
            this._attachedItemLabel = new JLabel(this._attachedString);
            this._attachedItemLabel.setVerticalAlignment(JLabel.CENTER);
            this._attachedItemLabel.setHorizontalAlignment(JLabel.RIGHT);
            this._attachedItem = new JPanel(new EmptyLayout());
            this._attachedItem.setBackgroundDecorator(this.GetBackgroundDecorator("IngameMailItemPlateBackground"));
            this._attachedItem.setPreferredSize(new IntDimension(38, 39));
            _local_1.append(this._attachedItemLabel);
            _local_1.append(this._attachedItem);
            return (_local_1);
        }

        private function CreateButtonsPanel():Component
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 10, SoftBoxLayout.RIGHT));
            this._getItemButton = new ButtonPrototype();
            this._getItemButton.setIcon(this.GetADIcon("IngameMailTakeItemButtonInactive"));
            this._getItemButton.setRollOverIcon(this.GetADIcon("IngameMailTakeItemButtonActive"));
            this._getItemButton.setPressedIcon(this.GetADIcon("IngameMailTakeItemButtonPressed"));
            this._getItemButton.setOpaque(false);
            this._getItemButton.setPreferredSize(new IntDimension(70, 25));
            this._getItemButton.addActionListener(this.OnGetPressed, 0, true);
            _local_1.append(this._getItemButton);
            return (_local_1);
        }

        private function GetADIcon(_arg_1:String):Icon
        {
            var _local_2:Bitmap = this._localisationLib.GetBitmapAsset(("Localization_Item_" + _arg_1));
            return (new AssetIcon(_local_2));
        }

        private function GetLocIcon(_arg_1:String):Icon
        {
            var _local_2:Bitmap = this._localisationLib.GetBitmapAsset(("Localization_Item_" + _arg_1));
            return (new AssetIcon(_local_2));
        }

        public function SetData(_arg_1:MailHeaderData, _arg_2:String, _arg_3:ItemData):void
        {
            var _local_4:InventoryVendingItem;
            this._mailId = _arg_1.MailId;
            this._senderField.setText(this.convertText(_arg_1.From));
            this._titleField.setText(this.convertText(_arg_1.Title));
            this._attachedItem.removeAll();
            if (_arg_1.Money > 0)
            {
                _arg_3 = new ItemData();
                _arg_3.Amount = _arg_1.Money;
                _arg_3.NameId = 2;
                _arg_3.Identified = 1;
                _arg_3.Attr = 0;
            };
            if (((_arg_3) && (_arg_3.NameId > 0)))
            {
                _arg_3.Type = 0;
                _local_4 = new InventoryVendingItem(_arg_3, false);
                if (_local_4)
                {
                    this._attachedItemLabel.visible = true;
                    this._attachedItem.visible = true;
                    this._getItemButton.visible = true;
                    _local_4.setSizeWH(32, 32);
                    _local_4.setLocationXY(3, 3);
                    this._attachedItem.append(_local_4);
                };
            }
            else
            {
                this._attachedItemLabel.visible = false;
                this._attachedItem.visible = false;
                this._getItemButton.visible = false;
            };
            this._messageArea.setText(this.convertText(_arg_2, _arg_3));
        }

        private function OnGetPressed(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendMailGetAttach(this._mailId);
            this.dispose();
        }

        private function convertText(_arg_1:String, _arg_2:ItemData=null):String
        {
            var _local_3:String;
            var _local_4:Array;
            if (_arg_1.indexOf("#a") == 0)
            {
                _arg_1 = _arg_1.substring(2, _arg_1.length);
                _local_4 = _arg_1.split(":");
                if (((_local_4) && (_local_4.length > 0)))
                {
                    switch (int(_local_4[0]))
                    {
                        case 0:
                            return (ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG0);
                        case 1:
                        case 9:
                            _local_3 = this._itemsLibrary.GetItemFullName(int(_local_4[2]));
                            return (HtmlText.GetText(ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG1, _local_3, _local_4[1]));
                        case 2:
                        case 10:
                            _local_3 = this._itemsLibrary.GetItemFullName(int(_local_4[2]));
                            return (HtmlText.GetText(ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG2, _local_3, _local_4[1]));
                        case 3:
                            _local_3 = this._itemsLibrary.GetItemFullName(int(_local_4[2]));
                            return (HtmlText.GetText(ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG3, _local_3));
                        case 4:
                            _local_3 = this._itemsLibrary.GetItemFullName(int(_local_4[2]));
                            return (HtmlText.GetText(ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG4, _local_3));
                        case 5:
                            _local_3 = this._itemsLibrary.GetItemFullName(int(_local_4[2]));
                            return (HtmlText.GetText(ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG5, _local_3, _local_4[1]));
                        case 6:
                            _local_3 = this._itemsLibrary.GetItemFullName(int(_local_4[2]));
                            return (HtmlText.GetText(ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG6, _local_3, _local_4[1]));
                        case 7:
                            _local_3 = this._itemsLibrary.GetItemFullName(int(_local_4[2]));
                            return (HtmlText.GetText(ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG7, _local_3, _local_4[1]));
                        case 8:
                            _local_3 = this._itemsLibrary.GetItemFullName(int(_local_4[2]));
                            return (HtmlText.GetText(ClientApplication.Localization.MAIL_WINDOW_AUCTION_MSG8, _local_3, _local_4[1]));
                    };
                };
            };
            return (_arg_1);
        }


    }
}//package hbm.Game.GUI.IngameMail

