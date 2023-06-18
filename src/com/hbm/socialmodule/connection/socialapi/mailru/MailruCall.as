


//com.hbm.socialmodule.connection.socialapi.mailru.MailruCall

package com.hbm.socialmodule.connection.socialapi.mailru
{
    import flash.events.EventDispatcher;
    import flash.external.ExternalInterface;
    import flash.events.Event;

    public class MailruCall 
    {

        private static var callbacks:Object = {};
        private static var flashId:String;
        private static var appPrivateKey:String;
        private static var dispatcher:EventDispatcher = new EventDispatcher();
        private static var isInited:Boolean = false;


        public static function init(_arg_1:String, _arg_2:String):void
        {
            if (isInited)
            {
                throw (Error("MailruCall already initialized"));
            };
            flashId = _arg_1;
            appPrivateKey = _arg_2;
            ExternalInterface.addCallback("mailruReceive", receiver);
            exec("mailru.init", onApiLoaded, _arg_2, flashId);
            isInited = true;
        }

        public static function exec(_arg_1:String, _arg_2:Function=null, ... _args):*
        {
            var _local_4:int;
            if (_arg_2 != null)
            {
                _local_4 = int(Math.round((Math.random() * int.MAX_VALUE)));
                callbacks[_local_4] = _arg_2;
            };
            var _local_5:String = ((_arg_1.match(/(.*)\.[^.]+$/)) || ([0, "window"]))[1];
            return (ExternalInterface.call((((((((((((((((((((((((((("" + "(function(args, cbid){ ") + "if(typeof ") + _arg_1) + ' != "function"){ ') + '\tif(cbid) { document.getElementById("') + flashId) + '").mailruReceive(cbid, ') + _arg_1) + "); }") + "\telse { return ") + _arg_1) + "; }") + "}") + "if(cbid) {") + "\targs.unshift(function(value){ ") + '\t\tdocument.getElementById("') + flashId) + '").mailruReceive(cbid, value) ') + "\t}); ") + "};") + "return ") + _arg_1) + ".apply(") + _local_5) + ", args) ") + "})"), _args, _local_4));
        }

        private static function receiver(_arg_1:Number, _arg_2:Object):void
        {
            var _local_3:Function;
            if (callbacks[_arg_1])
            {
                _local_3 = callbacks[_arg_1];
                delete callbacks[_arg_1];
                _local_3.call(null, _arg_2);
            };
        }

        private static function eventReceiver(_arg_1:String, _arg_2:Object):void
        {
            dispatchEvent(new MailruCallEvent(_arg_1, _arg_2));
        }

        private static function onApiLoaded(... _args):void
        {
            ExternalInterface.addCallback("mailruEvent", eventReceiver);
            dispatchEvent(new Event(Event.COMPLETE));
        }

        public static function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:int=0, _arg_4:Boolean=false):void
        {
            dispatcher.addEventListener(_arg_1, _arg_2, false, _arg_3, _arg_4);
        }

        public static function removeEventListener(_arg_1:String, _arg_2:Function):void
        {
            dispatcher.removeEventListener(_arg_1, _arg_2);
        }

        public static function hasEventListener(_arg_1:String):Boolean
        {
            return (dispatcher.hasEventListener(_arg_1));
        }

        public static function dispatchEvent(_arg_1:Event):void
        {
            dispatcher.dispatchEvent(_arg_1);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.mailru

