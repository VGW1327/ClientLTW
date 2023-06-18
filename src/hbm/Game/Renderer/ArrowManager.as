


//hbm.Game.Renderer.ArrowManager

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderSystem;
    import flash.geom.Point;

    public class ArrowManager 
    {

        private static var _singleton:ArrowManager = null;
        private static var _isSingletonLock:Boolean = false;

        private var _messageStorage:Array = null;

        public function ArrowManager()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use ArrowManager.Instance."));
            };
            this._messageStorage = new Array();
        }

        public static function get Instance():ArrowManager
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (ArrowManager)();
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

        public function AddArrowObject(_arg_1:Point, _arg_2:Point, _arg_3:Number=0.2, _arg_4:int=0):void
        {
            var _local_5:ArrowObject = new ArrowObject(_arg_1, _arg_2, _arg_3, _arg_4);
            RenderSystem.Instance.AddRenderObject(_local_5);
            var _local_6:uint = this._messageStorage.length;
            var _local_7:uint;
            while (_local_7 < _local_6)
            {
                if (this._messageStorage[_local_7] == null)
                {
                    this._messageStorage[_local_7] = _local_5;
                    return;
                };
                _local_7++;
            };
            this._messageStorage.push(_local_5);
        }

        public function Update(_arg_1:Number):void
        {
            var _local_4:ArrowObject;
            var _local_2:uint = this._messageStorage.length;
            var _local_3:uint;
            while (_local_3 < _local_2)
            {
                _local_4 = (this._messageStorage[_local_3] as ArrowObject);
                if (_local_4 != null)
                {
                    if (!_local_4.IsValid)
                    {
                        RenderSystem.Instance.RemoveRenderObject(_local_4);
                        this._messageStorage[_local_3] = null;
                        _local_4.Release();
                    }
                    else
                    {
                        _local_4.Update(_arg_1);
                    };
                };
                _local_3++;
            };
        }


    }
}//package hbm.Game.Renderer

