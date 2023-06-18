


//com.hbm.socialmodule.rrhandlers.LoadBannersHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import flash.utils.Timer;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;
    import com.hbm.socialmodule.data.AdvBannerObject;
    import flash.events.TimerEvent;

    public class LoadBannersHandler extends AbstractRRHandler implements RRHandler 
    {

        private var _banners:Array;
        private var _bannerReloadTicker:Timer;
        private var _bannerWidth:uint;
        private var _bannerHeight:uint;
        private var _bannerCount:uint;

        public function LoadBannersHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
            this._banners = [];
        }

        public function SendRequest(_arg_1:uint, _arg_2:uint, _arg_3:uint):void
        {
            MethodName = "getBannersRequest";
            var _local_4:Object = {
                "sizeX":_arg_1,
                "sizeY":_arg_2,
                "filter":{"count":_arg_3}
            };
            serverHandler.SendRequest(_local_4, this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.getBannersResponse;
            if (_local_2)
            {
                if (_local_2.result == "ok")
                {
                    this.ParseAnswerBody(_local_2);
                    dispatchEvent(new ResponseEvent(Event.COMPLETE, this._banners));
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

        private function ParseAnswerBody(_arg_1:Object):void
        {
            var _local_3:Object;
            var _local_2:Object = _arg_1.bannerType;
            this._banners = [];
            if ((_local_2 is Array))
            {
                for each (_local_3 in (_local_2 as Array))
                {
                    this.ParseAndPushBanner(_local_3);
                };
            }
            else
            {
                this.ParseAndPushBanner(_local_2);
            };
            cache = this._banners;
        }

        private function ParseAndPushBanner(_arg_1:Object):void
        {
            var _local_2:String = this.GetDataFieldName(_arg_1.dataType);
            var _local_3:AdvBannerObject = new AdvBannerObject(_arg_1.id, _arg_1.url, _arg_1.sizeX, _arg_1.sizeY, _arg_1[_local_2], _arg_1.dataType);
            this._banners.push(_local_3);
        }

        private function GetDataFieldName(_arg_1:String):String
        {
            switch (_arg_1)
            {
                case "SWF":
                case "PNG":
                case "JPEG":
                    return ("data");
                case "URL":
                    return ("dataUrl");
                default:
                    throw (new ArgumentError("Unknown banner type"));
            };
        }

        public function SetBannerReloading(_arg_1:uint):void
        {
            this._bannerReloadTicker = new Timer((_arg_1 * 60000));
            this._bannerReloadTicker.addEventListener(TimerEvent.TIMER, this.OnBannerReloadTick);
            this._bannerReloadTicker.start();
        }

        private function OnBannerReloadTick(_arg_1:Event):void
        {
            this.SendRequest(this._bannerWidth, this._bannerHeight, this._bannerCount);
        }


    }
}//package com.hbm.socialmodule.rrhandlers

