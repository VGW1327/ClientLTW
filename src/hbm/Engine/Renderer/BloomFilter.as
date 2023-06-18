


//hbm.Engine.Renderer.BloomFilter

package hbm.Engine.Renderer
{
    import flash.geom.Point;
    import flash.filters.BlurFilter;
    import flash.display.BitmapData;
    import flash.filters.ColorMatrixFilter;
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import flash.display.BlendMode;

    public class BloomFilter 
    {

        public var _mix:Number;
        public var _mul:Number;
        public var _threshold:uint;
        private var _zeroPoint:Point;
        private var _blurFilter:BlurFilter;
        private var _bufferBitmap:BitmapData;
        private var _downSampleWidth:Number;
        private var _downSampleHeight:Number;
        private var _colorMatrix:ColorMatrixFilter;
        private var _currentTransformationMatrix:Matrix;
        private var _currentTransformationInvertedMatrix:Matrix;
        private var _colorTransformPre:ColorTransform;
        private var _colorTransformPost:ColorTransform;
        private var _lastDownSampledBitmap:BitmapData;

        public function BloomFilter()
        {
            this._mix = 0.1;
            this._mul = 0.11;
            this._threshold = 100;
            this._downSampleWidth = 0.25;
            this._downSampleHeight = 0.25;
            this._zeroPoint = new Point(0, 0);
            this._blurFilter = new BlurFilter(4, 4, 3);
            this._currentTransformationMatrix = new Matrix();
            var _local_1:Array = [0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
            this._colorMatrix = new ColorMatrixFilter(_local_1);
            this._colorTransformPre = new ColorTransform();
            this._colorTransformPost = new ColorTransform();
            this._colorTransformPre.alphaMultiplier = this._mul;
            this._colorTransformPre.redMultiplier = this._mul;
            this._colorTransformPre.greenMultiplier = this._mul;
            this._colorTransformPre.blueMultiplier = this._mul;
            this._colorTransformPost.alphaMultiplier = this._mix;
            this._colorTransformPost.redMultiplier = 1;
            this._colorTransformPost.greenMultiplier = 1;
            this._colorTransformPost.blueMultiplier = 1;
            this._lastDownSampledBitmap = new BitmapData(200, 150, false, 0);
            this._currentTransformationMatrix.identity();
            this._currentTransformationMatrix.scale(this._downSampleWidth, this._downSampleHeight);
            this._currentTransformationInvertedMatrix = this._currentTransformationMatrix.clone();
            this._currentTransformationInvertedMatrix.invert();
        }

        public function Process(_arg_1:BitmapData):void
        {
            var _local_2:uint = (_arg_1.width * this._downSampleWidth);
            var _local_3:uint = (_arg_1.height * this._downSampleHeight);
            var _local_4:BitmapData = this._lastDownSampledBitmap;
            if (((!(this._lastDownSampledBitmap.width == _local_2)) || (!(this._lastDownSampledBitmap.height == _local_3))))
            {
                if (this._bufferBitmap != null)
                {
                    this._bufferBitmap.dispose();
                    this._bufferBitmap = null;
                };
                _local_4.dispose();
                this._lastDownSampledBitmap.dispose();
                this._lastDownSampledBitmap = new BitmapData(_local_2, _local_3, false, 0);
                _local_4 = this._lastDownSampledBitmap;
            };
            if (this._bufferBitmap == null)
            {
                this._bufferBitmap = new BitmapData(_local_2, _local_3, false, 0);
            };
            _local_4.draw(_arg_1, this._currentTransformationMatrix);
            var _local_5:BitmapData = _local_4.clone();
            _local_5.applyFilter(_local_4, _local_4.rect, this._zeroPoint, this._colorMatrix);
            _local_4.threshold(_local_5, _local_4.rect, this._zeroPoint, "<", this._threshold, 0, 0xFF);
            _local_4.applyFilter(_local_4, this._bufferBitmap.rect, this._zeroPoint, this._blurFilter);
            this._bufferBitmap.draw(this._bufferBitmap, null, this._colorTransformPre);
            this._bufferBitmap.draw(_local_4, null, this._colorTransformPost);
            _arg_1.draw(this._bufferBitmap, this._currentTransformationInvertedMatrix, null, BlendMode.ADD, null, true);
        }


    }
}//package hbm.Engine.Renderer

