


//hbm.Engine.Actors.PartyInfo

package hbm.Engine.Actors
{
    import flash.utils.Dictionary;

    public class PartyInfo 
    {

        private var _id:int;
        private var _name:String;
        private var _options1:int;
        private var _options2:int;
        private var _partyMembers:Dictionary;

        public function PartyInfo()
        {
            this._partyMembers = new Dictionary(true);
        }

        public function get Options2():int
        {
            return (this._options2);
        }

        public function set Options2(_arg_1:int):void
        {
            this._options2 = _arg_1;
        }

        public function get Options1():int
        {
            return (this._options1);
        }

        public function set Options1(_arg_1:int):void
        {
            this._options1 = _arg_1;
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function set Name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get PartyMembers():Dictionary
        {
            return (this._partyMembers);
        }

        public function set PartyMembers(_arg_1:Dictionary):void
        {
            this._partyMembers = _arg_1;
        }

        public function get Id():int
        {
            return (this._id);
        }

        public function set Id(_arg_1:int):void
        {
            this._id = _arg_1;
        }


    }
}//package hbm.Engine.Actors

