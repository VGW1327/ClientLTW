


//hbm.Game.GUI.Book.ItemDescription

package hbm.Game.GUI.Book
{
    import org.aswing.tree.DefaultMutableTreeNode;

    public class ItemDescription extends DefaultMutableTreeNode 
    {

        private var _nameId:int;
        private var _name:String;
        private var _type:int;
        private var _color:uint;

        public function ItemDescription(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:uint)
        {
            super({
                "name":_arg_1,
                "item":_arg_2
            });
            this._nameId = _arg_2;
            this._name = _arg_1;
            this._type = _arg_3;
            this._color = _arg_4;
        }

        override public function toString():String
        {
            var _local_1:* = getUserObject();
            return (_local_1.name);
        }

        public function get Id():int
        {
            return (this._nameId);
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function get Type():int
        {
            return (this._type);
        }

        public function get Color():uint
        {
            return (this._color);
        }


    }
}//package hbm.Game.GUI.Book

