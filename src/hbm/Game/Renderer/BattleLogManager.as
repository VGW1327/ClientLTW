


//hbm.Game.Renderer.BattleLogManager

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Point;
    import mx.core.BitmapAsset;
    import hbm.Engine.Renderer.Camera;
    import flash.display.BitmapData;

    public class BattleLogManager extends RenderObject 
    {

        private static var _isSingletonLock:Boolean = false;
        private static var _singleton:BattleLogManager = null;

        private var _messageStorage:Array = null;

        public function BattleLogManager()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use BattleLogManager.Instance."));
            };
            Priority = 90001;
            Position = new Point(0, 0);
            this._messageStorage = new Array();
        }

        public static function get Instance():BattleLogManager
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (BattleLogManager)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function Clear():void
        {
            var _local_1:uint = this._messageStorage.length;
            var _local_2:uint;
            while (_local_2 < _local_1)
            {
                this._messageStorage[_local_2] = null;
                _local_2++;
            };
        }

        public function AddBattleMessage(_arg_1:String, _arg_2:Number, _arg_3:Point, _arg_4:Point, _arg_5:uint=0, _arg_6:uint=0, _arg_7:BitmapAsset=null):void
        {
            var _local_8:BattleLogNode = new BattleLogNode(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
            var _local_9:uint = this._messageStorage.length;
            var _local_10:uint;
            while (_local_10 < _local_9)
            {
                if (this._messageStorage[_local_10] == null)
                {
                    this._messageStorage[_local_10] = _local_8;
                    return;
                };
                _local_10++;
            };
            this._messageStorage.push(_local_8);
        }

        public function Update(_arg_1:Number):void
        {
            var _local_4:BattleLogNode;
            var _local_2:uint = this._messageStorage.length;
            var _local_3:uint;
            while (_local_3 < _local_2)
            {
                _local_4 = (this._messageStorage[_local_3] as BattleLogNode);
                if (_local_4 != null)
                {
                    _local_4.Update(_arg_1);
                };
                _local_3++;
            };
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_5:BattleLogNode;
            var _local_3:uint = this._messageStorage.length;
            var _local_4:uint;
            while (_local_4 < _local_3)
            {
                _local_5 = (this._messageStorage[_local_4] as BattleLogNode);
                if (_local_5 != null)
                {
                    if (_local_5.LifeTime <= 0)
                    {
                        this._messageStorage[_local_4] = null;
                    }
                    else
                    {
                        _local_5.Draw(_arg_1, _arg_2);
                    };
                };
                _local_4++;
            };
        }


    }
}//package hbm.Game.Renderer

