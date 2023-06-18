


//hbm.Game.GUI.Trade.TradeStatusLabel

package hbm.Game.GUI.Trade
{
    import org.aswing.JLabel;
    import org.aswing.AssetBackground;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import org.aswing.geom.IntDimension;

    public class TradeStatusLabel extends JLabel 
    {

        private var _inactiveBack:AssetBackground;
        private var _activeBack:AssetBackground;
        private var _dataLibrary:AdditionalDataResourceLibrary = (ResourceManager.Instance.Library("AdditionalData") as AdditionalDataResourceLibrary);

        public function TradeStatusLabel()
        {
            var _local_1:Bitmap = this.GetImage("ItemExchangeNotReadyLabel");
            this._inactiveBack = new AssetBackground(_local_1);
            this._activeBack = new AssetBackground(this.GetImage("ItemExchangeReadyLabel"));
            var _local_2:IntDimension = new IntDimension(_local_1.width, _local_1.height);
            setSize(_local_2);
            setPreferredSize(_local_2);
            this.SetActive(false);
        }

        private function GetImage(_arg_1:String):Bitmap
        {
            return (this._dataLibrary.GetBitmapAsset(("AdditionalData_Item_" + _arg_1)));
        }

        public function SetActive(_arg_1:Boolean):void
        {
            var _local_2:AssetBackground = ((_arg_1) ? this._activeBack : this._inactiveBack);
            setBackgroundDecorator(_local_2);
        }


    }
}//package hbm.Game.GUI.Trade

