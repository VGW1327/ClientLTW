


//org.as3commons.logging.setup.target.TraceTarget

package org.as3commons.logging.setup.target
{
    import org.as3commons.logging.util.LogMessageFormatter;

    public final class TraceTarget implements IFormattingLogTarget 
    {

        public static const DEFAULT_FORMAT:String = "{time} {logLevel} - {shortName}{atPerson} - {message}";

        private var _formatter:LogMessageFormatter;

        public function TraceTarget(_arg_1:String=null)
        {
            this.format = _arg_1;
        }

        public function set format(_arg_1:String):void
        {
            this._formatter = new LogMessageFormatter(((_arg_1) || (DEFAULT_FORMAT)));
        }

        public function log(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:Number, _arg_5:*, _arg_6:Array, _arg_7:String):void
        {
            trace(this._formatter.format(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7));
        }


    }
}//package org.as3commons.logging.setup.target

