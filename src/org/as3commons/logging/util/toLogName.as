


//org.as3commons.logging.util.toLogName

package org.as3commons.logging.util
{
    import flash.utils.getQualifiedClassName;

    public function toLogName(_arg_1:*):String
    {
        if (_arg_1 == null)
        {
            return (_arg_1);
        };
        return (getQualifiedClassName(_arg_1).replace("::", "."));
    }

}//package org.as3commons.logging.util

