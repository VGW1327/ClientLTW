


//hbm.Game.GUI.Tutorial.TutorialPanel

package hbm.Game.GUI.Tutorial
{
    import org.aswing.JWindow;
    import org.aswing.geom.IntDimension;
    import mx.core.BitmapAsset;
    import flash.display.Bitmap;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.JButton;
    import org.aswing.event.AWEvent;

    public class TutorialPanel extends JWindow 
    {

        public static const LOAD_TUTORIAL:uint = 1;
        public static const ACCEPT_TUTORIAL:uint = 2;
        public static const CLEAR_TUTORIAL:uint = 3;

        private const WIDTH:uint = 62;
        private const HEIGHT:uint = 62;

        private var _tutorialId:uint;
        private var _flag:uint;
        private var _tutorialData:Object;
        private var _tutorialWindow:TutorialWindow;

        public function TutorialPanel()
        {
            getContentPane().setBackgroundDecorator(null);
            getContentPane().setFocusable(false);
            setSize(new IntDimension(this.WIDTH, this.HEIGHT));
            setMaximumSize(new IntDimension(this.WIDTH, this.HEIGHT));
            setFocusable(false);
            setLocationXY(0, 220);
        }

        public function SetTutorial(_arg_1:uint, _arg_2:uint):void
        {
            var _local_4:BitmapAsset;
            var _local_5:Bitmap;
            this._tutorialId = _arg_1;
            this._flag = _arg_2;
            getContentPane().removeAll();
            if (this._flag == CLEAR_TUTORIAL)
            {
                if (((this._tutorialWindow) && (this._tutorialWindow.isShowing())))
                {
                    this._tutorialWindow.CloseWithAnimation();
                };
                dispose();
                return;
            };
            var _local_3:AdditionalDataResourceLibrary = (ResourceManager.Instance.Library("AdditionalData") as AdditionalDataResourceLibrary);
            this._tutorialData = _local_3.GetTutorialData(_arg_1);
            if (!this._tutorialData)
            {
                return;
            };
            _local_4 = ((_local_3.GetBitmapAsset(("AdditionalData_Item_" + this._tutorialData.Icon))) || (_local_3.GetBitmapAsset("AdditionalData_Item_NoMovePointer")));
            _local_5 = new Bitmap(_local_4.bitmapData);
            _local_5.filters = [new GlowFilter(0xFF00, 0.9, 8, 8, 2, BitmapFilterQuality.LOW)];
            var _local_6:JButton = AsWingUtil.CreateButton(_local_4, _local_5);
            _local_6.setToolTipText(this._tutorialData.Title);
            _local_6.addActionListener(this.OnOpenWindow);
            getContentPane().append(_local_6);
            show();
        }

        public function ShowTutorialWindow(_arg_1:uint, _arg_2:uint=1):void
        {
            this._tutorialWindow = ((this._tutorialWindow) || (new TutorialWindow()));
            if (((this._tutorialWindow.isShowing()) && (!(_arg_2 == TutorialPanel.LOAD_TUTORIAL))))
            {
                this._tutorialWindow.CloseWithAnimation();
            }
            else
            {
                this._tutorialWindow.ShowTutorial(_arg_1, _arg_2);
            };
        }

        public function GetTutorialWindow():TutorialWindow
        {
            return (this._tutorialWindow);
        }

        private function OnOpenWindow(_arg_1:AWEvent):void
        {
            this.ShowTutorialWindow(this._tutorialId, this._flag);
        }


    }
}//package hbm.Game.GUI.Tutorial

