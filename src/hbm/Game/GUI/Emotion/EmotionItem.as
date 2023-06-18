


//hbm.Game.GUI.Emotion.EmotionItem

package hbm.Game.GUI.Emotion
{
    import org.aswing.JLabelButton;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Application.ClientApplication;
    import org.aswing.event.AWEvent;

    public class EmotionItem extends JLabelButton 
    {

        private var _emotionId:int = -1;

        public function EmotionItem(_arg_1:Object)
        {
            var _local_2:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            if (_arg_1)
            {
                this._emotionId = int(_arg_1.IconId);
                setToolTipText(_arg_1.Description);
                setIcon(_local_2.GetAttachIcon("emo", _arg_1.IconId));
            };
            addActionListener(this.OnEmotionButtonPressed, 0, true);
        }

        protected function OnEmotionButtonPressed(_arg_1:AWEvent):void
        {
            if (this._emotionId > 0)
            {
                ClientApplication.Instance.LocalGameClient.SendEmotion(this._emotionId);
            };
            ClientApplication.Instance.CloseEmotionWindow();
        }


    }
}//package hbm.Game.GUI.Emotion

