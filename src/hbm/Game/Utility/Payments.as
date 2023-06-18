


//hbm.Game.Utility.Payments

package hbm.Game.Utility
{
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import hbm.Game.GUI.CashShopNew.NewBuyCashWindow;
    import org.aswing.AttachIcon;
    import hbm.Engine.Actors.ItemData;

    public class Payments 
    {


        public static function TestAmountPay(coinsType:int, amount:uint):Boolean
        {
            var player:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (!player)
            {
                return (false);
            };
            switch (coinsType)
            {
                case ItemData.ZENY:
                    if (player.money < amount)
                    {
                        new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.BUY_DIALOG_BUY_INFO, ClientApplication.Localization.BUY_DIALOG_NOT_ENOUGH_MONEY2, function PayGold (_arg_1:int):void
                        {
                            if (_arg_1 == JOptionPane.YES)
                            {
                                ClientApplication.Instance.OpenPayDialog(NewBuyCashWindow.SILVER_PANEL);
                            };
                        }, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                        return (false);
                    };
                    break;
                case ItemData.CASH:
                    if (player.cashPoints < amount)
                    {
                        new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.BUY_DIALOG_BUY_INFO, ClientApplication.Localization.BUY_DIALOG_NOT_ENOUGH_MONEY, function PayGold (_arg_1:int):void
                        {
                            if (_arg_1 == JOptionPane.YES)
                            {
                                ClientApplication.Instance.OpenPayDialog();
                            };
                        }, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                        return (false);
                    };
                    break;
            };
            return (true);
        }

        public static function ConfirmPayDialog(coinsType:int, amount:uint, success:Function, title:String, textDialog:String):void
        {
            var resultDlgBuy:Function;
            resultDlgBuy = function (_arg_1:int):void
            {
                if (((!(success == null)) && (_arg_1 == JOptionPane.YES)))
                {
                    success();
                };
            };
            if (((!(title)) || (!(textDialog))))
            {
                return;
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(title, textDialog, resultDlgBuy, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        public static function GetTextAmountCoins(_arg_1:int, _arg_2:uint):String
        {
            var _local_3:Array;
            switch (_arg_1)
            {
                case ItemData.ZENY:
                    _local_3 = ClientApplication.Localization.BUY_DIALOG_SILVERS_DECLINATION;
                    break;
                case ItemData.CASH:
                    _local_3 = ClientApplication.Localization.BUY_DIALOG_GOLDS_DECLINATION;
                    break;
            };
            if (!_local_3)
            {
                return ("");
            };
            return ((_arg_2 + " ") + HtmlText.declination(_arg_2, _local_3));
        }


    }
}//package hbm.Game.Utility

