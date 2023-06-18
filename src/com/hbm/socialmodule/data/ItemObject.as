


//com.hbm.socialmodule.data.ItemObject

package com.hbm.socialmodule.data
{
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import flash.display.DisplayObject;
    import com.hbm.socialmodule.connection.crypto.Base64;
    import flash.utils.ByteArray;
    import flash.display.Loader;
    import flash.events.IOErrorEvent;
    import flash.events.Event;
    import flash.system.LoaderContext;

    public class ItemObject 
    {

        public static const PRESENT:String = "present";
        public static const PERSONAL:String = "personal";
        public static const MIXED:String = "mixed";
        private static const logger:ILogger = getLogger(ItemObject);

        private var _typeId:int;
        private var _itemId:int;
        private var _name:String;
        private var _description:String;
        private var _lifetime:int;
        private var _additional:String;
        private var _price:Number;
        private var _creationDate:String;
        private var _sender:String;
        private var _pic:DisplayObject;
        private var _b64string:String;

        public function ItemObject(_arg_1:int)
        {
            this._typeId = _arg_1;
        }

        public function get typeId():int
        {
            return (this._typeId);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get description():String
        {
            return (this._description);
        }

        public function set description(_arg_1:String):void
        {
            this._description = _arg_1;
        }

        public function get lifetime():int
        {
            return (this._lifetime);
        }

        public function set lifetime(_arg_1:int):void
        {
            this._lifetime = _arg_1;
        }

        public function get additional():String
        {
            return (this._additional);
        }

        public function set additional(_arg_1:String):void
        {
            this._additional = _arg_1;
        }

        public function get price():Number
        {
            return (this._price);
        }

        public function set price(_arg_1:Number):void
        {
            this._price = _arg_1;
        }

        public function get logo():DisplayObject
        {
            return (this._pic);
        }

        public function SetLogoB64(_arg_1:String):void
        {
            this._b64string = _arg_1;
            var _local_2:ByteArray = Base64.decode(_arg_1);
            var _local_3:Loader = new Loader();
            _local_3.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.OnPicLoadError);
            _local_3.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnPicLoaded);
            var _local_4:LoaderContext = new LoaderContext();
            _local_4.checkPolicyFile = false;
            _local_3.loadBytes(_local_2, _local_4);
            this._pic = _local_3;
        }

        private function OnPicLoadError(_arg_1:IOErrorEvent):void
        {
            logger.error(_arg_1.text);
        }

        private function OnPicLoaded(_arg_1:Event):void
        {
            if (this._pic.width > 50)
            {
                this._pic.scaleX = (50 / this._pic.width);
            };
            if (this._pic.height > 50)
            {
                this._pic.scaleY = (50 / this._pic.height);
            };
        }

        public function get itemId():int
        {
            return (this._itemId);
        }

        public function set itemId(_arg_1:int):void
        {
            this._itemId = _arg_1;
        }

        public function get creationDate():String
        {
            return (this._creationDate);
        }

        public function set creationDate(_arg_1:String):void
        {
            this._creationDate = _arg_1;
        }

        public function get sender():String
        {
            return (this._sender);
        }

        public function set sender(_arg_1:String):void
        {
            this._sender = _arg_1;
        }

        public function clone():ItemObject
        {
            var _local_1:ItemObject = new ItemObject(this._typeId);
            _local_1._itemId = this._itemId;
            _local_1._additional = this._additional;
            _local_1._creationDate = this._creationDate;
            _local_1._description = this._description;
            _local_1._lifetime = this._lifetime;
            _local_1._name = this._name;
            _local_1._price = this._price;
            _local_1._sender = this._sender;
            _local_1._b64string = this._b64string;
            _local_1.SetLogoB64(this._b64string);
            return (_local_1);
        }


    }
}//package com.hbm.socialmodule.data

