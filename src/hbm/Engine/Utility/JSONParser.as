


//hbm.Engine.Utility.JSONParser

package hbm.Engine.Utility
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    import com.adobe.serialization.json.JSON_OLD;
    import com.adobe.serialization.json.JSONParseError;
    import hbm.Application.ClientApplication;

    public class JSONParser 
    {


        public static function GetJSON(classRef:Class):Object
        {
            var containerDef:ByteArray;
            var textBefore:String;
            var lines:Array;
            var text:String;
            var error:String;
            containerDef = new (classRef)();
            containerDef.endian = Endian.LITTLE_ENDIAN;
            containerDef.position = 0;
            var signature:int = containerDef.readUnsignedShort();
            containerDef.position = ((signature == 48111) ? 3 : 0);
            try
            {
                return (JSON_OLD.decode(containerDef.readMultiByte(containerDef.bytesAvailable, "UTF-8")));
            }
            catch(e:JSONParseError)
            {
                textBefore = e.text.substr(0, e.location);
                lines = textBefore.split(/$/);
                text = (e.text.substr(e.location, 20) + "...");
                error = (((((((("При разборе JSON " + classRef) + ' произошла ошибка:\n\n"') + e.message) + '"\n\n В строке ') + lines.length) + ', начиная с: "') + text) + '"');
                ClientApplication.Instance.ShowError(error);
            };
            return (null);
        }


    }
}//package hbm.Engine.Utility

