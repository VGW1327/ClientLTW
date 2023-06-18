


//hbm.Game.Renderer.ArrowObject

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import hbm.Engine.Renderer.Camera;

    public class ArrowObject extends RenderObject 
    {

        private static const _defaultPoint:Point = new Point(0, 0);

        private var _objectBitmapData:BitmapData;
        private var _moveTime:Number;
        private var _totalMoveTime:Number;
        private var _endPosition:Point;
        private var _drawPosition:Point;
        private var _startPosition:Point;
        private var _drawRectangle:Rectangle;
        private var _currentDrawRectangle:Rectangle;

        public function ArrowObject(_arg_1:Point, _arg_2:Point, _arg_3:Number, _arg_4:int)
        {
            this._moveTime = _arg_3;
            this._totalMoveTime = _arg_3;
            this._endPosition = new Point(_arg_2.x, (RenderSystem.Instance.MainCamera.MaxHeight - _arg_2.y));
            this._startPosition = new Point(_arg_1.x, (RenderSystem.Instance.MainCamera.MaxHeight - _arg_1.y));
            Priority = _arg_1.y;
            Position = new Point(_arg_1.x, _arg_1.y);
            this._drawPosition = new Point(0, 0);
            var _local_5:int;
            var _local_6:Point = new Point((_arg_2.x - _arg_1.x), (_arg_2.y - _arg_1.y));
            _local_6.normalize(1);
            if (_local_6.y >= 0.77)
            {
                _local_5 = 0;
            }
            else
            {
                if (_local_6.y <= -0.77)
                {
                    _local_5 = 4;
                }
                else
                {
                    if (_local_6.x >= 0.77)
                    {
                        _local_5 = 2;
                    }
                    else
                    {
                        if (_local_6.x <= -0.77)
                        {
                            _local_5 = 6;
                        }
                        else
                        {
                            if (((_local_6.x > 0) && (_local_6.y > 0)))
                            {
                                _local_5 = 1;
                            }
                            else
                            {
                                if (((_local_6.x > 0) && (_local_6.y < 0)))
                                {
                                    _local_5 = 3;
                                }
                                else
                                {
                                    if (((_local_6.x < 0) && (_local_6.y > 0)))
                                    {
                                        _local_5 = 7;
                                    }
                                    else
                                    {
                                        if (((_local_6.x < 0) && (_local_6.y < 0)))
                                        {
                                            _local_5 = 5;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            var _local_7:String;
            switch (_arg_4)
            {
                case 0:
                case 46:
                case 382:
                    _local_7 = ("AdditionalData_Item_Arrow" + _local_5);
                    break;
                case 19:
                    if (_local_5 == 1)
                    {
                        _local_5 = 0;
                    }
                    else
                    {
                        if (_local_5 == 3)
                        {
                            _local_5 = 2;
                        }
                        else
                        {
                            if (_local_5 == 5)
                            {
                                _local_5 = 4;
                            }
                            else
                            {
                                if (_local_5 == 7)
                                {
                                    _local_5 = 6;
                                };
                            };
                        };
                    };
                    _local_7 = ("AdditionalData_Item_Fireball" + _local_5);
                    break;
                case 20:
                    if ((((_local_5 == 1) || (_local_5 == 4)) || (_local_5 == 5)))
                    {
                        _local_5 = 0;
                    }
                    else
                    {
                        if (((((_local_5 == 2) || (_local_5 == 3)) || (_local_5 == 6)) || (_local_5 == 7)))
                        {
                            _local_5 = 1;
                        };
                    };
                    _local_7 = ("AdditionalData_Item_Lightning" + _local_5);
                    break;
                case 14:
                    if (_local_5 == 1)
                    {
                        _local_5 = 0;
                    }
                    else
                    {
                        if (_local_5 == 3)
                        {
                            _local_5 = 2;
                        }
                        else
                        {
                            if (_local_5 == 5)
                            {
                                _local_5 = 4;
                            }
                            else
                            {
                                if (_local_5 == 7)
                                {
                                    _local_5 = 6;
                                };
                            };
                        };
                    };
                    _local_7 = ("AdditionalData_Item_Iceball" + _local_5);
                    break;
                case 86:
                    if (_local_5 == 1)
                    {
                        _local_5 = 0;
                    }
                    else
                    {
                        if (_local_5 == 3)
                        {
                            _local_5 = 2;
                        }
                        else
                        {
                            if (_local_5 == 5)
                            {
                                _local_5 = 4;
                            }
                            else
                            {
                                if (_local_5 == 7)
                                {
                                    _local_5 = 6;
                                };
                            };
                        };
                    };
                    _local_7 = ("AdditionalData_Item_Waterball" + _local_5);
                    break;
                case 1004:
                    if (_local_5 == 1)
                    {
                        _local_5 = 0;
                    }
                    else
                    {
                        if (_local_5 == 3)
                        {
                            _local_5 = 2;
                        }
                        else
                        {
                            if (_local_5 == 5)
                            {
                                _local_5 = 4;
                            }
                            else
                            {
                                if (_local_5 == 7)
                                {
                                    _local_5 = 6;
                                };
                            };
                        };
                    };
                    _local_7 = ("AdditionalData_Item_Knife" + _local_5);
                    break;
                case 251:
                    if (_local_5 == 1)
                    {
                        _local_5 = 0;
                    }
                    else
                    {
                        if (_local_5 == 3)
                        {
                            _local_5 = 2;
                        }
                        else
                        {
                            if (_local_5 == 5)
                            {
                                _local_5 = 4;
                            }
                            else
                            {
                                if (_local_5 == 7)
                                {
                                    _local_5 = 6;
                                };
                            };
                        };
                    };
                    _local_7 = ("AdditionalData_Item_shield" + _local_5);
                    break;
                case 490:
                    _local_5 = 0;
                    _local_7 = ("AdditionalData_Item_Mortira" + _local_5);
                    break;
                case 555:
                    if (_local_5 == 1)
                    {
                        _local_5 = 0;
                    }
                    else
                    {
                        if (_local_5 == 3)
                        {
                            _local_5 = 2;
                        }
                        else
                        {
                            if (_local_5 == 5)
                            {
                                _local_5 = 4;
                            }
                            else
                            {
                                if (_local_5 == 7)
                                {
                                    _local_5 = 6;
                                };
                            };
                        };
                    };
                    _local_7 = ("AdditionalData_Item_Cloud" + _local_5);
                    break;
                case 59:
                    if (_local_5 == 1)
                    {
                        _local_5 = 0;
                    }
                    else
                    {
                        if (_local_5 == 3)
                        {
                            _local_5 = 2;
                        }
                        else
                        {
                            if (_local_5 == 5)
                            {
                                _local_5 = 4;
                            }
                            else
                            {
                                if (_local_5 == 7)
                                {
                                    _local_5 = 6;
                                };
                            };
                        };
                    };
                    _local_7 = ("AdditionalData_Item_Spear" + _local_5);
                    break;
            };
            var _local_8:Bitmap = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset(_local_7);
            if (_local_8 != null)
            {
                this._objectBitmapData = _local_8.bitmapData;
                this._drawRectangle = new Rectangle(0, 0, this._objectBitmapData.width, this._objectBitmapData.height);
                this._currentDrawRectangle = new Rectangle(0, 0, this._objectBitmapData.width, this._objectBitmapData.height);
            };
        }

        public function Release():void
        {
            this._objectBitmapData = null;
        }

        public function Update(_arg_1:Number):void
        {
            this._moveTime = (this._moveTime - _arg_1);
            var _local_2:Number = (1 - (this._moveTime / this._totalMoveTime));
            Position = Point.interpolate(this._endPosition, this._startPosition, _local_2);
            Priority = Position.y;
        }

        public function get IsValid():Boolean
        {
            return (this._moveTime > 0);
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            if (this._objectBitmapData == null)
            {
                return;
            };
            var _local_3:Number = _arg_1.TopLeftPoint.x;
            var _local_4:Number = _arg_1.TopLeftPoint.y;
            this._drawPosition.x = (Position.x - _local_3);
            this._drawPosition.y = (Position.y - _local_4);
            if (((this._drawPosition.x > _arg_2.width) || ((this._drawPosition.x + this._currentDrawRectangle.width) <= 0)))
            {
                return;
            };
            if (((this._drawPosition.y > _arg_2.height) || ((this._drawPosition.y + this._currentDrawRectangle.height) <= 0)))
            {
                return;
            };
            _arg_2.copyPixels(this._objectBitmapData, this._currentDrawRectangle, this._drawPosition, this._objectBitmapData, _defaultPoint, true);
        }


    }
}//package hbm.Game.Renderer

