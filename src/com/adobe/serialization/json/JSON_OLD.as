﻿package com.adobe.serialization.json
{
    public class JSON_OLD 
    {


        public static function encode(o:Object):String
        {
            return new JSONEncoder(o).getString();
        }

        public static function decode(s:String, strict:Boolean=true):*
        {
            return new JSONDecoder(s, strict).getValue();
        }


    }
}