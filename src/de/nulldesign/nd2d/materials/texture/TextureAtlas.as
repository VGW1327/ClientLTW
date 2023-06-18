


//de.nulldesign.nd2d.materials.texture.TextureAtlas

package de.nulldesign.nd2d.materials.texture
{
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import de.nulldesign.nd2d.materials.*;
    import __AS3__.vec.*;

    public class TextureAtlas extends ASpriteSheetBase 
    {

        protected var xmlData:XML;

        public function TextureAtlas(_arg_1:Number, _arg_2:Number, _arg_3:XML, _arg_4:uint, _arg_5:Boolean=false)
        {
            this.fps = _arg_4;
            this.xmlData = _arg_3;
            this.spritesPackedWithoutSpace = _arg_5;
            this._sheetWidth = _arg_1;
            this._sheetHeight = _arg_2;
            if (this.xmlData)
            {
                this.parseCocos2DXML(this.xmlData);
            };
        }

        public function getIndexForFrame(_arg_1:String):uint
        {
            return (frameNameToIndex[_arg_1]);
        }

        override public function addAnimation(_arg_1:String, _arg_2:Array, _arg_3:Boolean):void
        {
            var _local_4:Array;
            var _local_5:int;
            if ((_arg_2[_local_5] is String))
            {
                _local_4 = [];
                _local_5 = 0;
                while (_local_5 < _arg_2.length)
                {
                    _local_4.push(frameNameToIndex[_arg_2[_local_5]]);
                    _local_5++;
                };
                animationMap[_arg_1] = new SpriteSheetAnimation(_local_4, _arg_3);
            }
            else
            {
                animationMap[_arg_1] = new SpriteSheetAnimation(_arg_2, _arg_3);
            };
        }

        protected function parseCocos2DXML(_arg_1:XML):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:Array;
            var _local_8:XMLList;
            var _local_9:XMLList;
            var _local_10:uint;
            var _local_11:String;
            var _local_12:XMLList;
            var _local_13:XMLList;
            var _local_14:uint;
            var _local_5:XMLList = _arg_1.dict.key;
            var _local_6:XMLList = _arg_1.dict.dict;
            var _local_7:uint;
            while (_local_7 < _local_5.length())
            {
                switch (_local_5[_local_7].toString())
                {
                    case "frames":
                        _local_8 = _local_6[_local_7].key;
                        _local_9 = _local_6[_local_7].dict;
                        _local_10 = 0;
                        while (_local_10 < _local_8.length())
                        {
                            _local_11 = _local_8[_local_10];
                            _local_12 = _local_9[_local_10].key;
                            _local_13 = _local_9[_local_10].*;
                            frameNameToIndex[_local_11] = _local_10;
                            _local_14 = 0;
                            while (_local_14 < _local_12.length())
                            {
                                _local_2 = _local_13[(_local_12[_local_14].childIndex() + 1)].name();
                                _local_3 = _local_13[(_local_12[_local_14].childIndex() + 1)];
                                switch (_local_12[_local_14].toString())
                                {
                                    case "frame":
                                        if (_local_2 == "string")
                                        {
                                            _local_4 = _local_3.split(/[^0-9-]+/);
                                            frames.push(new Rectangle(_local_4[1], _local_4[2], _local_4[3], _local_4[4]));
                                        }
                                        else
                                        {
                                            throw (new Error("Error parsing descriptor format"));
                                        };
                                        break;
                                    case "offset":
                                        if (_local_2 == "string")
                                        {
                                            _local_4 = _local_3.split(/[^0-9-]+/);
                                            offsets.push(new Point(_local_4[1], -(_local_4[2])));
                                        }
                                        else
                                        {
                                            throw (new Error("Error parsing descriptor format"));
                                        };
                                        break;
                                    case "sourceSize":
                                        if (_local_2 == "string")
                                        {
                                            _local_4 = _local_3.split(/[^0-9-]+/);
                                            sourceSizes.push(new Point(_local_4[1], _local_4[2]));
                                        }
                                        else
                                        {
                                            throw (new Error("Error parsing descriptor format"));
                                        };
                                        break;
                                    case "sourceColorRect":
                                        if (_local_2 == "string")
                                        {
                                            _local_4 = _local_3.split(/[^0-9-]+/);
                                            sourceColorRects.push(new Rectangle(_local_4[1], _local_4[2], _local_4[3], _local_4[4]));
                                        }
                                        else
                                        {
                                            throw (new Error("Error parsing descriptor format"));
                                        };
                                        break;
                                    case "rotated":
                                        if (_local_2 != "false")
                                        {
                                            throw (new Error("Rotated elements not supported (yet)"));
                                        };
                                        break;
                                };
                                _local_14++;
                            };
                            _local_10++;
                        };
                        break;
                };
                _local_7++;
            };
            if (frames.length == 0)
            {
                throw (new Error("Error parsing descriptor format"));
            };
            uvRects = new Vector.<Rectangle>(frames.length, true);
            frame = 0;
        }

        override public function clone():ASpriteSheetBase
        {
            var _local_2:String;
            var _local_3:SpriteSheetAnimation;
            var _local_1:TextureAtlas = new TextureAtlas(_sheetWidth, _sheetHeight, this.xmlData, fps, spritesPackedWithoutSpace);
            for (_local_2 in animationMap)
            {
                _local_3 = animationMap[_local_2];
                _local_1.addAnimation(_local_2, _local_3.frames.concat(), _local_3.loop);
            };
            _local_1.frame = frame;
            return (_local_1);
        }


    }
}//package de.nulldesign.nd2d.materials.texture

