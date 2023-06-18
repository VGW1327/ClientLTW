


//hbm.Game.GUI.BottomBar

package hbm.Game.GUI
{
    import flash.display.Sprite;
    import hbm.Game.GUI.Tools.BlinkingIcon;
    import hbm.Game.GUI.Inventory.InventoryBar;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.events.MouseEvent;
    import hbm.Application.ClientApplication;
    import flash.display.InteractiveObject;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.Character.Character;
    import hbm.Game.Utility.HtmlText;

    public class BottomBar extends Sprite 
    {

        private var _blinkerJob:BlinkingIcon;
        private var _bottomHUD:BottomHUD;
        private var _inventoryBar:InventoryBar;
        private var _expProgress:Number = 0;
        private var _jobProgress:Number = 0;
        private var _locked:Boolean = true;
        private var _toolTips:Array;
        private var _t1:CustomToolTip;
        private var _t2:CustomToolTip;
        private var _t3:CustomToolTip;
        private var _t4:CustomToolTip;

        public function BottomBar()
        {
            x = (RenderSystem.Instance.ScreenWidth / 2);
            y = 600;
            this._bottomHUD = new BottomHUD();
            tabEnabled = false;
            tabChildren = false;
            this._inventoryBar = new InventoryBar(this._bottomHUD._hotKeysPanel.width, this._bottomHUD._hotKeysPanel.height);
            this._blinkerJob = new BlinkingIcon(this._bottomHUD._jobLevel);
            this._bottomHUD._baseLevelZone.addEventListener(MouseEvent.CLICK, this.OnExpZoneClick, false, 0, true);
            this._bottomHUD._baseLevelZone.buttonMode = true;
            this._bottomHUD._baseLevelZone.useHandCursor = true;
            this._bottomHUD._jobLevelZone.addEventListener(MouseEvent.CLICK, this.OnJobZoneClick, false, 0, true);
            this._bottomHUD._jobLevelZone.buttonMode = true;
            this._bottomHUD._jobLevelZone.useHandCursor = true;
            this._bottomHUD._locker.gotoAndStop(2);
            this._bottomHUD._locker.buttonMode = true;
            this._bottomHUD._locker.useHandCursor = true;
            this._bottomHUD._locker.addEventListener(MouseEvent.CLICK, this.OnSwitchLocker, false, 0, true);
            this._toolTips = new Array();
            this.AddToolTip(this._bottomHUD._characterButton, ClientApplication.Instance.GetPopupText(10), 210, 50);
            this.AddToolTip(this._bottomHUD._characterNotifyButton, ClientApplication.Instance.GetPopupText(10), 210, 50);
            this.AddToolTip(this._bottomHUD._skillsButton, ClientApplication.Instance.GetPopupText(12), 250, 40);
            this.AddToolTip(this._bottomHUD._skillsNotifyButton, ClientApplication.Instance.GetPopupText(12), 250, 40);
            this.AddToolTip(this._bottomHUD._guildButton, ClientApplication.Instance.GetPopupText(14), 250, 40);
            this.AddToolTip(this._bottomHUD._premiumShopButton, ClientApplication.Instance.GetPopupText(18), 250, 70);
            this.AddToolTip(this._bottomHUD._laddersButton, ClientApplication.Instance.GetPopupText(202), 250, 60);
            this.AddToolTip(this._bottomHUD._locker, ClientApplication.Instance.GetPopupText(29), 230, 40);
            this.AddToolTip(this._bottomHUD._friendsButton, ClientApplication.Instance.GetPopupText(185), 250, 40);
            this.AddToolTip(this._bottomHUD._mailButton, ClientApplication.Instance.GetPopupText(240), 200, 30);
            this.AddToolTip(this._bottomHUD._mailNotifyButton, ClientApplication.Instance.GetPopupText(240), 200, 30);
            this.AddToolTip(this._bottomHUD._auctionButton, ClientApplication.Instance.GetPopupText(241), 200, 30);
            this.AddToolTip(this._bottomHUD._silverPanel._silverButton, ClientApplication.Instance.GetPopupText(263), 250, 40);
            this.AddToolTip(this._bottomHUD._goldPanel._goldButton, ClientApplication.Instance.GetPopupText(78), 250, 40);
            this.AddToolTip(this._bottomHUD._goldPanel._goldNotifyButton, ClientApplication.Instance.GetPopupText(78), 250, 40);
            this.AddToolTip(this._bottomHUD._silverPanel._text, ClientApplication.Instance.GetPopupText(8), 200, 40);
            this.AddToolTip(this._bottomHUD._goldPanel._text, ClientApplication.Instance.GetPopupText(17), 185, 40);
            this._t1 = new CustomToolTip(this._bottomHUD._baseLevelZone, "%", 140, 40, false);
            this._t2 = new CustomToolTip(this._bottomHUD._jobLevelZone, "%", 140, 40, false);
            this._t3 = new CustomToolTip(this._bottomHUD._baseLevelBarZone, "%", 180, 25, false);
            this._t4 = new CustomToolTip(this._bottomHUD._jobLevelBarZone, "%", 160, 25, false);
            this.RevalidatePositions();
            this._bottomHUD._hotKeysPanel.addChild(this._inventoryBar);
            this._bottomHUD._baseLevelBar._progressMask.scaleX = 0;
            this._bottomHUD._jobLevelBar._progressMask.scaleX = 0;
            this._bottomHUD._characterNotifyButton.visible = false;
            this._bottomHUD._skillsNotifyButton.visible = false;
            this._bottomHUD._mailNotifyButton.visible = false;
            this._bottomHUD._goldPanel._goldNotifyButton.visible = false;
            addChild(this._bottomHUD);
        }

        public function get IsLocked():Boolean
        {
            return (this._locked);
        }

        private function OnJobZoneClick(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.ShowLevelWindow();
            ClientApplication.Instance.BottomHUD.BlinkerJobButton.Stop();
        }

        private function OnExpZoneClick(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.ShowLevelWindow();
        }

        protected function AddToolTip(_arg_1:InteractiveObject, _arg_2:String, _arg_3:int=-1, _arg_4:int=-1):void
        {
            var _local_5:CustomToolTip = new CustomToolTip(_arg_1, _arg_2, _arg_3, _arg_4);
            this._toolTips.push(_local_5);
        }

        public function BlinkCharacterStats(_arg_1:Boolean):void
        {
            this._bottomHUD._characterButton.visible = (!(_arg_1));
            this._bottomHUD._characterNotifyButton.visible = _arg_1;
        }

        public function BlinkCharacterSkills(_arg_1:Boolean):void
        {
            this._bottomHUD._skillsButton.visible = (!(_arg_1));
            this._bottomHUD._skillsNotifyButton.visible = _arg_1;
        }

        public function BlinkMail(_arg_1:Boolean):void
        {
            this._bottomHUD._mailButton.visible = (!(_arg_1));
            this._bottomHUD._mailNotifyButton.visible = _arg_1;
        }

        public function BlinkGold(_arg_1:Boolean):void
        {
            this._bottomHUD._goldPanel._goldButton.visible = (!(_arg_1));
            this._bottomHUD._goldPanel._goldNotifyButton.visible = _arg_1;
        }

        public function SetGoldLabel(_arg_1:int):void
        {
            if (_arg_1 >= 0)
            {
                this._bottomHUD._goldPanel._text.text = _arg_1.toString();
            };
        }

        public function SetMoneyLabel(_arg_1:int):void
        {
            if (_arg_1 >= 0)
            {
                this._bottomHUD._silverPanel._text.text = _arg_1.toString();
            };
        }

        public function get BlinkerJobButton():BlinkingIcon
        {
            return (this._blinkerJob);
        }

        private function OnSwitchLocker(_arg_1:MouseEvent):void
        {
            this._locked = (!(this._locked));
            this._bottomHUD._locker.gotoAndStop(((this._locked) ? 2 : 1));
        }

        public function RevalidatePositions():void
        {
            this._inventoryBar.x = 3;
            this._inventoryBar.y = 3;
        }

        public function get InventoryBarInstance():InventoryBar
        {
            return (this._inventoryBar);
        }

        public function RevalidateItems(_arg_1:String=null, _arg_2:ItemData=null):void
        {
            this._inventoryBar.RevalidateSlots(_arg_2);
            if (_arg_1 != null)
            {
                this._inventoryBar.UpdateForSkill(_arg_1);
            };
        }

        public function SetExpProgress(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_5:Number = ((_arg_3 != 0) ? (_arg_2 / _arg_3) : 1);
            var _local_6:Number = (int(((_local_5 * 100) * 1000)) / 1000);
            this._t1.updateToolTip(ClientApplication.Instance.GetPopupText(95, _arg_1, (_local_6 + "%")), 40);
            var _local_7:Boolean = Character.IsBabyClass(_local_4.jobId);
            var _local_8:* = "";
            if (_local_4.nextBaseExp != 0)
            {
                _local_8 = ((HtmlText.ConvertExp(_local_4.baseExp) + " / ") + HtmlText.ConvertExp(_local_4.nextBaseExp));
            }
            else
            {
                _local_8 = ((_local_7) ? "2.000.000.000 / 2.000.000.000" : "999.999.999 / 999.999.999");
            };
            this._t3.updateToolTip(_local_8, 25);
            if (((_local_5 == this._expProgress) || (_local_5 > 1)))
            {
                return;
            };
            this._expProgress = _local_5;
            this._bottomHUD._baseLevelBar._progressMask.scaleX = _local_5;
        }

        public function SetBaseLevel(_arg_1:int):void
        {
            this._bottomHUD._baseLevel.text = _arg_1.toString();
            ClientApplication.Instance.RevalidateLevelWindow();
        }

        public function SetJobLevel(_arg_1:int):void
        {
            this._bottomHUD._jobLevel.text = _arg_1.toString();
            ClientApplication.Instance.RevalidateLevelWindow();
        }

        public function SetJobProgress(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_5:Number = ((_arg_3 != 0) ? (_arg_2 / _arg_3) : 1);
            var _local_6:Number = (int(((_local_5 * 100) * 1000)) / 1000);
            this._t2.updateToolTip(ClientApplication.Instance.GetPopupText(94, _arg_1, (_local_6 + "%")), 40);
            var _local_7:Boolean = Character.IsBabyClass(_local_4.jobId);
            var _local_8:String = ((_local_4.nextJobExp != 0) ? ((HtmlText.ConvertExp(_local_4.jobExp) + " / ") + HtmlText.ConvertExp(_local_4.nextJobExp)) : "2.083.386 / 2.083.386");
            this._t4.updateToolTip(_local_8, 25);
            if (((_local_5 == this._jobProgress) || (_local_5 > 1)))
            {
                return;
            };
            this._jobProgress = _local_5;
            this._bottomHUD._jobLevelBar._progressMask.scaleX = _local_5;
        }

        public function get GetBottomHUD():BottomHUD
        {
            return (this._bottomHUD);
        }


    }
}//package hbm.Game.GUI

