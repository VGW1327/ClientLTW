


//hbm.Game.GUI.NewChat.FriendSlot

package hbm.Game.GUI.NewChat
{
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import hbm.Game.Utility.AsWingUtil;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.EmptyLayout;
    import flash.display.Loader;
    import org.aswing.ASFont;
    import org.aswing.JLabel;
    import flash.net.URLRequest;
    import flash.geom.Rectangle;
    import hbm.Application.ClientApplication;
    import hbm.Application.Social.SocialFriends;
    import org.aswing.event.AWEvent;

    public class FriendSlot extends JPanel 
    {

        private var _isLoaded:Boolean = false;
        private var _userid:String;
        private var _iconVisit:JPanel;

        public function FriendSlot()
        {
            super(new BorderLayout());
            this.CreateEmptySlot();
        }

        public function get IsLoaded():Boolean
        {
            return (this._isLoaded);
        }

        private function CreateEmptySlot():void
        {
            AsWingUtil.SetBorder(this);
            var _local_1:CustomButton = AsWingUtil.CreateCustomButtonFromAsset("CHW_InviteFriendButton", "CHW_InviteFriendButtonOver", "CHW_InviteFriendButton");
            _local_1.addActionListener(this.OnInviteButton);
            append(_local_1);
            this._iconVisit = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(this._iconVisit, "FF_FarmIcon");
            this._iconVisit.setLocationXY(43, 34);
            this._iconVisit.visible = false;
        }

        public function UpdateVisit(_arg_1:Boolean):void
        {
            this._iconVisit.visible = _arg_1;
        }

        public function UpdateSlot(_arg_1:String, _arg_2:String, _arg_3:String=null):void
        {
            var _local_4:JPanel;
            var _local_7:Loader;
            if (this._isLoaded)
            {
                return;
            };
            this._userid = _arg_1;
            removeAll();
            AsWingUtil.SetBorder(this, 2, 3, 2, 0);
            _local_4 = new JPanel(new EmptyLayout());
            AsWingUtil.SetSize(_local_4, 70, 94);
            var _local_5:CustomButton = AsWingUtil.CreateCustomButtonFromAsset("CHW_FriendButton", "CHW_FriendButtonOver", "CHW_FriendButton");
            _local_5.addActionListener(this.OnInviteButton);
            _local_4.append(_local_5);
            _arg_2 = ((_arg_2) ? _arg_2.replace(" ", "\n") : "???");
            var _local_6:JLabel = AsWingUtil.CreateLabel(_arg_2, 0xFFFFFF, new ASFont(getFont().getName(), 10, false));
            _local_6.setHorizontalAlignment(JLabel.CENTER);
            AsWingUtil.SetSize(_local_6, 70, 26);
            _local_6.setLocationXY(0, 62);
            _local_6.mouseChildren = (_local_6.mouseEnabled = false);
            _local_4.append(_local_6);
            if (((_arg_3) && (_arg_3.length > 0)))
            {
                _local_7 = new Loader();
                _local_7.load(new URLRequest(unescape(_arg_3)));
                _local_7.mouseChildren = (_local_7.mouseEnabled = false);
                _local_7.scrollRect = new Rectangle(0, 0, 45, 41);
                _local_7.x = 13;
                _local_7.y = 10;
                _local_4.addChild(_local_7);
            };
            _local_4.append(this._iconVisit);
            append(_local_4);
            this._isLoaded = true;
        }

        private function OnInviteButton(_arg_1:AWEvent):void
        {
            var _local_2:SocialFriends = ClientApplication.Instance.GetSocialFriends();
            if (_local_2)
            {
                if (this._isLoaded)
                {
                    _local_2.ShowVisitWindow(this._userid);
                }
                else
                {
                    _local_2.ShowInviteBox();
                };
            };
        }


    }
}//package hbm.Game.GUI.NewChat

