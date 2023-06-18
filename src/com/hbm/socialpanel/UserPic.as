


//com.hbm.socialpanel.UserPic

package com.hbm.socialpanel
{
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import flash.display.Loader;
    import com.hbm.socialmodule.data.UserObject;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import flash.net.navigateToURL;
    import flash.events.ErrorEvent;

    public class UserPic extends UserPane 
    {

        private static const logger:ILogger = getLogger(UserPic);

        private const PHOTO_SIZE:uint = 50;

        private var _place:uint;
        private var _userObject:Object;
        private var _loader:Loader = new Loader();
        private var _url:String = "";

        public function UserPic(_arg_1:uint, _arg_2:UserObject, _arg_3:uint)
        {
            this.Init();
            this.setUser(_arg_1, _arg_2, _arg_3);
        }

        private function Init():void
        {
            gotoAndStop("unselected");
            this.addEventListener(MouseEvent.MOUSE_OVER, this.OnMouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.OnMouseOut);
            _usernameLabel.selectable = false;
            _scoreLabel.selectable = false;
            _photo.addChild(this._loader);
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnImgLoaded);
            buttonMode = true;
            addEventListener(MouseEvent.CLICK, this.OnClick);
        }

        public function get userObject():Object
        {
            return (this._userObject);
        }

        public function setUser(_arg_1:uint, _arg_2:UserObject, _arg_3:uint):void
        {
            this._userObject = _arg_2;
            this._place = _arg_1;
            this._placeLabel.text = this._place.toString();
            this._usernameLabel.text = ((_arg_2.Name + " ") + _arg_2.LastName);
            var _local_4:int = _arg_2.GetRating(_arg_3).Rating;
            var _local_5:String = _local_4.toString();
            if (_local_4 > 0x3B9ACA00)
            {
                _local_4 = int((_local_4 / 1000000));
                _local_5 = (_local_4 + "kk");
            }
            else
            {
                if (_local_4 > 1000000)
                {
                    _local_4 = int((_local_4 / 1000));
                    _local_5 = (_local_4 + "k");
                };
            };
            this._scoreLabel.text = _local_5;
            this._url = _arg_2.Link;
            if (_arg_2.Photo)
            {
                this._loader.load(new URLRequest(_arg_2.Photo));
            }
            else
            {
                logger.warn(("Null userpic url for " + _arg_2.Id));
            };
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ErrorHandler);
        }

        private function OnImgLoaded(_arg_1:Event):void
        {
            var _local_2:Number;
            if (this._loader.height > this.PHOTO_SIZE)
            {
                _local_2 = (this.PHOTO_SIZE / this._loader.height);
                this._loader.scaleX = _local_2;
                this._loader.scaleY = _local_2;
            };
            this._loader.x = (-(this._loader.width) / 2);
            this._loader.y = (-(this._loader.height) / 2);
        }

        private function OnMouseOver(_arg_1:Event):void
        {
            this.gotoAndStop("selected");
        }

        private function OnMouseOut(_arg_1:Event):void
        {
            this.gotoAndStop("unselected");
        }

        private function OnClick(event:Event):void
        {
            try
            {
                navigateToURL(new URLRequest(this._url));
            }
            catch(e:Error)
            {
                logger.error(e.getStackTrace());
            };
        }

        private function ErrorHandler(_arg_1:ErrorEvent):void
        {
            logger.error(_arg_1.text);
        }


    }
}//package com.hbm.socialpanel

