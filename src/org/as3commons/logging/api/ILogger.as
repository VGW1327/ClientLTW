


//org.as3commons.logging.api.ILogger

package org.as3commons.logging.api
{
    public interface ILogger 
    {

        function get name():String;
        function get shortName():String;
        function get person():String;
        function debug(_arg_1:*, _arg_2:Array=null):void;
        function info(_arg_1:*, _arg_2:Array=null):void;
        function warn(_arg_1:*, _arg_2:Array=null):void;
        function error(_arg_1:*, _arg_2:Array=null):void;
        function fatal(_arg_1:*, _arg_2:Array=null):void;
        function get debugEnabled():Boolean;
        function get infoEnabled():Boolean;
        function get warnEnabled():Boolean;
        function get errorEnabled():Boolean;
        function get fatalEnabled():Boolean;

    }
}//package org.as3commons.logging.api

