


//hbm.Game.GUI.NewChat.NewPartyChatChannel

package hbm.Game.GUI.NewChat
{
    import hbm.Application.ClientApplication;
    import flash.events.Event;

    public class NewPartyChatChannel extends NewChatChannel 
    {

        public function NewPartyChatChannel(_arg_1:LeftChatBar, _arg_2:int)
        {
            super(_arg_1, _arg_2);
        }

        override protected function SendMessage(_arg_1:Event):void
        {
            var _local_3:String;
            var _local_2:String = _messageField.getText();
            if (_local_2 != "")
            {
                _local_3 = _local_2;
                ClientApplication.Instance.LocalGameClient.SendPartyChatMessage(_local_3);
                _messageField.setText("");
            };
        }

        override public function DisplayHint():void
        {
            ClearChat(null);
            AddMessage(ClientApplication.Localization.CHAT_PARTY_HELP);
        }


    }
}//package hbm.Game.GUI.NewChat

