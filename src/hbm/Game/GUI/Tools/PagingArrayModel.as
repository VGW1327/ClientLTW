


//hbm.Game.GUI.Tools.PagingArrayModel

package hbm.Game.GUI.Tools
{
    public class PagingArrayModel 
    {

        private var _dataArray:Array;
        private var _pageLength:int;
        private var _currentPageIndex:int;
        private var _currentPageArray:Array;
        private var _totalPages:int;
        private var _ringed:Boolean;

        public function PagingArrayModel(_arg_1:Array, _arg_2:int, _arg_3:Boolean=false)
        {
            this._dataArray = _arg_1;
            this._pageLength = _arg_2;
            this._ringed = _arg_3;
            this._totalPages = this.CalcTotalPages();
            this.MoveToPage(0);
        }

        private function CalcTotalPages():int
        {
            var _local_1:int = this._dataArray.length;
            var _local_2:int = int((_local_1 / this._pageLength));
            var _local_3:int = (_local_1 % this._pageLength);
            if (_local_3 > 0)
            {
                _local_2++;
            };
            return (_local_2);
        }

        public function MoveToPage(_arg_1:int):void
        {
            if (((_arg_1 >= 0) && (_arg_1 < this._totalPages)))
            {
                this._currentPageIndex = _arg_1;
                this._currentPageArray = this.GetArrayOfCurrentPage();
            };
        }

        private function GetArrayOfCurrentPage():Array
        {
            var _local_1:Array = new Array();
            var _local_2:int = (this._pageLength * this._currentPageIndex);
            var _local_3:int = (_local_2 + this._pageLength);
            var _local_4:int = _local_2;
            while (_local_4 < _local_3)
            {
                if (_local_4 < this._dataArray.length)
                {
                    _local_1.push(this._dataArray[_local_4]);
                }
                else
                {
                    break;
                };
                _local_4++;
            };
            return (_local_1);
        }

        public function MoveForward():void
        {
            if (this.HasNext())
            {
                this.IncreasePageIndex();
                this._currentPageArray = this.GetArrayOfCurrentPage();
            };
        }

        private function IncreasePageIndex():void
        {
            if (this._currentPageIndex < (this._totalPages - 1))
            {
                this._currentPageIndex++;
            }
            else
            {
                this._currentPageIndex = 0;
            };
        }

        public function MoveBackward():void
        {
            if (this.HasPrevious())
            {
                this.DecreasePageIndex();
                this._currentPageArray = this.GetArrayOfCurrentPage();
            };
        }

        private function DecreasePageIndex():void
        {
            if (this._currentPageIndex > 0)
            {
                this._currentPageIndex--;
            }
            else
            {
                this._currentPageIndex = (this._totalPages - 1);
            };
        }

        public function HasNext():Boolean
        {
            if (this._ringed)
            {
                return (true);
            };
            return (this._currentPageIndex < this._totalPages);
        }

        public function HasPrevious():Boolean
        {
            if (this._ringed)
            {
                return (true);
            };
            return (this._currentPageIndex > 0);
        }

        public function get TotalPages():int
        {
            return (this._totalPages);
        }

        public function get CurrentPageIndex():int
        {
            return (this._currentPageIndex);
        }

        public function get CurrentPage():Array
        {
            return (this._currentPageArray);
        }


    }
}//package hbm.Game.GUI.Tools

