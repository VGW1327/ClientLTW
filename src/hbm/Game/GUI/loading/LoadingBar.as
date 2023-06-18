


//hbm.Game.GUI.loading.LoadingBar

package hbm.Game.GUI.loading
{
    import org.aswing.JPanel;
    import flash.display.Sprite;

    public class LoadingBar extends JPanel 
    {

        private var back:Sprite;
        private var bar:Sprite;

        public function LoadingBar()
        {
            this.setPreferredWidth(248);
            this.setPreferredHeight(2);
            this.bar = new Sprite();
            this.bar.graphics.beginFill(0xFFFFFF, 0.75);
            this.bar.graphics.drawRect(0, 0, 248, 2);
            this.bar.graphics.endFill();
            this.bar.x = ((280 - this.bar.width) * 0.5);
            addChild(this.bar);
            this.bar.scaleX = 0.001;
        }

        public function setProgress(_arg_1:Number):void
        {
            if (_arg_1 <= 0)
            {
                _arg_1 = 0.001;
            }
            else
            {
                if (_arg_1 > 1)
                {
                    _arg_1 = 1;
                }
            }
            this.bar.scaleX = _arg_1;
        }


    }
}//package hbm.Game.GUI.loading

