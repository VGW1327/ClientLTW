


//com.adobe.serialization.json.JSONEncoder

package com.adobe.serialization.json
{
    import flash.utils.describeType;

    public class JSONEncoder 
    {

        private var jsonString:String;

        public function JSONEncoder(value:*)
        {
            jsonString = convertToString(value);
        }

        public function getString():String
        {
            return jsonString;
        }

        private function convertToString( value:* ):String
		{
			// determine what value is and convert it based on it's type
			if ( value is String )
			{
				// escape the string so it's formatted correctly
				return escapeString( value as String );
			}
			else if ( value is Number )
			{
				// only encode numbers that finate
				return isFinite( value as Number ) ? value.toString() : "null";
			}
			else if ( value is Boolean )
			{
				// convert boolean to string easily
				return value ? "true" : "false";
			}
			else if ( value is Array )
			{
				// call the helper method to convert an array
				return arrayToString( value as Array );
			}
			else if ( value is Object && value != null )
			{
				// call the helper method to convert an object
				return objectToString( value );
			}

			return "null";
		}

        private function escapeString( str:String ):String
		{
			// create a string to store the string's jsonstring value
			var s:String = "";
			// current character in the string we're processing
			var ch:String;
			// store the length in a local variable to reduce lookups
			var len:Number = str.length;
			
			// loop over all of the characters in the string
			for ( var i:int = 0; i < len; i++ )
			{
				// examine the character to determine if we have to escape it
				ch = str.charAt( i );
				switch ( ch )
				{
					case '"': // quotation mark
						s += "\\\"";
						break;
					
					//case '/':	// solidus
					//	s += "\\/";
					//	break;
					
					case '\\': // reverse solidus
						s += "\\\\";
						break;
					
					case '\b': // bell
						s += "\\b";
						break;
					
					case '\f': // form feed
						s += "\\f";
						break;
					
					case '\n': // newline
						s += "\\n";
						break;
					
					case '\r': // carriage return
						s += "\\r";
						break;
					
					case '\t': // horizontal tab
						s += "\\t";
						break;
					
					default: // everything else
						
						// check for a control character and escape as unicode
						if ( ch < ' ' )
						{
							// get the hex digit(s) of the character (either 1 or 2 digits)
							var hexCode:String = ch.charCodeAt( 0 ).toString( 16 );
							
							// ensure that there are 4 digits by adjusting
							// the # of zeros accordingly.
							var zeroPad:String = hexCode.length == 2 ? "00" : "000";
							
							// create the unicode escape sequence with 4 hex digits
							s += "\\u" + zeroPad + hexCode;
						}
						else
						{
							
							// no need to do any special encoding, just pass-through
							s += ch;
							
						}
				} // end switch
				
			} // end for loop
			
			return "\"" + s + "\"";
		}

        private function arrayToString(a:Array):String
        {
            var s:String = "";
            for (var i:int = 0; i < a.length; i++ )
            {
                if (s.length > 0)
                {
                    s+= ","
                }
                s += convertToString( a[ i ] );
            }
            return "[" + s + "]";
        }

        private function objectToString(o:Object):String
        {
            var s:String = "";
            var classInfo:XML = describeType(o);
            if (classInfo.@name.toString() == "Object")
            {
				var value:Object;
                for (var key:String in o)
                {
                    value = o[key];
                    if (!(value is Function))
                    {
                        if (s.length > 0)
                        {
                            s += ","
                        }
                        s += escapeString( key ) + ":" + convertToString( value );
                    }
                }
            }
            else
            {
                for each (var v:XML in classInfo..*.(name() == "variable" || (name() == "accessor" && attribute("access").charAt(0) == "r")))
                {
                    if (!(v.metadata && v.metadata.(@name == "Transient").length() > 0))
                    {
                        if (s.length > 0)
                        {
                            s += ","
                        }
                        s += escapeString( v.@name.toString() ) + ":" + convertToString( o[ v.@name ] );
                    }
                }
            }
            return "{" + s + "}";
        }


    }
}