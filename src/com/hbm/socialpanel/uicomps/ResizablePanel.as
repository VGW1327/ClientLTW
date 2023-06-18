


//com.hbm.socialpanel.uicomps.ResizablePanel

package com.hbm.socialpanel.uicomps
{
    import tabpane.TabBody;

    public class ResizablePanel extends TabBody 
    {

        public function ResizablePanel()
        {
            this.Repack();
        }

        private function Repack():void
        {
            _topLeft.x = 0;
            _topLeft.y = 0;
            _top.x = _topLeft.getRect(this).right;
            _top.y = _topLeft.y;
            _topRight.x = _top.getRect(this).right;
            _topRight.y = _topLeft.y;
            _left.x = 0;
            _left.y = _topLeft.getRect(this).bottom;
            _center.x = _topLeft.getRect(this).right;
            _center.y = _left.y;
            _right.x = _center.getRect(this).right;
            _right.y = _center.y;
            _bottomLeft.x = 0;
            _bottomLeft.y = _left.getRect(this).bottom;
            _bottom.x = _bottomLeft.getRect(this).right;
            _bottom.y = _bottomLeft.y;
            _bottomRight.x = _bottom.getRect(this).right;
            _bottomRight.y = _bottomLeft.y;
        }

        public function SetSize(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int = ((_arg_1 - _topLeft.width) - _topRight.width);
            var _local_4:int = ((_arg_2 - _topLeft.height) - _bottomLeft.height);
            if (_local_3 <= 0)
            {
                _local_3 = 1;
            };
            if (_local_4 <= 0)
            {
                _local_4 = 1;
            };
            var _local_5:Number = (_local_3 / _center.width);
            var _local_6:Number = (_local_4 / _center.height);
            _top.scaleX = _local_5;
            _center.scaleX = _local_5;
            _bottom.scaleX = _local_5;
            _left.scaleY = _local_6;
            _center.scaleY = _local_6;
            _right.scaleY = _local_6;
            this.Repack();
        }


    }
}//package com.hbm.socialpanel.uicomps

