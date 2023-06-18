


//hbm.Game.Renderer.MapItemManager

package hbm.Game.Renderer
{
    import flash.utils.Dictionary;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.geom.Point;

    public class MapItemManager 
    {

        private static var _isSingletonLock:Boolean = false;
        private static var _singleton:MapItemManager = null;

        private var _mapItemList:Dictionary;

        public function MapItemManager()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use BattleLogManager.Instance."));
            };
            this._mapItemList = new Dictionary(true);
        }

        public static function get Instance():MapItemManager
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (MapItemManager)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function Clear():void
        {
            var _local_1:MapItemObject;
            if (this._mapItemList != null)
            {
                for each (_local_1 in this._mapItemList)
                {
                    RenderSystem.Instance.RemoveRenderObject(_local_1);
                };
            };
            this._mapItemList = new Dictionary(true);
        }

        public function AddMapItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int):void
        {
            var _local_9:MapItemObject = new MapItemObject(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8);
            RenderSystem.Instance.AddRenderObject(_local_9);
            this._mapItemList[_arg_1] = _local_9;
        }

        public function RemoveMapItem(_arg_1:int):void
        {
            var _local_2:MapItemObject = this._mapItemList[_arg_1];
            if (_local_2 != null)
            {
                RenderSystem.Instance.RemoveRenderObject(_local_2);
            };
            delete this._mapItemList[_arg_1];
        }

        public function GetItem(_arg_1:int):MapItemObject
        {
            return (this._mapItemList[_arg_1]);
        }

        public function GetCollidedItem(_arg_1:Point):MapItemObject
        {
            var _local_3:MapItemObject;
            var _local_2:Boolean;
            for each (_local_3 in this._mapItemList)
            {
                if (_local_3 != null)
                {
                    _local_2 = _local_3.IsCollided(_arg_1);
                    if (_local_2)
                    {
                        return (_local_3);
                    };
                };
            };
            return (null);
        }


    }
}//package hbm.Game.Renderer

