package com.adobe.serialization.json
{
    public class JSONDecoder 
    {

        private var strict:Boolean;
        private var value:*;
        private var tokenizer:JSONTokenizer;
        private var token:JSONToken;

        public function JSONDecoder(s:String, strict:Boolean)
        {
            this.strict = strict;
            tokenizer = new JSONTokenizer(s, strict);
            nextToken();
            value = parseValue();
            if (strict && nextToken() != null)
            {
                tokenizer.parseError("Unexpected characters left in input stream");
            }
        }

        public function getValue():*
        {
            return value;
        }

        private function nextToken():JSONToken
        {
            return token = tokenizer.getNextToken();
        }
		
		private final function nextValidToken():JSONToken
		{
			token = tokenizer.getNextToken();
			checkValidToken();
			
			return token;
		}
		
		private function checkValidToken():void
		{
			if (token == null)
			{
				tokenizer.parseError("Unexpected end of input");
			}
		}

        private function parseArray():Array
        {
            var a:Array = new Array();
			
            nextValidToken();
			
            if (token.type == JSONTokenType.RIGHT_BRACKET)
            {
                return a;
            }
            else if (!strict && token.type == JSONTokenType.COMMA)
            {
                nextValidToken();
                if (token.type == JSONTokenType.RIGHT_BRACKET)
                {
                    return a;
                }
				else
				{
					tokenizer.parseError("Leading commas are not supported.  Expecting ']' but found " + token.value);
				}
            }
			
            while (true)
            {
                a.push(parseValue());
                nextValidToken();
                if (token.type == JSONTokenType.RIGHT_BRACKET)
                {
                    return a;
                }
                else if (token.type == JSONTokenType.COMMA)
                {
                    nextToken();
                    if (!strict)
                    {
						checkValidToken();
						
                        if (token.type == JSONTokenType.RIGHT_BRACKET)
                        {
                            return a;
                        }
                    }
                }
                else
                {
                    tokenizer.parseError("Expecting ] or , but found " + token.value);
                }
            }
            return null; //dead code
        }

        private function parseObject():Object
        {
            var o:Object = new Object();
			var key:String;
            nextValidToken();
            if (token.type == JSONTokenType.RIGHT_BRACE)
            {
                return o;
            }
            else if (!strict && token.type == JSONTokenType.COMMA)
            {
                nextValidToken();
                if (token.type == JSONTokenType.RIGHT_BRACE)
                {
                    return o;
                }
				else
				{
					tokenizer.parseError("Leading commas are not supported.  Expecting '}' but found " + token.value);
				}
			}
            while (true)
            {
                if (token.type == JSONTokenType.STRING)
                {
                    key = String(token.value);
                    nextValidToken();
                    if (token.type == JSONTokenType.COLON)
                    {
                        nextToken();
                        o[key] = parseValue();
                        nextValidToken();
                        if (this.token.type == JSONTokenType.RIGHT_BRACE)
                        {
                            return o;
                        }
                        else if (this.token.type == JSONTokenType.COMMA)
                        {
                            nextToken();
                            if (!strict)
                            {
								checkValidToken();
                                if (token.type == JSONTokenType.RIGHT_BRACE)
                                {
                                    return o;
                                }
                            }
                        }
                        else
                        {
                            tokenizer.parseError("Expecting } or , but found " + token.value);
                        }
                    }
                    else
                    {
                        tokenizer.parseError("Expecting : but found " + token.value);
                    }
                }
                else
                {
                    tokenizer.parseError("Expecting string but found " + token.value);
                }
            }
            return null; //dead code
        }

        private function parseValue():Object
        {
            checkValidToken();
            switch (token.type)
            {
                case JSONTokenType.LEFT_BRACE:
                    return parseObject();
                case JSONTokenType.LEFT_BRACKET:
                    return parseArray();
                case JSONTokenType.STRING:
                case JSONTokenType.NUMBER:
                case JSONTokenType.TRUE:
                case JSONTokenType.FALSE:
                case JSONTokenType.NULL:
                    return token.value;
                case JSONTokenType.NAN:
                    if (!strict)
                    {
                        return token.value;
                    }
					else
					{
						tokenizer.parseError("Unexpected " + token.value);
					}
                default:
                    tokenizer.parseError("Unexpected " + token.value);
            }
            return null;
        }
    }
}