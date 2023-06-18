


//vk.api.serialization.json.JSONDecoder

package vk.api.serialization.json
{
    public class JSONDecoder 
    {

        private var value:*;
        private var tokenizer:JSONTokenizer;
        private var token:JSONToken;

        public function JSONDecoder(_arg_1:String)
        {
            tokenizer = new JSONTokenizer(_arg_1);
            nextToken();
            value = parseValue();
        }

        private function parseObject():Object
        {
            var _local_2:String;
            var _local_1:Object = new Object();
            nextToken();
            if (token.type == JSONTokenType.RIGHT_BRACE)
            {
                return (_local_1);
            };
            while (true)
            {
                if (token.type == JSONTokenType.STRING)
                {
                    _local_2 = String(token.value);
                    nextToken();
                    if (token.type == JSONTokenType.COLON)
                    {
                        nextToken();
                        _local_1[_local_2] = parseValue();
                        nextToken();
                        if (token.type == JSONTokenType.RIGHT_BRACE)
                        {
                            return (_local_1);
                        };
                        if (token.type == JSONTokenType.COMMA)
                        {
                            nextToken();
                        }
                        else
                        {
                            tokenizer.parseError(("Expecting } or , but found " + token.value));
                        };
                    }
                    else
                    {
                        tokenizer.parseError(("Expecting : but found " + token.value));
                    };
                }
                else
                {
                    tokenizer.parseError(("Expecting string but found " + token.value));
                };
            };
            return (null); //dead code
        }

        private function parseValue():Object
        {
            switch (token.type)
            {
                case JSONTokenType.LEFT_BRACE:
                    return (parseObject());
                case JSONTokenType.LEFT_BRACKET:
                    return (parseArray());
                case JSONTokenType.STRING:
                case JSONTokenType.NUMBER:
                case JSONTokenType.TRUE:
                case JSONTokenType.FALSE:
                case JSONTokenType.NULL:
                    return (token.value);
                default:
                    tokenizer.parseError(("Unexpected " + token.value));
            };
            return (null);
        }

        private function nextToken():JSONToken
        {
            return (token = tokenizer.getNextToken());
        }

        public function getValue():*
        {
            return (value);
        }

        private function parseArray():Array
        {
            var _local_1:Array = new Array();
            nextToken();
            if (token.type == JSONTokenType.RIGHT_BRACKET)
            {
                return (_local_1);
            };
            while (true)
            {
                _local_1.push(parseValue());
                nextToken();
                if (token.type == JSONTokenType.RIGHT_BRACKET)
                {
                    return (_local_1);
                };
                if (token.type == JSONTokenType.COMMA)
                {
                    nextToken();
                }
                else
                {
                    tokenizer.parseError(("Expecting ] or , but found " + token.value));
                };
            };
            return (null); //dead code
        }


    }
}//package vk.api.serialization.json

