


//hbm.Game.GUI.NewChat.NewTradeChatChannel

package hbm.Game.GUI.NewChat
{
    import hbm.Application.ClientApplication;

    public class NewTradeChatChannel extends NewChatChannel 
    {

        public function NewTradeChatChannel(_arg_1:LeftChatBar, _arg_2:int)
        {
            super(_arg_1, _arg_2);
        }

        override public function DisplayHint():void
        {
            ClearChat(null);
            AddMessage(ClientApplication.Localization.CHAT_TRADE_HELP);
        }


    }
}//package hbm.Game.GUI.NewChat

