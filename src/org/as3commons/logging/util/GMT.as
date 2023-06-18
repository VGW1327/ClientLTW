


//org.as3commons.logging.util.GMT

package org.as3commons.logging.util
{
    public const GMT:String = calculateGMT();
}//package org.as3commons.logging.util

function calculateGMT():String
{
    var _local_4:String;
    var _local_1:Date = new Date();
    var _local_2:int = _local_1.timezoneOffset;
    var _local_3:int = int((_local_2 / 60));
    if (_local_2 <= 0)
    {
        (_local_4 = "+");
        (_local_2 = (_local_2 * -1));
        (_local_3 = (_local_3 * -1));
    }
    else
    {
        (_local_4 = "-");
    };
    (_local_3 = Math.floor(_local_3));
    (_local_2 = (_local_2 - (_local_3 * 60)));
    return ((("GMT" + _local_4) + ((_local_3 < 10) ? ("0" + _local_3) : _local_3)) + ((_local_2 < 10) ? ("0" + _local_2) : _local_2));
};


