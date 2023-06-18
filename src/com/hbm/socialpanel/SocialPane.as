


//com.hbm.socialpanel.SocialPane

package com.hbm.socialpanel
{
    import flash.display.Sprite;
    import com.hbm.socialpanel.uicomps.TabbedPane;
    import com.hbm.socialmodule.SocialModule;
    import com.hbm.socialpanel.support.SupportServiceWindow;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class SocialPane extends Sprite 
    {

        private var _tabbedPane:TabbedPane;
        private var _data:SocialModule;
        private var _buttonRow:ButtonRow;
        private var _supportServiceWindow:SupportServiceWindow;
        private var _stageWidth:int;

        public function SocialPane(_arg_1:Object, _arg_2:uint, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:Boolean=false)
        {
            this._stageWidth = _arg_5;
            this._tabbedPane = new TabbedPane();
            this._data = new SocialModule(_arg_1, _arg_3, _arg_4, _arg_2);
            this._tabbedPane.x = 0;
            this._tabbedPane.y = 0;
            this._buttonRow = new ButtonRow();
            this._buttonRow.y = 0;
            this._buttonRow._inviteButton.addEventListener(MouseEvent.CLICK, this.OnInviteClick);
            this._buttonRow._reportBugButton.addEventListener(MouseEvent.CLICK, this.OnCallSupport);
            addChild(this._tabbedPane);
            addChild(this._buttonRow);
            this._buttonRow.x = ((_arg_5 - this._buttonRow.width) - 15);
        }

        public function get tabbedPane():TabbedPane
        {
            return (this._tabbedPane);
        }

        public function get Data():SocialModule
        {
            return (this._data);
        }

        private function OnInviteClick(_arg_1:Event):void
        {
            this._data.NetworkApi.CallInviteBox();
        }

        private function OnCallSupport(_arg_1:Event):void
        {
            this.ShowSupportWindow();
        }

        public function get isSupportWindowShowing():Boolean
        {
            return ((this._supportServiceWindow) ? this._supportServiceWindow.isShowing : false);
        }

        public function ShowSupportWindow():void
        {
            if (this._supportServiceWindow == null)
            {
                this._supportServiceWindow = new SupportServiceWindow(parent, this._data.SupportData, 330, 130);
            };
            this._supportServiceWindow.OpenWindow();
        }


    }
}//package com.hbm.socialpanel

