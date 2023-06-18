


//hbm.Game.GUI.Ladders.LaddersTableCell

package hbm.Game.GUI.Ladders
{
    import org.aswing.table.TableCell;
    import org.aswing.JPanel;
    import org.aswing.CenterLayout;
    import org.aswing.ASColor;
    import org.aswing.JTable;
    import org.aswing.Component;
    import org.aswing.JLabel;

    public class LaddersTableCell implements TableCell 
    {

        private var _content:JPanel;
        private var _value:Object = null;

        public function LaddersTableCell()
        {
            this._content = new JPanel(new CenterLayout());
            this._content.setPreferredHeight(21);
        }

        public function setTableCellStatus(_arg_1:JTable, _arg_2:Boolean, _arg_3:int, _arg_4:int):void
        {
            if (_arg_2)
            {
                this._content.setOpaque(true);
                this._content.setBackground(new ASColor(6447732));
            }
            else
            {
                this._content.setOpaque(false);
            };
        }

        public function getCellValue():*
        {
            return (this._value);
        }

        public function getCellComponent():Component
        {
            return (this._content);
        }

        public function setCellValue(_arg_1:*):void
        {
            this._value = _arg_1;
            if (this._value == null)
            {
                return;
            };
            this._content.removeAll();
            this.initUICell();
        }

        private function initUICell():void
        {
            var _local_1:JLabel = new JLabel(String(this._value));
            _local_1.setForeground(new ASColor(13421796));
            _local_1.setHorizontalAlignment(JLabel.CENTER);
            this._content.append(_local_1);
        }


    }
}//package hbm.Game.GUI.Ladders

