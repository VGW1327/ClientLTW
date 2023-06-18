


//org.as3commons.logging.api.Logger

package org.as3commons.logging.api
{
    import flash.utils.getTimer;
    import org.as3commons.logging.setup.ILogTarget;

    public final class Logger implements ILogger 
    {

        private static const _startTime:Number = (new Date().getTime() - getTimer());

        public var debugTarget:ILogTarget;
        public var infoTarget:ILogTarget;
        public var warnTarget:ILogTarget;
        public var errorTarget:ILogTarget;
        public var fatalTarget:ILogTarget;
        private var _name:String;
        private var _shortName:String;
        private var _person:String;

        public function Logger(_arg_1:String, _arg_2:String=null)
        {
            this._name = _arg_1;
            this._shortName = (this._shortName = this._name.substr((this._name.lastIndexOf(".") + 1)));
            this._person = _arg_2;
        }

        public function debug(_arg_1:*, _arg_2:Array=null):void
        {
            if (this.debugTarget)
            {
                this.debugTarget.log(this._name, this._shortName, 32, (_startTime + getTimer()), _arg_1, _arg_2, this._person);
            };
        }

        public function info(_arg_1:*, _arg_2:Array=null):void
        {
            if (this.infoTarget)
            {
                this.infoTarget.log(this._name, this._shortName, 16, (_startTime + getTimer()), _arg_1, _arg_2, this._person);
            };
        }

        public function warn(_arg_1:*, _arg_2:Array=null):void
        {
            if (this.warnTarget)
            {
                this.warnTarget.log(this._name, this._shortName, 8, (_startTime + getTimer()), _arg_1, _arg_2, this._person);
            };
        }

        public function error(_arg_1:*, _arg_2:Array=null):void
        {
            if (this.errorTarget)
            {
                this.errorTarget.log(this._name, this._shortName, 4, (_startTime + getTimer()), _arg_1, _arg_2, this._person);
            };
        }

        public function fatal(_arg_1:*, _arg_2:Array=null):void
        {
            if (this.fatalTarget)
            {
                this.fatalTarget.log(this._name, this._shortName, 2, (_startTime + getTimer()), _arg_1, _arg_2, this._person);
            };
        }

        public function get debugEnabled():Boolean
        {
            return (!(this.debugTarget == null));
        }

        public function get infoEnabled():Boolean
        {
            return (!(this.infoTarget == null));
        }

        public function get warnEnabled():Boolean
        {
            return (!(this.warnTarget == null));
        }

        public function get errorEnabled():Boolean
        {
            return (!(this.errorTarget == null));
        }

        public function get fatalEnabled():Boolean
        {
            return (!(this.fatalTarget == null));
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get shortName():String
        {
            return (this._shortName);
        }

        public function get person():String
        {
            return (this._person);
        }

        public function set allTargets(_arg_1:ILogTarget):void
        {
            this.debugTarget = (this.infoTarget = (this.warnTarget = (this.errorTarget = (this.fatalTarget = _arg_1))));
        }

        public function toString():String
        {
            return ((("[Logger name='" + this._name) + ((this._person) ? ("@" + this._person) : "")) + "']");
        }


    }
}//package org.as3commons.logging.api

