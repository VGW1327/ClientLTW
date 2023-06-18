


//hbm.Engine.Utility.MemoryController

package hbm.Engine.Utility
{
    import flash.utils.setInterval;
    import flash.geom.Point;
    import flash.net.LocalConnection;
    import flash.utils.setTimeout;
    import flash.system.System;

    public class MemoryController 
    {

        private var mInterval:int;
        private var mMinMemory:int;
        private var mWarningMemoryLimit:int;
        private var mCriticalMemoryLimit:int;
        private var mForcedCleanInterval:int;
        private var mForcedIterationsNum:int;
        private var mAbortFunction:Function;
        private var mWarningFunction:Function;
        private var mIsAbleToForce:Boolean;

        public function MemoryController(_arg_1:int=1000, _arg_2:int=0x1000000, _arg_3:int=62914560, _arg_4:int=104857600, _arg_5:int=60000, _arg_6:int=1, _arg_7:Function=null, _arg_8:Function=null):void
        {
            this.mInterval = _arg_1;
            this.mMinMemory = _arg_2;
            this.mWarningMemoryLimit = _arg_3;
            this.mCriticalMemoryLimit = _arg_4;
            this.mAbortFunction = _arg_7;
            this.mWarningFunction = _arg_8;
            this.mForcedIterationsNum = _arg_6;
            this.mForcedCleanInterval = _arg_5;
            this.mIsAbleToForce = true;
            setInterval(this.checkMemoryUsage, this.mInterval);
        }

        private function doSimpleClean():void
        {
            var _local_1:Point = new Point();
            _local_1 = null;
            var _local_2:String = new String("1234567812345678");
            _local_2 = null;
            var _local_3:Array = new Array();
            var _local_4:int;
            _local_4 = 0;
            while (_local_4 < 0x0100)
            {
                _local_3.push(new String("a"));
                _local_4++;
            };
            _local_4 = 0;
            while (_local_4 < 0x0100)
            {
                delete _local_3[_local_4];
                _local_4++;
            };
            _local_3 = null;
        }

        private function MakeAbleToForce():void
        {
            this.mIsAbleToForce = true;
        }

        private function doForcedClean():void
        {
            if (!this.mIsAbleToForce)
            {
                return;
            };
            var _local_1:int;
            _local_1 = 0;
            while (_local_1 < this.mForcedIterationsNum)
            {
                try
                {
                    new LocalConnection().connect("Crio");
                    new LocalConnection().connect("Crio");
                }
                catch(e:*)
                {
                };
                _local_1++;
            };
            this.mIsAbleToForce = false;
            setTimeout(this.MakeAbleToForce, this.mForcedCleanInterval);
        }

        private function checkMemoryUsage():void
        {
            var _local_1:uint = System.totalMemory;
            var _local_2:uint = System.freeMemory;
            if (_local_2 < this.mMinMemory)
            {
                if (_local_1 > this.mWarningMemoryLimit)
                {
                    this.doForcedClean();
                    if (this.mWarningFunction != null)
                    {
                        this.mWarningFunction();
                    };
                }
                else
                {
                    if (_local_1 > this.mCriticalMemoryLimit)
                    {
                        if (this.mAbortFunction != null)
                        {
                            this.mAbortFunction();
                        };
                        this.doForcedClean();
                    };
                };
            };
        }


    }
}//package hbm.Engine.Utility

