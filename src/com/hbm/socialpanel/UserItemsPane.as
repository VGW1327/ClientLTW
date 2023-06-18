


//com.hbm.socialpanel.UserItemsPane

package com.hbm.socialpanel
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import com.hbm.socialmodule.data.ItemObject;

    public class UserItemsPane extends Sprite 
    {

        private var _itemsContainer:Sprite;

        public function UserItemsPane()
        {
            this._itemsContainer = new Sprite();
            this._itemsContainer.x = 0;
            this._itemsContainer.y = 0;
            addChild(this._itemsContainer);
        }

        public function DisplayItems(_arg_1:Array):void
        {
            var _local_3:DisplayObject;
            var _local_4:UserItemIcon;
            while (this._itemsContainer.numChildren)
            {
                this._itemsContainer.removeChildAt(0);
            };
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                _local_3 = ItemObject(_arg_1[_local_2]).logo;
                _local_3.x = 5;
                _local_3.y = 5;
                _local_4 = new UserItemIcon();
                _local_4.addChild(_local_3);
                _local_4.x = ((_local_2 * 67) + 30);
                this._itemsContainer.addChild(_local_4);
                _local_2++;
            };
        }


    }
}//package com.hbm.socialpanel

