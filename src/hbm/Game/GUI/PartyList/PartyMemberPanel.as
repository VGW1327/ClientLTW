


//hbm.Game.GUI.PartyList.PartyMemberPanel

package hbm.Game.GUI.PartyList
{
    import org.aswing.JPanel;
    import org.aswing.EmptyLayout;
    import flash.filters.ColorMatrixFilter;

    public class PartyMemberPanel extends JPanel 
    {

        public static const ELEMENT_HEIGHT:int = 18;

        private var _maxHP:int = 0;
        private var _currentHP:int = 0;
        private var _online:Boolean = false;
        private var _container:PartyHealthBar;

        public function PartyMemberPanel()
        {
            super(new EmptyLayout());
            this._container = new PartyHealthBar();
            addChild(this._container);
        }

        public function SetIfLeader(_arg_1:Boolean):void
        {
            this._container._leader.visible = _arg_1;
        }

        public function SetOnline(_arg_1:Boolean):void
        {
            this._online = _arg_1;
        }

        public function SetCurrentHP(_arg_1:int):void
        {
            this._currentHP = _arg_1;
            this.UpdateHP();
        }

        public function SetMaxHP(_arg_1:int):void
        {
            this._maxHP = _arg_1;
            this.UpdateHP();
        }

        private function UpdateHP():void
        {
            if (this._maxHP != 0)
            {
                this.Enable(true);
                this._container._progressMask.scaleX = (this._currentHP / this._maxHP);
            }
            else
            {
                this.ClearHP();
            };
        }

        public function ClearHP():void
        {
            this.Enable(false);
            this._container._progressMask.scaleX = 1;
        }

        public function SetName(_arg_1:String):void
        {
            this._container._text.text = _arg_1;
        }

        private function Enable(_arg_1:Boolean):void
        {
            var _local_2:Array;
            var _local_3:ColorMatrixFilter;
            if (_arg_1)
            {
                this._container.filters = [];
                this._container.alpha = 1;
            }
            else
            {
                _local_2 = [0.2, 0.2, 0.2, 0, 0, 0.2, 0.2, 0.2, 0, 0, 0.2, 0.2, 0.2, 0, 0, 0, 0, 0, 1, 0];
                _local_3 = new ColorMatrixFilter(_local_2);
                this._container.filters = [_local_3];
                this._container.alpha = ((this._online) ? 1 : 0.6);
            };
        }

        public function SetLevel(_arg_1:int):void
        {
        }


    }
}//package hbm.Game.GUI.PartyList

