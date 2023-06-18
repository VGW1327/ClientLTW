


//de.nulldesign.nd2d.display.Grid2D

package de.nulldesign.nd2d.display
{
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Vertex;
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import de.nulldesign.nd2d.geom.UV;
    import de.nulldesign.nd2d.geom.Face;
    import __AS3__.vec.*;

    public class Grid2D extends Sprite2D 
    {

        protected var stepsX:uint;
        protected var stepsY:uint;
        protected var vertexList:Vector.<Vertex>;

        public function Grid2D(_arg_1:uint, _arg_2:uint, _arg_3:Texture2D=null)
        {
            this.stepsX = _arg_1;
            this.stepsY = _arg_2;
            super(_arg_3);
            this.generateGrid();
        }

        override public function get numTris():uint
        {
            return (faceList.length);
        }

        protected function generateGrid():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_4:Vertex;
            var _local_6:UV;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:int;
            var _local_12:int;
            faceList = new Vector.<Face>();
            this.vertexList = new Vector.<Vertex>();
            var _local_3:Array = [];
            var _local_5:Array = [];
            var _local_7:Number = (2 / this.stepsX);
            var _local_8:Number = (2 / this.stepsY);
            _local_1 = 0;
            while (_local_1 <= this.stepsX)
            {
                _local_3.push([]);
                _local_5.push([]);
                _local_11 = 0;
                while (_local_11 <= this.stepsY)
                {
                    _local_9 = ((_local_1 * _local_7) - 1);
                    _local_10 = ((_local_11 * _local_8) - 1);
                    _local_4 = new Vertex(_local_9, _local_10, 0);
                    this.vertexList.push(_local_4);
                    _local_3[_local_1].push(_local_4);
                    _local_6 = new UV(((_local_9 + 1) * 0.5), ((_local_10 + 1) * 0.5));
                    _local_5[_local_1].push(_local_6);
                    _local_11++;
                };
                _local_1++;
            };
            _local_1 = 1;
            _local_2 = _local_3.length;
            while (_local_1 < _local_2)
            {
                _local_11 = 1;
                _local_12 = _local_3[_local_1].length;
                while (_local_11 < _local_12)
                {
                    faceList.push(new Face(_local_3[(_local_1 - 1)][(_local_11 - 1)], _local_3[(_local_1 - 1)][_local_11], _local_3[_local_1][_local_11], _local_5[(_local_1 - 1)][(_local_11 - 1)], _local_5[(_local_1 - 1)][_local_11], _local_5[_local_1][_local_11]));
                    faceList.push(new Face(_local_3[(_local_1 - 1)][(_local_11 - 1)], _local_3[_local_1][_local_11], _local_3[_local_1][(_local_11 - 1)], _local_5[(_local_1 - 1)][(_local_11 - 1)], _local_5[_local_1][_local_11], _local_5[_local_1][(_local_11 - 1)]));
                    _local_11++;
                };
                _local_1++;
            };
        }


    }
}//package de.nulldesign.nd2d.display

