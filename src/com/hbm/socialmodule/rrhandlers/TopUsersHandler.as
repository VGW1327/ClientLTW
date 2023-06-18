


//com.hbm.socialmodule.rrhandlers.TopUsersHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.data.UserObject;
    import com.hbm.socialmodule.data.TopListModel;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;
    import com.hbm.socialmodule.data.UserRating;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;

    public class TopUsersHandler extends AbstractRRHandler implements RRHandler 
    {

        private var _dataStack:Array;

        public function TopUsersHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
            this._dataStack = [];
        }

        public function SendRequest(_arg_1:uint, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            this._dataStack.push({
                "array":[],
                "id":_arg_1,
                "count":_arg_2,
                "offset":_arg_3,
                "friends":_arg_4
            });
            MethodName = "getTopUsersRequest";
            var _local_5:Object = {
                "ratingId":_arg_1,
                "topType":((_arg_4) ? "topFriends" : "topCommon"),
                "filter":{
                    "count":_arg_2,
                    "offset":_arg_3
                }
            };
            _local_5 = AddAuthorisationData(_local_5);
            serverHandler.SendRequest(_local_5, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_3:Array;
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:UserObject;
            var _local_7:UserObject;
            var _local_8:TopListModel;
            if (_arg_1.getTopUsersResponse == null)
            {
                DisptchError("Response header error");
                dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
                return;
            };
            var _local_2:Object = _arg_1.getTopUsersResponse;
            this._dataStack[0].count = _local_2.totalTopUsers;
            if (_local_2.result == "ok")
            {
                if (Number(_local_2.totalTopUsers) > 0)
                {
                    _local_3 = new Array();
                    _local_4 = _local_2.topUser;
                    if ((_local_4 is Array))
                    {
                        for each (_local_5 in (_local_4 as Array))
                        {
                            _local_6 = new UserObject();
                            _local_6.ServerId = _local_5.login;
                            _local_6.SetRating(new UserRating(this._dataStack[0].id, _local_5.rating));
                            this._dataStack[0].array.push(_local_6);
                            _local_3.push(_local_6.Id);
                        };
                    }
                    else
                    {
                        _local_7 = new UserObject();
                        _local_7.ServerId = _local_4.login;
                        _local_7.SetRating(new UserRating(this._dataStack[0].id, _local_4.rating));
                        this._dataStack[0].array.push(_local_7);
                        _local_3.push(_local_7.Id);
                    };
                    apiHandler.addListener(ResponseEvent.GET_PROFILES, this.OnTopNamesReceived);
                    apiHandler.GetProfiles(_local_3);
                }
                else
                {
                    _local_8 = new TopListModel();
                    cache = _local_8;
                    dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_8));
                    dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
                };
            }
            else
            {
                DisptchError(_local_2.result);
                dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
            };
        }

        private function OnTopNamesReceived(_arg_1:ResponseEvent):void
        {
            var _local_3:Array;
            var _local_4:UserObject;
            var _local_5:TopListModel;
            var _local_6:UserObject;
            apiHandler.removeListener(ResponseEvent.GET_PROFILES, this.OnTopNamesReceived);
            var _local_2:Object = _arg_1.data;
            if ((_local_2 is Array))
            {
                _local_3 = (_local_2 as Array);
                for each (_local_4 in _local_3)
                {
                    for each (_local_6 in this._dataStack[0].array)
                    {
                        if (_local_6.Id == _local_4.Id)
                        {
                            _local_6.Name = _local_4.Name;
                            _local_6.LastName = _local_4.LastName;
                            _local_6.Photo = _local_4.Photo;
                            _local_6.Link = _local_4.Link;
                        };
                    };
                };
                _local_5 = new TopListModel();
                _local_5.setList(this._dataStack[0].array, this._dataStack[0].count, this._dataStack[0].offset, this._dataStack[0].id);
                _local_5.isFriends = this._dataStack[0].friends;
                this._dataStack.shift();
                cache = _local_5;
                dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_5));
            }
            else
            {
                DisptchError("Unknown format");
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }


    }
}//package com.hbm.socialmodule.rrhandlers

