


//org.as3commons.logging.api.getLogger

package org.as3commons.logging.api
{
    import org.as3commons.logging.util.toLogName;

    public function getLogger(_arg_1:*, _arg_2:String=null):ILogger
    {
        if (((_arg_1) && (!(_arg_1 is String))))
        {
            _arg_1 = toLogName(_arg_1);
        };
        return (LOGGER_FACTORY.getNamedLogger(_arg_1, _arg_2));
    }

}//package org.as3commons.logging.api

