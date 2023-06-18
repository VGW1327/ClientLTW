


//hbm.Game.GUI.Book.TMyCellRenderer

package hbm.Game.GUI.Book
{
    import org.aswing.tree.DefaultTreeCell;
    import org.aswing.Icon;
    import org.aswing.AssetIcon;
    import org.aswing.ASColor;
    import org.aswing.JTree;

    public class TMyCellRenderer extends DefaultTreeCell 
    {

        [Embed(source="Icon1.png")] public static const Icon1:Class;

        private var _ico1:Icon;

        public function TMyCellRenderer()
        {
            this._ico1 = new AssetIcon(new Icon1());
        }

        override public function setTreeCellStatus(_arg_1:JTree, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean, _arg_5:int):void
        {
            var _local_6:ItemDescription;
            super.setTreeCellStatus(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            if ((value is ItemDescription))
            {
                _local_6 = (value as ItemDescription);
                setIcon(this._ico1);
                setForeground(new ASColor(0xFFFFFF));
            }
            else
            {
                setIcon(null);
                setForeground(new ASColor(0xFFFFFF));
            };
        }


    }
}//package hbm.Game.GUI.Book

