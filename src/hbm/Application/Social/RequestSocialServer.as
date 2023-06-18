


//hbm.Application.Social.RequestSocialServer

package hbm.Application.Social
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.utils.Utilities;
    import hbm.Application.ClientApplication;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;
    import com.hbm.socialmodule.rrhandlers.abstracts.*;

    public class RequestSocialServer extends AbstractRRHandler implements RRHandler 
    {

        public function RequestSocialServer(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendNotificationRequestUser(_arg_1:String, _arg_2:uint):void
        {
            MethodName = "sendSocialNotificationRequest";
            var _local_3:Object = {
                "toLoginHash":Utilities.B64Md5(_arg_1),
                "notificationId":_arg_2,
                "socialAppId":ClientApplication.Instance.Config.GetSocialAppID
            };
            serverHandler.SendRequest(_local_3, this);
        }

        public function SendRequestUsersInfo(_arg_1:Array):void
        {
            MethodName = "getUsersForPanelRequest";
            var _local_2:Object = {"loginList":_arg_1};
            serverHandler.SendRequest(_local_2, this);
        }

        public function UpdateFriends(_arg_1:Array):void
        {
            MethodName = "refreshFriendsListRequest";
            var _local_2:Object = {"friend":_arg_1};
            _local_2 = AddAuthorisationData(_local_2);
            serverHandler.SendRequest(_local_2, this);
        }

        public function GetSocialFriends():void
        {
            MethodName = "getUserSocialFriendsRequest";
            var _local_1:Object = {};
            _local_1 = AddAuthorisationData(_local_1);
            serverHandler.SendRequest(_local_1, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:String;
            var _local_3:Object;
            var _local_4:Function;
            for (_local_2 in _arg_1)
            {
                break;
            };
            _local_3 = _arg_1[_local_2];
            if (_local_3 != null)
            {
                if (_local_3.result == "ok")
                {
                    dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_3.result));
                }
                else
                {
                    DisptchError(_local_3.result);
                };
                _local_4 = this[_local_2];
                if (_local_4 != null)
                {
                    _local_4.call(this, _local_3);
                };
            }
            else
            {
                DisptchError("Unknown header");
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }

        private function getUsersForPanelResponse(_arg_1:Object):void
        {
            var _local_2:Array;
            if (_arg_1.panelUserList)
            {
                _local_2 = [];
                if ((_arg_1.panelUserList as Array))
                {
                    _local_2 = _arg_1.panelUserList;
                }
                else
                {
                    _local_2.push(_arg_1.panelUserList);
                };
                if (_local_2.length)
                {
                    ClientApplication.Instance.LeftChatBarInstance.FriendsChannel.UpdateFriendsInfo(_local_2);
                    ClientApplication.Instance.GetSocialFriends().UpdateFriendsInfo(_local_2);
                };
            };
        }

        private function refreshFriendsListResponse(_arg_1:Object):void
        {
        }

        private function getUserSocialFriendsResponse(_arg_1:Object):void
        {
            var _local_2:Array = [];
            if (_arg_1.friendList)
            {
                if ((_arg_1.friendList as Array))
                {
                    _local_2 = _arg_1.friendList;
                }
                else
                {
                    _local_2.push(_arg_1.friendList);
                };
            };
            dispatchEvent(new ResponseEvent(ResponseEvent.GET_FRIENDS, _local_2));
        }

        private function sendSocialNotificationResponse(_arg_1:Object):void
        {
        }


    }
}//package hbm.Application.Social

