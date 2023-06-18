


//hbm.Game.GUI.Tools.CustomTableModel

package hbm.Game.GUI.Tools
{
    import org.aswing.table.DefaultTableModel;

    public class CustomTableModel extends DefaultTableModel 
    {


        override public function isCellEditable(_arg_1:int, _arg_2:int):Boolean
        {
            return (false);
        }


    }
}//package hbm.Game.GUI.Tools

