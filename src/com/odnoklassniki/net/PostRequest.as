


//com.odnoklassniki.net.PostRequest

package com.odnoklassniki.net
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class PostRequest 
    {

        public var boundary:String = "-----";
        protected var postData:ByteArray;

        public function PostRequest()
        {
            this.createPostData();
        }

        public function createPostData():void
        {
            this.postData = new ByteArray();
            this.postData.endian = Endian.BIG_ENDIAN;
        }

        public function writePostData(_arg_1:String, _arg_2:String):void
        {
            var _local_3:String;
            this.writeBoundary();
            this.writeLineBreak();
            _local_3 = (('Content-Disposition: form-data; name="' + _arg_1) + '"');
            var _local_4:uint = _local_3.length;
            var _local_5:Number = 0;
            while (_local_5 < _local_4)
            {
                this.postData.writeByte(_local_3.charCodeAt(_local_5));
                _local_5++;
            };
            this.writeLineBreak();
            this.writeLineBreak();
            this.postData.writeUTFBytes(_arg_2);
            this.writeLineBreak();
        }

        public function writeFileData(_arg_1:String, _arg_2:ByteArray, _arg_3:String):void
        {
            var _local_4:String;
            var _local_5:int;
            var _local_6:uint;
            this.writeBoundary();
            this.writeLineBreak();
            _local_4 = (('Content-Disposition: form-data; name="' + _arg_1) + '"; filename="');
            _local_5 = _local_4.length;
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                this.postData.writeByte(_local_4.charCodeAt(_local_6));
                _local_6++;
            };
            this.postData.writeUTFBytes((_arg_1 + ".JPG"));
            this.writeQuotationMark();
            this.writeLineBreak();
            _local_4 = _arg_3;
            _local_5 = _local_4.length;
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                this.postData.writeByte(_local_4.charCodeAt(_local_6));
                _local_6++;
            };
            this.writeLineBreak();
            this.writeLineBreak();
            _arg_2.position = 0;
            this.postData.writeBytes(_arg_2, 0, _arg_2.length);
            this.writeLineBreak();
            _arg_2.clear();
        }

        public function getPostData():ByteArray
        {
            this.postData.position = 0;
            return (this.postData);
        }

        public function close():void
        {
            this.writeBoundary();
            this.writeDoubleDash();
        }

        protected function writeLineBreak():void
        {
            this.postData.writeShort(3338);
        }

        protected function writeQuotationMark():void
        {
            this.postData.writeByte(34);
        }

        protected function writeDoubleDash():void
        {
            this.postData.writeShort(0x2D2D);
        }

        protected function writeBoundary():void
        {
            this.writeDoubleDash();
            var _local_1:uint = this.boundary.length;
            var _local_2:uint;
            while (_local_2 < _local_1)
            {
                this.postData.writeByte(this.boundary.charCodeAt(_local_2));
                _local_2++;
            };
        }


    }
}//package com.odnoklassniki.net

