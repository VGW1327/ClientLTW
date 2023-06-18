


//hbm.Game.GUI.Tools.Flipper

package hbm.Game.GUI.Tools
{
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.BorderLayout;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.JButton;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import flash.display.Bitmap;
    import org.aswing.AssetIcon;
    import org.aswing.Icon;
    import flash.events.Event;

    public class Flipper extends JPanel 
    {

        public static const ON_BACKWARD:String = "ON_LEFT_BUTTON";
        public static const ON_FORWARD:String = "ON_RIGHT_BUTTON";

        private var _pagesLabel:JLabel;
        private var _currentPage:int;
        private var _pages:int;
        private var _graphicsLib:AdditionalDataResourceLibrary;

        public function Flipper()
        {
            super(new BorderLayout());
            this._graphicsLib = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_1:JButton = new JButton();
            _local_1.addActionListener(this.OnFlipBack);
            _local_1.setIcon(this.GetADIcon("IngameMailButtonLeftInactive"));
            _local_1.setRollOverIcon(this.GetADIcon("IngameMailButtonLeftActive"));
            _local_1.setOpaque(false);
            var _local_2:JButton = new JButton();
            _local_2.addActionListener(this.OnFlipForward);
            _local_2.setIcon(this.GetADIcon("IngameMailButtonRightInactive"));
            _local_2.setRollOverIcon(this.GetADIcon("IngameMailButtonRightActive"));
            _local_2.setOpaque(false);
            this._pagesLabel = new JLabel();
            this._pagesLabel.setVerticalAlignment(JLabel.CENTER);
            this._pagesLabel.setHorizontalAlignment(JLabel.CENTER);
            this._pagesLabel.setBorder(new EmptyBorder(null, new Insets(0, 0, 3)));
            append(_local_1, BorderLayout.WEST);
            append(this._pagesLabel, BorderLayout.CENTER);
            append(_local_2, BorderLayout.EAST);
            this._currentPage = 1;
            this._pages = 1;
        }

        private function GetADIcon(_arg_1:String):Icon
        {
            var _local_2:Bitmap = this._graphicsLib.GetBitmapAsset(("AdditionalData_Item_" + _arg_1));
            return (new AssetIcon(_local_2));
        }

        private function OnFlipBack(_arg_1:Event):void
        {
            if (this._currentPage > 1)
            {
                this._currentPage--;
                dispatchEvent(new Event(ON_BACKWARD));
            };
        }

        private function OnFlipForward(_arg_1:Event):void
        {
            if (this._currentPage < this._pages)
            {
                this._currentPage++;
                dispatchEvent(new Event(ON_FORWARD));
            };
        }

        public function SetText(_arg_1:String):void
        {
            this._pagesLabel.setText(_arg_1);
        }

        public function get CurrentPage():int
        {
            return (this._currentPage);
        }

        public function set CurrentPage(_arg_1:int):void
        {
            this._currentPage = _arg_1;
        }

        public function get Pages():int
        {
            return (this._pages);
        }

        public function set Pages(_arg_1:int):void
        {
            this._pages = _arg_1;
        }


    }
}//package hbm.Game.GUI.Tools

