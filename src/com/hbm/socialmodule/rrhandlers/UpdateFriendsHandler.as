


//com.hbm.socialmodule.rrhandlers.UpdateFriendsHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import com.hbm.socialmodule.data.SocialNetworkState;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;
    import com.hbm.socialmodule.rrhandlers.abstracts.*;

    public class UpdateFriendsHandler extends AbstractRRHandler implements RRHandler 
    {

        public function UpdateFriendsHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest():void
        {
            apiHandler.addListener(ResponseEvent.GET_FRIENDS, this.OnFriendListReceived);
            apiHandler.GetFriends();
        }

        private function OnFriendListReceived(_arg_1:ResponseEvent):void
        {
            var _local_3:Array;
            apiHandler.removeListener(ResponseEvent.GET_FRIENDS, this.OnFriendListReceived);
            var _local_2:Array = (apiHandler.Result as Array);
            _local_3 = _local_2.map(this.CreateServerId);
            MethodName = "refreshFriendsListRequest";
            var _local_4:Object = {"friend":_local_3};
            _local_4 = AddAuthorisationData(_local_4);
            serverHandler.SendRequest(_local_4, this);
        }

        private function CreateServerId(_arg_1:*, _arg_2:int, _arg_3:Array):String
        {
            var _local_4:String = SocialNetworkState.Instance.ServerIdPrefix;
            return (_local_4 + _arg_1);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.refreshFriendsListResponse;
            if (_local_2 != null)
            {
                if (_local_2.result == "ok")
                {
                    dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_2.result));
                }
                else
                {
                    DisptchError(_local_2.result);
                };
            }
            else
            {
                DisptchError("Unknown header");
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

