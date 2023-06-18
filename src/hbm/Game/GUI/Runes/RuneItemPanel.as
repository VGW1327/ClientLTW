


//hbm.Game.GUI.Runes.RuneItemPanel

package hbm.Game.GUI.Runes
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.FlowLayout;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.SoftBoxLayout;
    import org.aswing.BorderLayout;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import org.aswing.event.AWEvent;

    public class RuneItemPanel extends JPanel 
    {

        private var _slot:RuneSlot;
        private var _itemSlot:UpgradeItemSlot;
        private var _extractGoldButton:CustomButton;
        private var _extractSilverButton:CustomButton;
        private var _insertButton:CustomButton;
        private var _createSlotButton:CustomButton;

        public function RuneItemPanel(_arg_1:RuneSlot, _arg_2:UpgradeItemSlot)
        {
            this._slot = _arg_1;
            this._itemSlot = _arg_2;
            var _local_3:LineBorder = new LineBorder(null, new ASColor(5333109), 1, 4);
            setBorder(_local_3);
            setPreferredWidth(350);
            var _local_4:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            _local_4.setPreferredWidth(280);
            this._extractGoldButton = new CustomButton(ClientApplication.Localization.UPGRADE_WINDOW_EXTRACT_GOLD_BUTTON);
            this._extractGoldButton.setPreferredWidth(130);
            this._extractGoldButton.addActionListener(this.OnExtractGoldPressed, 0, true);
            this._extractGoldButton.visible = false;
            var _local_5:CustomToolTip = new CustomToolTip(this._extractGoldButton, ClientApplication.Instance.GetPopupText(194), 220, 40);
            _local_4.append(this._extractGoldButton);
            this._extractSilverButton = new CustomButton(ClientApplication.Localization.UPGRADE_WINDOW_EXTRACT_SILVER_BUTTON);
            this._extractSilverButton.setPreferredWidth(130);
            this._extractSilverButton.addActionListener(this.OnExtractSilverPressed, 0, true);
            this._extractSilverButton.visible = false;
            var _local_6:CustomToolTip = new CustomToolTip(this._extractSilverButton, ClientApplication.Instance.GetPopupText(195), 220, 40);
            _local_4.append(this._extractSilverButton);
            this._insertButton = new CustomButton(ClientApplication.Localization.UPGRADE_WINDOW_INSERT_BUTTON);
            this._insertButton.setPreferredWidth(70);
            this._insertButton.addActionListener(this.OnInsertPressed, 0, true);
            this._insertButton.visible = false;
            var _local_7:CustomToolTip = new CustomToolTip(this._insertButton, ClientApplication.Instance.GetPopupText(196), 160, 30);
            _local_4.append(this._insertButton);
            this._createSlotButton = new CustomButton(ClientApplication.Localization.UPGRADE_WINDOW_CREATE_SLOT_BUTTON);
            this._createSlotButton.setPreferredWidth(210);
            this._createSlotButton.setEnabled(false);
            this._createSlotButton.visible = false;
            _local_4.append(this._createSlotButton);
            var _local_8:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
            append(this._slot, BorderLayout.WEST);
            append(_local_8, BorderLayout.CENTER);
            append(_local_4, BorderLayout.EAST);
            pack();
        }

        public function get SlotRune():RuneSlot
        {
            return (this._slot);
        }

        public function Revalidate():void
        {
            this._slot.Revalidate();
            this._extractGoldButton.visible = false;
            this._extractSilverButton.visible = false;
            this._insertButton.visible = false;
            this._createSlotButton.visible = false;
            switch (this._slot.SlotType)
            {
                case 1:
                    if (this._slot.Item)
                    {
                        this._extractGoldButton.visible = true;
                        this._extractSilverButton.visible = true;
                    };
                    return;
                case 0:
                    this._insertButton.visible = true;
                    this._insertButton.setEnabled((!(this._slot.Item == null)));
                    return;
                default:
                    this._createSlotButton.visible = true;
            };
        }

        private function OnExtractGoldPressed(evt:AWEvent):void
        {
            var/*const*/ priceInCols:int = 10;
            if (((this._itemSlot.Item) && (this._slot.Item)))
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.UPGRADE_WINDOW_EXTRACT_GOLD_MESSAGE + " ") + priceInCols), function OnOperationAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendRemoveCard(_itemSlot.Item.Item.Id, _slot.Item.Item.NameId, 0);
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            };
        }

        private function OnExtractSilverPressed(evt:AWEvent):void
        {
            var/*const*/ price:int = 100000;
            if (((this._itemSlot.Item) && (this._slot.Item)))
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.UPGRADE_WINDOW_EXTRACT_SILVER_MESSAGE + " ") + price), function OnOperationAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendRemoveCard(_itemSlot.Item.Item.Id, _slot.Item.Item.NameId, 1);
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            };
        }

        private function OnInsertPressed(evt:AWEvent):void
        {
            if (((this._itemSlot.Item) && (this._slot.Item)))
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.UPGRADE_WINDOW_INSERT_MESSAGE, function OnOperationAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance._currentSlotId = _slot.SlotIndex;
                        ClientApplication.Instance.LocalGameClient.SendInsertCard(_itemSlot.Item.Item.Id, _slot.Item.Item.Id);
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            };
        }


    }
}//package hbm.Game.GUI.Runes

