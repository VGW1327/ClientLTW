package hbm.Game.GUI.loading 
{
	import org.aswing.JPanel;
	import hbm.progressBars;
	/**
	 * ...
	 * @author Real-Game Ltd.
	 */
	public class progresBers extends JPanel
	{
		private var _progressBars:progressBars;
		
		public function progresBers() 
		{
			this._progressBars = new progressBars();
			this.setPreferredWidth(255);
            this.setPreferredHeight(55);
			this._progressBars.width = 260;
			this._progressBars.height = 50;
			//this._progressBars.x = ((280 - this._progressBars.progressBarr.width ) * 0.5);
			//this._progressBars.progressBarr.y = this.loadingBar0.y;
			this._progressBars.progressBarr.progresss.x = -(this._progressBars.progressBarr.progresss.width);
			this._progressBars.progressBarr.ptext.text = "Загрузка: 0% (0/0 Кбайт)";
			addChild(this._progressBars);
		}
		
		public function SetProgresss(_arg_1:Number):void
		{
			this._progressBars.progressBarr.progresss.x = (-(this._progressBars.progressBarr.progresss.width) + (_arg_1 * this._progressBars.progressBarr.progresss.width));
		}
		
		public function SetText(_arg_1:int, _arg_2:int):void
		{
			
			this._progressBars.progressBarr.ptext.text = "Загрузка: "+ Math.round((_arg_1 / _arg_2) * 100) +"% (" + (_arg_1) +"/" + (_arg_2) +" Кбайт)";
		}
		
		
	}

}