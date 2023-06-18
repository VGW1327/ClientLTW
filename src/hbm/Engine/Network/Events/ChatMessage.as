


//hbm.Engine.Network.Events.ChatMessage

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Game.Utility.HtmlText;

    public class ChatMessage extends Event 
    {

        public static const ON_PUBLIC_MESSAGE:String = "ON_PUBLIC_MESSAGE";
        public static const ON_GUILD_MESSAGE:String = "ON_GUILD_MESSAGE";
        public static const ON_PRIVATE_MESSAGE:String = "ON_PRIVATE_MESSAGE";
        public static const ON_PARTY_MESSAGE:String = "ON_PARTY_MESSAGE";
        public static const ON_BROADCAST_MESSAGE:String = "ON_BROADCAST_MESSAGE";
        public static const ON_PLAYER_MUTED:String = "ON_PLAYER_MUTED";
        public static const ON_EMOTION:String = "ON_EMOTION";
        public static const ON_PET_EMOTION:String = "ON_PET_EMOTION";

        private var _message:String;
        private var _author:String;
        public var colorR:int;
        public var colorG:int;
        public var colorB:int;
        public var SenderLevel:int;
        public var CharacterId:uint;
        public var PremiumType:int;
        public var Race:int;
        public var IsGM:Boolean;

        public function ChatMessage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:uint, _arg_5:String, _arg_6:String, _arg_7:String=null, _arg_8:int=0xFF, _arg_9:int=0xFF, _arg_10:int=0xFF)
        {
            super(_arg_5);
            this.colorR = _arg_8;
            this.colorG = _arg_9;
            this.colorB = _arg_10;
            this._author = _arg_7;
            this._message = _arg_6;
            this.CharacterId = _arg_4;
            this.SenderLevel = _arg_2;
            this.PremiumType = _arg_3;
            this.Race = _arg_1;
            this.IsGM = false;
        }

        public function get Message():String
        {
            return (this._message);
        }

        public function set Message(_arg_1:String):void
        {
            this._message = _arg_1;
        }

        public function get Author():String
        {
            return (this._author);
        }

        public function get Color():String
        {
            var _local_1:uint = HtmlText.combineRGB(this.colorR, this.colorG, this.colorB);
            return ("#" + HtmlText.getNumberAsHexString(_local_1, 6, false));
        }


    }
}//package hbm.Engine.Network.Events

