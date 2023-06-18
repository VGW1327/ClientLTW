


//hbm.Game.Renderer.AnimatedSkillUnitObject

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Matrix;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Engine.Renderer.Camera;
    import flash.display.BitmapData;

    public class AnimatedSkillUnitObject extends RenderObject 
    {

        protected const StormgustMovie:Class = AnimatedSkillUnitObject_StormgustMovie;
        protected const SmerchMovie:Class = AnimatedSkillUnitObject_SmerchMovie;
        protected const MeteoritMovie:Class = AnimatedSkillUnitObject_MeteoritMovie;
        protected const PowerwindMovie:Class = AnimatedSkillUnitObject_PowerwindMovie;
        protected const AloneMovie:Class = AnimatedSkillUnitObject_AloneMovie;
        protected const TerraformingMovie:Class = AnimatedSkillUnitObject_TerraformingMovie;
        protected const StormcallMovie:Class = AnimatedSkillUnitObject_StormcallMovie;
        protected const HealMovie:Class = AnimatedSkillUnitObject_HealMovie;
        protected const ResurrectionMovie:Class = AnimatedSkillUnitObject_ResurrectionMovie;
        protected const ConcentrationMovie:Class = AnimatedSkillUnitObject_ConcentrationMovie;
        protected const EarthquakeMovie:Class = AnimatedSkillUnitObject_EarthquakeMovie;
        protected const PowerhamerMovie:Class = AnimatedSkillUnitObject_PowerhamerMovie;
        protected const ImprecationMovie:Class = AnimatedSkillUnitObject_ImprecationMovie;
        protected const MovePointerMovie:Class = AnimatedSkillUnitObject_MovePointerMovie;
        protected const NoMovePointerMovie:Class = AnimatedSkillUnitObject_NoMovePointerMovie;

        private var _matrix:Matrix;
        private var _effectMovie:Sprite;
        private var _statusType:int;
        private var _nullPoint:Point;
        private var _resourceName:String = null;
        private var _moveTime:Number;
        private var _lastDrawRect:Rectangle = null;

        public function AnimatedSkillUnitObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Number=0)
        {
            this._statusType = _arg_3;
            this._moveTime = _arg_5;
            Position = new Point((_arg_1 * CharacterStorage.CELL_SIZE), (RenderSystem.Instance.MainCamera.MaxHeight - (_arg_2 * CharacterStorage.CELL_SIZE)));
            Priority = Position.y;
            this._matrix = new Matrix();
            this._nullPoint = new Point(0, 0);
            this._lastDrawRect = new Rectangle();
            this._resourceName = _arg_4;
        }

        public function get StatusType():int
        {
            return (this._statusType);
        }

        public function IsCollided(_arg_1:Point):Boolean
        {
            var _local_2:Boolean;
            if (this._lastDrawRect != null)
            {
                _local_2 = this._lastDrawRect.containsPoint(_arg_1);
            };
            return (_local_2);
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_3:Number;
            var _local_4:Number;
            if (this._effectMovie == null)
            {
                switch (this._statusType)
                {
                    case 2:
                        this._effectMovie = new this.StormgustMovie();
                        break;
                    case 3:
                        this._effectMovie = new this.SmerchMovie();
                        break;
                    case 4:
                        this._effectMovie = new this.MeteoritMovie();
                        break;
                    case 5:
                        this._effectMovie = new this.PowerwindMovie();
                        break;
                    case 6:
                        this._effectMovie = new this.AloneMovie();
                        break;
                    case 7:
                        this._effectMovie = new this.TerraformingMovie();
                        break;
                    case 8:
                        this._effectMovie = new this.StormcallMovie();
                        break;
                    case 9:
                        this._effectMovie = new this.HealMovie();
                        break;
                    case 10:
                        this._effectMovie = new this.ResurrectionMovie();
                        break;
                    case 11:
                        this._effectMovie = new this.ConcentrationMovie();
                        break;
                    case 13:
                        this._effectMovie = new this.PowerhamerMovie();
                        break;
                    case 14:
                        this._effectMovie = new this.ImprecationMovie();
                        break;
                    case 20:
                        this._effectMovie = new this.MovePointerMovie();
                        break;
                    case 21:
                        this._effectMovie = new this.NoMovePointerMovie();
                        break;
                };
                if (this._effectMovie == null)
                {
                    return;
                };
                Priority = (Priority + 10);
            };
            _local_3 = _arg_1.TopLeftPoint.x;
            _local_4 = _arg_1.TopLeftPoint.y;
            var _local_5:Point = new Point((Position.x - _local_3), (Position.y - _local_4));
            this._matrix.tx = (Position.x - _local_3);
            this._matrix.ty = ((Position.y - _local_4) + 10);
            _arg_2.draw(this._effectMovie, this._matrix);
            this._lastDrawRect.x = _local_5.x;
            this._lastDrawRect.y = _local_5.y;
            this._lastDrawRect.width = this._effectMovie.width;
            this._lastDrawRect.height = this._effectMovie.height;
        }

        public function get IsValid():Boolean
        {
            return (this._moveTime > 0);
        }

        public function Update(_arg_1:Number):void
        {
            this._moveTime = (this._moveTime - _arg_1);
        }


    }
}//package hbm.Game.Renderer

