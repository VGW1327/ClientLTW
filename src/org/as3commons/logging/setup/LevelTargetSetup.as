


//org.as3commons.logging.setup.LevelTargetSetup

package org.as3commons.logging.setup
{
    import org.as3commons.logging.api.ILogSetup;
    import org.as3commons.logging.api.Logger;

    public class LevelTargetSetup implements ILogSetup 
    {

        private var _level:LogSetupLevel;
        private var _target:ILogTarget;

        public function LevelTargetSetup(_arg_1:ILogTarget, _arg_2:LogSetupLevel)
        {
            this._target = _arg_1;
            this._level = _arg_2;
        }

        public function applyTo(_arg_1:Logger):void
        {
            this._level.applyTo(_arg_1, this._target);
        }


    }
}//package org.as3commons.logging.setup

