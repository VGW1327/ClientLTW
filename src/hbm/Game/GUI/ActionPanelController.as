


//hbm.Game.GUI.ActionPanelController

package hbm.Game.GUI
{
    import flash.utils.Timer;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.JTextArea;
    import org.aswing.JPanel;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.AssetBackground;
    import org.aswing.AttachIcon;
    import hbm.Game.Utility.HtmlText;
    import flash.events.Event;
    import caurina.transitions.Tweener;

    public class ActionPanelController 
    {

        private static const WIDTH_PANEL:int = 220;
        private static const HEIGHT_PANEL:int = 45;
        private static const SIZE_ICON:int = 57;

        private var _actionPanel:ActionPanel;
        private var _open:Boolean = false;
        private var _timerUpdate:Timer = new Timer(1000);
        private var _timerClose:Timer = new Timer(15000);
        private var _timerOpen:Timer = new Timer((60000 * 30));
        private var _timerFirstOpen:Timer = new Timer(60000);
        private var _timerStartBlink:Timer = new Timer(15000);
        private var _timerBlink:Timer = new Timer(1000, 3);
        private var _currentTime:Number = -1;
        private var _curAction:Object = null;
        private var _dataLib:AdditionalDataResourceLibrary = null;
        private var _actionToolTip1:CustomToolTip;
        private var _actionToolTip2:CustomToolTip;
        private var _text:JTextArea = null;
        private var _img:JPanel = null;

        public function ActionPanelController(_arg_1:ActionPanel)
        {
            this._actionPanel = _arg_1;
            this._actionPanel.visible = false;
            this._timerUpdate.addEventListener(TimerEvent.TIMER, this.Update, false, 0, true);
            this._timerUpdate.start();
            this._timerClose.addEventListener(TimerEvent.TIMER, this.Hide, false, 0, true);
            this._timerOpen.addEventListener(TimerEvent.TIMER, this.Show, false, 0, true);
            this._timerFirstOpen.addEventListener(TimerEvent.TIMER, this.Show, false, 0, true);
            this._timerStartBlink.addEventListener(TimerEvent.TIMER, this.StartBlink, false, 0, true);
            this._timerBlink.addEventListener(TimerEvent.TIMER, this.Blink, false, 0, true);
            this.InitGUI();
        }

        private function InitGUI():void
        {
            this._actionPanel._info.addEventListener(MouseEvent.CLICK, this.OnLink, false, 0, true);
            this._actionPanel._info.buttonMode = true;
            this._actionPanel._actionButton.addEventListener(MouseEvent.CLICK, this.OnVisibleAction, false, 0, true);
            this._img = new JPanel(new EmptyLayout());
            this._img.setLocationXY(0, 0);
            this._img.setSize(new IntDimension(SIZE_ICON, SIZE_ICON));
            this._actionPanel._info.addChild(this._img);
            this._text = new JTextArea();
            this._text.setBorder(new EmptyBorder(null, new Insets(0, 4, 0, 4)));
            this._text.setLocationXY((HEIGHT_PANEL + 5), 10);
            this._text.setSize(new IntDimension((WIDTH_PANEL - HEIGHT_PANEL), HEIGHT_PANEL));
            this._text.setOpaque(false);
            this._text.setEditable(false);
            this._text.setWordWrap(true);
            this._text.getTextField().selectable = false;
            this._text.mouseEnabled = false;
            this._text.mouseChildren = false;
            this._actionPanel._info.addChild(this._text);
            this._actionToolTip1 = new CustomToolTip(this._actionPanel._info, "-", 250, 10, false);
            this._actionToolTip2 = new CustomToolTip(this._actionPanel._actionButton, "-", 250, 10, false);
            this.StateClose();
        }

        private function Update(_arg_1:TimerEvent):void
        {
            if (!ClientApplication.Instance.timeOnServerInited)
            {
                return;
            };
            if (this._currentTime < 0)
            {
                this._currentTime = (ClientApplication.Instance.timeOnServer * 1000);
            };
            this._dataLib = ((this._dataLib) || (ResourceManager.Instance.Library("AdditionalData") as AdditionalDataResourceLibrary));
            if (!this._dataLib)
            {
                return;
            };
            this._currentTime = (this._currentTime + 1000);
            var _local_2:Object = this._dataLib.GetActionData(this._currentTime);
            this._actionPanel.visible = (!(_local_2 == null));
            if (this._actionPanel.visible)
            {
                if (this._curAction != _local_2)
                {
                    ClientApplication.Instance.ReOpenCashShop();
                    this._curAction = _local_2;
                    this._img.setBackgroundDecorator(new AssetBackground(((this._dataLib.GetBitmapAsset(("AdditionalData_Item_" + this._curAction["Icon"]))) || (new AttachIcon("Items_Item_00000").getAsset()))));
                    this._timerFirstOpen.start();
                    if (this._actionToolTip1)
                    {
                        this._actionToolTip1.updateToolTip(_local_2["Description"], _local_2["Height"]);
                    };
                    if (this._actionToolTip2)
                    {
                        this._actionToolTip2.updateToolTip(_local_2["Description"], _local_2["Height"]);
                    };
                };
                this.SetText(((_local_2["Title"] + "<br>") + this.GetTime()));
            }
            else
            {
                if (this._curAction)
                {
                    ClientApplication.Instance.ReOpenCashShop();
                    this._curAction = null;
                };
            };
        }

        public function SetText(_arg_1:String):void
        {
            this._text.setHtmlText(_arg_1);
            this._text.filters = [HtmlText.shadow];
        }

        private function OnLink(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.SetAnaloguesId("23213");
            ClientApplication.Instance.OpenCashShop();
            this.Hide();
        }

        private function OnVisibleAction(_arg_1:Event):void
        {
            if (this._open)
            {
                this.Hide();
            }
            else
            {
                this.Show();
            };
        }

        private function StartBlink(_arg_1:TimerEvent):void
        {
            this.Blink();
            this._timerBlink.reset();
            this._timerBlink.start();
        }

        private function Blink(_arg_1:TimerEvent=null):void
        {
        }

        private function StopBlink():void
        {
            this._timerBlink.stop();
            this._timerStartBlink.stop();
        }

        private function Show(_arg_1:TimerEvent=null):void
        {
            if (((!(_arg_1 == null)) && (ClientApplication.Instance.IsLoading())))
            {
                this._curAction = null;
                return;
            };
            if (Tweener.isTweening(this._actionPanel))
            {
                return;
            };
            this._img.visible = true;
            Tweener.addTween(this._actionPanel, {
                "y":HEIGHT_PANEL,
                "time":1,
                "transition":"easeInOutCubic",
                "onComplete":this.StateOpen
            });
            this._timerClose.start();
            this._timerOpen.stop();
            this.StopBlink();
        }

        private function Hide(_arg_1:TimerEvent=null):void
        {
            Tweener.removeTweens(this._actionPanel);
            Tweener.addTween(this._actionPanel, {
                "y":0,
                "time":1,
                "transition":"easeInOutCubic",
                "onComplete":this.StateClose
            });
            this._timerOpen.start();
            this._timerFirstOpen.stop();
            this._timerClose.stop();
        }

        private function StateOpen():void
        {
            this._open = true;
        }

        private function StateClose():void
        {
            this._open = false;
            this._img.visible = false;
            this._timerStartBlink.start();
        }

        private function GetTime():String
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            if (!this._curAction)
            {
                return ("");
            };
            var _local_1:int = int(((this._curAction["End"] - this._currentTime) / 1000));
            var _local_2:* = "";
            if (_local_1 >= 86400)
            {
                _local_3 = int(int((_local_1 / 86400)));
                _local_2 = (_local_2 + (((_local_3 + " ") + ClientApplication.Localization.TIME_DAYS) + " "));
                _local_1 = (_local_1 - (_local_3 * 86400));
            };
            if (_local_1 >= 3600)
            {
                _local_4 = int(int((_local_1 / 3600)));
                _local_2 = (_local_2 + (((_local_4 + " ") + ClientApplication.Localization.TIME_HOURS) + " "));
                _local_1 = (_local_1 - (_local_4 * 3600));
            };
            if (_local_1 >= 60)
            {
                _local_5 = int(int((_local_1 / 60)));
                _local_2 = (_local_2 + (((_local_5 + " ") + ClientApplication.Localization.TIME_MINUTES) + " "));
                _local_1 = (_local_1 - (_local_5 * 60));
            };
            if (_local_1 >= 0)
            {
                _local_2 = (_local_2 + (((_local_1 + " ") + ClientApplication.Localization.TIME_SECONDS) + " "));
            };
            return ((ClientApplication.Localization.ACTION_MESSAGE + " ") + _local_2);
        }


    }
}//package hbm.Game.GUI

