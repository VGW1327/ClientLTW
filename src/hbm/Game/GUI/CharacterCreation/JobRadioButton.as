


//hbm.Game.GUI.CharacterCreation.JobRadioButton

package hbm.Game.GUI.CharacterCreation
{
    import org.aswing.JRadioButton;

    public class JobRadioButton extends JRadioButton 
    {

        private var _jobId:int;
        private var _canCreate:Boolean;
        private var _fraction:int;

        public function JobRadioButton(_arg_1:int=-1, _arg_2:int=-1, _arg_3:Boolean=true)
        {
            super("", null);
            this._jobId = _arg_2;
            this._canCreate = _arg_3;
            this._fraction = _arg_1;
            useHandCursor = true;
            buttonMode = true;
        }

        public function get CanCreate():Boolean
        {
            return (this._canCreate);
        }

        public function get JobId():int
        {
            return (this._jobId);
        }

        public function get Fraction():int
        {
            return (this._fraction);
        }


    }
}//package hbm.Game.GUI.CharacterCreation

