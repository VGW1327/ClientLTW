


//hbm.Engine.Renderer.ColorMatrix

package hbm.Engine.Renderer
{
    public dynamic class ColorMatrix extends Array 
    {

        private static const DELTA_INDEX:Array = [0, 0.01, 0.02, 0.04, 0.05, 0.06, 0.07, 0.08, 0.1, 0.11, 0.12, 0.14, 0.15, 0.16, 0.17, 0.18, 0.2, 0.21, 0.22, 0.24, 0.25, 0.27, 0.28, 0.3, 0.32, 0.34, 0.36, 0.38, 0.4, 0.42, 0.44, 0.46, 0.48, 0.5, 0.53, 0.56, 0.59, 0.62, 0.65, 0.68, 0.71, 0.74, 0.77, 0.8, 0.83, 0.86, 0.89, 0.92, 0.95, 0.98, 1, 1.06, 1.12, 1.18, 1.24, 1.3, 1.36, 1.42, 1.48, 1.54, 1.6, 1.66, 1.72, 1.78, 1.84, 1.9, 1.96, 2, 2.12, 2.25, 2.37, 2.5, 2.62, 2.75, 2.87, 3, 3.2, 3.4, 3.6, 3.8, 4, 4.3, 4.7, 4.9, 5, 5.5, 6, 6.5, 6.8, 7, 7.3, 7.5, 7.8, 8, 8.4, 8.7, 9, 9.4, 9.6, 9.8, 10];
        private static const IDENTITY_MATRIX:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
        private static const LENGTH:Number = IDENTITY_MATRIX.length;

        public function ColorMatrix(_arg_1:Array=null)
        {
            _arg_1 = this.fixMatrix(_arg_1);
            this.copyMatrix(((_arg_1.length == LENGTH) ? _arg_1 : IDENTITY_MATRIX));
        }

        public function reset():void
        {
            var _local_1:uint;
            while (_local_1 < LENGTH)
            {
                this[_local_1] = IDENTITY_MATRIX[_local_1];
                _local_1++;
            };
        }

        public function adjustColor(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void
        {
            this.adjustHue(_arg_4);
            this.adjustContrast(_arg_2);
            this.adjustBrightness(_arg_1);
            this.adjustSaturation(_arg_3);
        }

        public function adjustBrightness(_arg_1:Number):void
        {
            _arg_1 = this.cleanValue(_arg_1, 100);
            if (((_arg_1 == 0) || (isNaN(_arg_1))))
            {
                return;
            };
            this.multiplyMatrix([1, 0, 0, 0, _arg_1, 0, 1, 0, 0, _arg_1, 0, 0, 1, 0, _arg_1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1]);
        }

        public function adjustContrast(_arg_1:Number):void
        {
            var _local_2:Number;
            _arg_1 = this.cleanValue(_arg_1, 100);
            if (((_arg_1 == 0) || (isNaN(_arg_1))))
            {
                return;
            };
            if (_arg_1 < 0)
            {
                _local_2 = (127 + ((_arg_1 / 100) * 127));
            }
            else
            {
                _local_2 = (_arg_1 % 1);
                if (_local_2 == 0)
                {
                    _local_2 = DELTA_INDEX[_arg_1];
                }
                else
                {
                    _local_2 = ((DELTA_INDEX[(_arg_1 << 0)] * (1 - _local_2)) + (DELTA_INDEX[((_arg_1 << 0) + 1)] * _local_2));
                };
                _local_2 = ((_local_2 * 127) + 127);
            };
            this.multiplyMatrix([(_local_2 / 127), 0, 0, 0, (0.5 * (127 - _local_2)), 0, (_local_2 / 127), 0, 0, (0.5 * (127 - _local_2)), 0, 0, (_local_2 / 127), 0, (0.5 * (127 - _local_2)), 0, 0, 0, 1, 0, 0, 0, 0, 0, 1]);
        }

        public function adjustSaturation(_arg_1:Number):void
        {
            _arg_1 = this.cleanValue(_arg_1, 100);
            if (((_arg_1 == 0) || (isNaN(_arg_1))))
            {
                return;
            };
            var _local_2:Number = (1 + ((_arg_1 > 0) ? ((3 * _arg_1) / 100) : (_arg_1 / 100)));
            var _local_3:Number = 0.3086;
            var _local_4:Number = 0.6094;
            var _local_5:Number = 0.082;
            this.multiplyMatrix([((_local_3 * (1 - _local_2)) + _local_2), (_local_4 * (1 - _local_2)), (_local_5 * (1 - _local_2)), 0, 0, (_local_3 * (1 - _local_2)), ((_local_4 * (1 - _local_2)) + _local_2), (_local_5 * (1 - _local_2)), 0, 0, (_local_3 * (1 - _local_2)), (_local_4 * (1 - _local_2)), ((_local_5 * (1 - _local_2)) + _local_2), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1]);
        }

        public function adjustHue(_arg_1:Number):void
        {
            _arg_1 = ((this.cleanValue(_arg_1, 180) / 180) * Math.PI);
            if (((_arg_1 == 0) || (isNaN(_arg_1))))
            {
                return;
            };
            var _local_2:Number = Math.cos(_arg_1);
            var _local_3:Number = Math.sin(_arg_1);
            var _local_4:Number = 0.213;
            var _local_5:Number = 0.715;
            var _local_6:Number = 0.072;
            this.multiplyMatrix([((_local_4 + (_local_2 * (1 - _local_4))) + (_local_3 * -(_local_4))), ((_local_5 + (_local_2 * -(_local_5))) + (_local_3 * -(_local_5))), ((_local_6 + (_local_2 * -(_local_6))) + (_local_3 * (1 - _local_6))), 0, 0, ((_local_4 + (_local_2 * -(_local_4))) + (_local_3 * 0.143)), ((_local_5 + (_local_2 * (1 - _local_5))) + (_local_3 * 0.14)), ((_local_6 + (_local_2 * -(_local_6))) + (_local_3 * -0.283)), 0, 0, ((_local_4 + (_local_2 * -(_local_4))) + (_local_3 * -(1 - _local_4))), ((_local_5 + (_local_2 * -(_local_5))) + (_local_3 * _local_5)), ((_local_6 + (_local_2 * (1 - _local_6))) + (_local_3 * _local_6)), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1]);
        }

        public function concat(_arg_1:Array):void
        {
            _arg_1 = this.fixMatrix(_arg_1);
            if (_arg_1.length != LENGTH)
            {
                return;
            };
            this.multiplyMatrix(_arg_1);
        }

        public function clone():ColorMatrix
        {
            return (new ColorMatrix(this));
        }

        public function toString():String
        {
            return (("ColorMatrix [ " + this.join(" , ")) + " ]");
        }

        public function toArray():Array
        {
            return (slice(0, 20));
        }

        protected function copyMatrix(_arg_1:Array):void
        {
            var _local_2:Number = LENGTH;
            var _local_3:uint;
            while (_local_3 < _local_2)
            {
                this[_local_3] = _arg_1[_local_3];
                _local_3++;
            };
        }

        protected function multiplyMatrix(_arg_1:Array):void
        {
            var _local_4:uint;
            var _local_5:Number;
            var _local_6:Number;
            var _local_2:Array = [];
            var _local_3:uint;
            while (_local_3 < 5)
            {
                _local_4 = 0;
                while (_local_4 < 5)
                {
                    _local_2[_local_4] = this[(_local_4 + (_local_3 * 5))];
                    _local_4++;
                };
                _local_4 = 0;
                while (_local_4 < 5)
                {
                    _local_5 = 0;
                    _local_6 = 0;
                    while (_local_6 < 5)
                    {
                        _local_5 = (_local_5 + (_arg_1[(_local_4 + (_local_6 * 5))] * _local_2[_local_6]));
                        _local_6++;
                    };
                    this[(_local_4 + (_local_3 * 5))] = _local_5;
                    _local_4++;
                };
                _local_3++;
            };
        }

        protected function cleanValue(_arg_1:Number, _arg_2:Number):Number
        {
            return (Math.min(_arg_2, Math.max(-(_arg_2), _arg_1)));
        }

        protected function fixMatrix(_arg_1:Array=null):Array
        {
            if (_arg_1 == null)
            {
                return (IDENTITY_MATRIX);
            };
            if ((_arg_1 is ColorMatrix))
            {
                _arg_1 = _arg_1.slice(0);
            };
            if (_arg_1.length < LENGTH)
            {
                _arg_1 = _arg_1.slice(0, _arg_1.length).concat(IDENTITY_MATRIX.slice(_arg_1.length, LENGTH));
            }
            else
            {
                if (_arg_1.length > LENGTH)
                {
                    _arg_1 = _arg_1.slice(0, LENGTH);
                };
            };
            return (_arg_1);
        }


    }
}//package hbm.Engine.Renderer

