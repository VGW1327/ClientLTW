


//de.nulldesign.nd2d.display.Quad2D

package de.nulldesign.nd2d.display
{
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.materials.Quad2DColorMaterial;
    import de.nulldesign.nd2d.utils.TextureHelper;
    import de.nulldesign.nd2d.materials.BlendModePresets;
    import de.nulldesign.nd2d.geom.Vertex;
    import flash.display3D.Context3D;

    public class Quad2D extends Node2D 
    {

        protected var faceList:Vector.<Face>;
        protected var material:Quad2DColorMaterial;

        public function Quad2D(_arg_1:Number, _arg_2:Number)
        {
            _width = _arg_1;
            _height = _arg_2;
            this.faceList = TextureHelper.generateQuadFromDimensions(_arg_1, _arg_2);
            this.material = new Quad2DColorMaterial();
            this.topLeftColor = 0xFFFF0000;
            this.topRightColor = 0xFF00FF00;
            this.bottomRightColor = 0xFF0000FF;
            this.bottomLeftColor = 0xFFFFFF00;
            blendMode = BlendModePresets.NORMAL_NO_PREMULTIPLIED_ALPHA;
        }

        public function get topLeftColor():uint
        {
            return (this.faceList[0].v1.color);
        }

        public function set topLeftColor(_arg_1:uint):void
        {
            var _local_2:Vertex = this.faceList[0].v1;
            _local_2.color = _arg_1;
            this.material.modifyColorInBuffer(0, _local_2.r, _local_2.g, _local_2.b, _local_2.a);
        }

        public function get topRightColor():uint
        {
            return (this.faceList[0].v2.color);
        }

        public function set topRightColor(_arg_1:uint):void
        {
            var _local_2:Vertex;
            _local_2 = this.faceList[0].v2;
            _local_2.color = _arg_1;
            this.material.modifyColorInBuffer(1, _local_2.r, _local_2.g, _local_2.b, _local_2.a);
        }

        public function get bottomRightColor():uint
        {
            return (this.faceList[0].v3.color);
        }

        public function set bottomRightColor(_arg_1:uint):void
        {
            var _local_2:Vertex = this.faceList[0].v3;
            _local_2.color = _arg_1;
            this.material.modifyColorInBuffer(2, _local_2.r, _local_2.g, _local_2.b, _local_2.a);
        }

        public function get bottomLeftColor():uint
        {
            return (this.faceList[1].v3.color);
        }

        public function set bottomLeftColor(_arg_1:uint):void
        {
            var _local_2:Vertex = this.faceList[1].v3;
            _local_2.color = _arg_1;
            this.material.modifyColorInBuffer(3, _local_2.r, _local_2.g, _local_2.b, _local_2.a);
        }

        override public function get numTris():uint
        {
            return (this.faceList.length);
        }

        override public function get drawCalls():uint
        {
            return (this.material.drawCalls);
        }

        override public function handleDeviceLoss():void
        {
            super.handleDeviceLoss();
            if (this.material)
            {
                this.material.handleDeviceLoss();
            };
        }

        override protected function draw(_arg_1:Context3D, _arg_2:Camera2D):void
        {
            this.material.blendMode = blendMode;
            this.material.modelMatrix = worldModelMatrix;
            this.material.viewProjectionMatrix = _arg_2.getViewProjectionMatrix(false);
            this.material.render(_arg_1, this.faceList, 0, this.faceList.length);
        }

        override public function dispose():void
        {
            if (this.material)
            {
                this.material.dispose();
                this.material = null;
            };
            super.dispose();
        }


    }
}//package de.nulldesign.nd2d.display

