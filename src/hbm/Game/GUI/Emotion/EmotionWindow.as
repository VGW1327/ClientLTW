


//hbm.Game.GUI.Emotion.EmotionWindow

package hbm.Game.GUI.Emotion
{
    import org.aswing.JWindow;
    import org.aswing.border.EmptyBorder;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.SolidBackground;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Actors.CharacterInfo;

    public class EmotionWindow extends JWindow 
    {

        private const _width:int = 200;
        private const _height:int = 40;

        private var _fraction:int = 0;
        private var _isBaby:Boolean = false;
        protected var _emotionPanel:EmotionPanel;

        public function EmotionWindow()
        {
            setBorder(new EmptyBorder());
            this.InitUI();
            pack();
        }

        private function InitUI():void
        {
            this._emotionPanel = new EmotionPanel();
            var _local_1:JPanel = new JPanel(new BorderLayout());
            _local_1.setBorder(new LineBorder(null, new ASColor(5333109), 1));
            _local_1.setBackgroundDecorator(new SolidBackground(new ASColor(0, 0.75)));
            _local_1.setPreferredWidth((5 * 40));
            _local_1.append(this._emotionPanel, BorderLayout.CENTER);
            getContentPane().append(_local_1);
            pack();
        }

        override public function show():void
        {
            var _local_1:int = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerFraction();
            var _local_2:Boolean = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsBabyClass();
            if (((!(_local_1 == this._fraction)) || (!(_local_2 == this._isBaby))))
            {
                if (_local_1 != this._fraction)
                {
                    this._fraction = _local_1;
                };
                if (_local_2 != this._isBaby)
                {
                    this._isBaby = _local_2;
                };
                this.Revalidate();
            };
            super.show();
        }

        public function Revalidate():void
        {
            var _local_1:AdditionalDataResourceLibrary;
            var _local_7:Object;
            this._emotionPanel.Clear();
            _local_1 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_2:Object = _local_1.GetEmotions();
            var _local_3:uint = ClientApplication.Instance.LocalGameClient.PremiumType;
            var _local_4:Array = new Array();
            var _local_5:int;
            if (this._fraction == CharacterInfo.FRACTION_DARK)
            {
                if (this._isBaby)
                {
                    _local_5 = 200;
                }
                else
                {
                    _local_5 = 400;
                };
            }
            else
            {
                if (this._isBaby)
                {
                    _local_5 = 500;
                }
                else
                {
                    _local_5 = 100;
                };
            };
            var _local_6:int = (_local_5 + ((_local_3 > 0) ? ((_local_3 == 1) ? 16 : 21) : 11));
            if (_local_2)
            {
                for each (_local_7 in _local_2)
                {
                    if (((_local_7.IconId > _local_5) && (_local_7.IconId < _local_6)))
                    {
                        _local_4[_local_7.IconId] = _local_7;
                    };
                };
                for each (_local_7 in _local_4)
                {
                    this._emotionPanel.AddEmotionItem(new EmotionItem(_local_7));
                };
                this._emotionPanel.Refill();
            };
            setHeight(((_local_3 > 0) ? ((_local_3 == 1) ? (this._height * 3) : (this._height * 4)) : (this._height * 2)));
        }


    }
}//package hbm.Game.GUI.Emotion

