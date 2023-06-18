


//hbm.Engine.Utility.Vector2D

package hbm.Engine.Utility
{
    import flash.geom.Point;

    public class Vector2D 
    {

        public static var ZERO:Vector2D = new Vector2D(0, 0);

        public var x:Number;
        public var y:Number;

        public function Vector2D(_arg_1:Number=0, _arg_2:Number=0)
        {
            this.x = _arg_1;
            this.y = _arg_2;
        }

        public static function polar(_arg_1:Number, _arg_2:Number):Vector2D
        {
            return (new Vector2D((_arg_1 * Math.cos(_arg_2)), (_arg_1 * Math.sin(_arg_2))));
        }

        public static function interpolate(_arg_1:Vector2D, _arg_2:Vector2D, _arg_3:Number):Vector2D
        {
            return (_arg_2.add(_arg_1.subtract(_arg_2).multiply(_arg_3)));
        }

        public static function distance(_arg_1:Vector2D, _arg_2:Vector2D):Number
        {
            return (Math.sqrt(Vector2D.distanceSquared(_arg_1, _arg_2)));
        }

        public static function distanceSquared(_arg_1:Vector2D, _arg_2:Vector2D):Number
        {
            var _local_3:Number = (_arg_1.x - _arg_2.x);
            var _local_4:Number = (_arg_1.y - _arg_2.y);
            return ((_local_3 * _local_3) + (_local_4 * _local_4));
        }

        public static function fromPoint(_arg_1:Point):Vector2D
        {
            return (new Vector2D(_arg_1.x, _arg_1.y));
        }


        public function toPoint():Point
        {
            return (new Point(this.x, this.y));
        }

        public function reset(_arg_1:Number=0, _arg_2:Number=0):Vector2D
        {
            this.x = _arg_1;
            this.y = _arg_2;
            return (this);
        }

        public function assign(_arg_1:Vector2D):Vector2D
        {
            this.x = _arg_1.x;
            this.y = _arg_1.y;
            return (this);
        }

        public function clone():Vector2D
        {
            return (new Vector2D(this.x, this.y));
        }

        public function add(_arg_1:Vector2D):Vector2D
        {
            return (new Vector2D((this.x + _arg_1.x), (this.y + _arg_1.y)));
        }

        public function subtract(_arg_1:Vector2D):Vector2D
        {
            return (new Vector2D((this.x - _arg_1.x), (this.y - _arg_1.y)));
        }

        public function multiply(_arg_1:Number):Vector2D
        {
            return (new Vector2D((this.x * _arg_1), (this.y * _arg_1)));
        }

        public function divide(_arg_1:Number):Vector2D
        {
            return (this.multiply((1 / _arg_1)));
        }

        public function incrementBy(_arg_1:Vector2D):Vector2D
        {
            this.x = (this.x + _arg_1.x);
            this.y = (this.y + _arg_1.y);
            return (this);
        }

        public function decrementBy(_arg_1:Vector2D):Vector2D
        {
            this.x = (this.x - _arg_1.x);
            this.y = (this.y - _arg_1.y);
            return (this);
        }

        public function scaleBy(_arg_1:Number):Vector2D
        {
            this.x = (this.x * _arg_1);
            this.y = (this.y * _arg_1);
            return (this);
        }

        public function divideBy(_arg_1:Number):Vector2D
        {
            this.x = (this.x / _arg_1);
            this.y = (this.y / _arg_1);
            return (this);
        }

        public function rotate(_arg_1:Number):Vector2D
        {
            var _local_2:Number = (Math.atan2(this.y, this.x) + _arg_1);
            return (Vector2D.polar(this.length, _local_2));
        }

        public function rotateBy(_arg_1:Number):Vector2D
        {
            var _local_2:Number = (Math.atan2(this.y, this.x) + _arg_1);
            var _local_3:Number = this.length;
            this.x = (_local_3 * Math.cos(_local_2));
            this.y = (_local_3 * Math.sin(_local_2));
            return (this);
        }

        public function equals(_arg_1:Vector2D):Boolean
        {
            return ((this.x == _arg_1.x) && (this.y == _arg_1.y));
        }

        public function nearEquals(_arg_1:Vector2D, _arg_2:Number):Boolean
        {
            return (this.subtract(_arg_1).lengthSquared <= (_arg_2 * _arg_2));
        }

        public function dotProduct(_arg_1:Vector2D):Number
        {
            return ((this.x * _arg_1.x) + (this.y * _arg_1.y));
        }

        public function get length():Number
        {
            return (Math.sqrt(this.lengthSquared));
        }

        public function get lengthSquared():Number
        {
            return ((this.x * this.x) + (this.y * this.y));
        }

        public function negative():Vector2D
        {
            return (new Vector2D(-(this.x), -(this.y)));
        }

        public function perpendicular():Vector2D
        {
            return (new Vector2D(-(this.y), this.x));
        }

        public function normalize():Vector2D
        {
            var _local_1:Number = this.length;
            if (_local_1 != 0)
            {
                _local_1 = (1 / _local_1);
                this.x = (this.x * _local_1);
                this.y = (this.y * _local_1);
            }
            else
            {
                this.x = undefined;
                this.y = undefined;
            };
            return (this);
        }

        public function unit():Vector2D
        {
            return (this.clone().normalize());
        }

        public function toString():String
        {
            return (((("(x=" + this.x) + ", y=") + this.y) + ")");
        }


    }
}//package hbm.Engine.Utility

