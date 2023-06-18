


//com.hbm.socialmodule.data.AdvBannerObject

package com.hbm.socialmodule.data
{
    import flash.display.Sprite;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import flash.display.Loader;
    import flash.events.MouseEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.Event;
    import flash.errors.IOError;
    import flash.errors.IllegalOperationError;
    import flash.display.DisplayObject;
    import com.hbm.socialmodule.connection.crypto.Base64;
    import flash.utils.ByteArray;
    import flash.net.URLRequest;
    import com.hbm.socialmodule.connection.BannerEvent;
    import flash.net.navigateToURL;

    public class AdvBannerObject extends Sprite 
    {

        private static const _logger:ILogger = getLogger(AdvBannerObject);

        private var _Id:uint;
        private var _TargetUrl:String;
        private var _width:uint;
        private var _height:uint;
        private var _Data:String;
        private var _DataType:String;
        private var _loader:Loader;

        public function AdvBannerObject(id:uint, targetUrl:String, width:uint, height:uint, data:String, dataType:String)
        {
            super();
            this._Id = id;
            this._TargetUrl = targetUrl;
            this._width = width;
            this._height = height;
            this._Data = data;
            this._DataType = dataType;
            buttonMode = true;
            addEventListener(MouseEvent.CLICK, this.OnClick);
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.OnIOError);
            this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.OnSecurityError);
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnComplete);
            try
            {
                this.LoadImage();
            }
            catch(e:SecurityError)
            {
                FireBannerLoadingError(e.message);
            }
            catch(e:IOError)
            {
                FireBannerLoadingError(e.message);
            }
            catch(e:IllegalOperationError)
            {
                FireBannerLoadingError(e.message);
            };
            addChild((this._loader as DisplayObject));
        }

        private function LoadImage():void
        {
            switch (this._DataType)
            {
                case "SWF":
                case "PNG":
                case "JPEG":
                    this.LoadFromBytes();
                    return;
                case "URL":
                    this.LoadFromUrl();
                    return;
                default:
                    throw (new ArgumentError("Unknown banner type"));
            };
        }

        private function LoadFromBytes():void
        {
            var _local_1:ByteArray = Base64.decode(this._Data);
            this._loader.loadBytes(_local_1);
        }

        private function LoadFromUrl():void
        {
            var _local_1:URLRequest = new URLRequest(this._Data);
            this._loader.load(_local_1);
        }

        private function OnIOError(_arg_1:IOErrorEvent):void
        {
            this.FireBannerLoadingError(_arg_1.toString());
        }

        private function OnSecurityError(_arg_1:SecurityErrorEvent):void
        {
            this.FireBannerLoadingError(_arg_1.toString());
        }

        private function FireBannerLoadingError(_arg_1:String):void
        {
            dispatchEvent(new BannerEvent(BannerEvent.ON_BANNER_ERROR, this));
            _logger.error(_arg_1);
        }

        private function OnComplete(_arg_1:Event):void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }

        public function get Id():uint
        {
            return (this._Id);
        }

        public function get TargetUrl():String
        {
            return (this._TargetUrl);
        }

        public function get BannerWidth():uint
        {
            return (this._width);
        }

        public function get BannerHeight():uint
        {
            return (this._height);
        }

        public function get Data():String
        {
            return (this._Data);
        }

        public function get DataType():String
        {
            return (this._DataType);
        }

        public function get DecodedData():DisplayObject
        {
            return (this._loader);
        }

        private function OnClick(event:Event):void
        {
            try
            {
                navigateToURL(new URLRequest(this._TargetUrl));
            }
            catch(e:Error)
            {
                _logger.error(e.message);
            };
            dispatchEvent(new BannerEvent(BannerEvent.CLICK, this));
        }

        public function Clone():AdvBannerObject
        {
            return (new AdvBannerObject(this.Id, this.TargetUrl, width, height, this.Data, this.DataType));
        }


    }
}//package com.hbm.socialmodule.data

