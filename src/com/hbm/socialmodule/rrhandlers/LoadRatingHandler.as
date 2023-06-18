


//com.hbm.socialmodule.rrhandlers.LoadRatingHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.data.UserRating;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;

    public class LoadRatingHandler extends AbstractRRHandler implements RRHandler 
    {

        public function LoadRatingHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest():void
        {
            MethodName = "getUserRatingsRequest";
            var _local_1:Object = AddAuthorisationData(new Object());
            serverHandler.SendRequest(_local_1, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_3:Object;
            var _local_4:Array;
            var _local_5:Object;
            var _local_6:UserRating;
            var _local_7:UserRating;
            var _local_2:Object = _arg_1.getUserRatingsResponse;
            if (_local_2)
            {
                if (_local_2.result == "ok")
                {
                    _local_3 = _local_2.userRating;
                    _local_4 = [];
                    if (_local_3 != null)
                    {
                        if ((_local_3 is Array))
                        {
                            for each (_local_5 in _local_3)
                            {
                                _local_6 = new UserRating(_local_5.id, _local_5.rating, _local_5.placeAmongAll, _local_5.placeAmongFriends);
                                _local_4.push(_local_6);
                            };
                        }
                        else
                        {
                            _local_7 = new UserRating(_local_3.id, _local_3.rating, _local_3.placeAmongAll, _local_3.placeAmongFriends);
                            _local_4.push(_local_7);
                        };
                    };
                    dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_4));
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

