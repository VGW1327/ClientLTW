


//com.hbm.socialmodule.rrhandlers.SpendMoneyHandler

package com.hbm.socialmodule.rrhandlers
{
    import com.hbm.socialmodule.rrhandlers.abstracts.AbstractRRHandler;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;
    import com.hbm.socialmodule.connection.crypto.Base64;
    import flash.utils.ByteArray;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.external.ExternalInterface;
    import com.odnoklassniki.Odnoklassniki;

    public class SpendMoneyHandler extends AbstractRRHandler implements RRHandler 
    {

        private static const logger:ILogger = getLogger(SpendMoneyHandler);

        private var _amount:Number;
        private var _purpose:String;
        private var _transactionId:uint;
        private var _serviceId:uint;

        public function SpendMoneyHandler(_arg_1:RRLoader, _arg_2:NetworkAPIHandler)
        {
            super(_arg_1, _arg_2);
        }

        public function SendRequest(_arg_1:Number, _arg_2:String, _arg_3:uint=0, _arg_4:uint=0):void
        {
            this._amount = _arg_1;
            this._purpose = _arg_2;
            this._transactionId = _arg_3;
            this._serviceId = _arg_4;
            apiHandler.PerformPayment(this);
        }

        public function ProcessResponse(_arg_1:Object):void
        {
            var _local_2:Object;
            var _local_3:Object;
            var _local_4:String;
            if (_arg_1.spendUserMoneyResponse != null)
            {
                _local_2 = _arg_1.spendUserMoneyResponse;
                if (_local_2.result == "ok")
                {
                    dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_2.result));
                }
                else
                {
                    DisptchError(_local_2.result);
                };
            }
            else
            {
                if (_arg_1.startOnlineDengiPaymentResponse != null)
                {
                    _local_3 = _arg_1.startOnlineDengiPaymentResponse;
                    if (_local_3.result == "ok")
                    {
                        _local_4 = this.ExtractOnlineDengiUrl(_local_3.urlBase64Encoded);
                        this.ContinueOnlineDengiPayment(_local_4);
                        dispatchEvent(new ResponseEvent(Event.COMPLETE, _local_3.result));
                    }
                    else
                    {
                        DisptchError(_local_3.result);
                    };
                }
                else
                {
                    DisptchError("Unknown header");
                };
            };
            dispatchEvent(new RRHandlerEvent(RRHandlerEvent.DONE));
        }

        private function ExtractOnlineDengiUrl(_arg_1:String):String
        {
            var _local_2:ByteArray = Base64.decode(_arg_1);
            return (String.fromCharCode(_local_2));
        }

        private function ContinueOnlineDengiPayment(url:String):void
        {
            try
            {
                navigateToURL(new URLRequest(url));
            }
            catch(e:Error)
            {
                logger.error(e.message);
            };
        }

        public function SendRequestToServer(_arg_1:int=-1):void
        {
            MethodName = "spendUserMoneyRequest";
            var _local_2:Object = {"amount":((_arg_1 > 0) ? _arg_1 : this._amount)};
            _local_2 = AddAuthorisationData(_local_2);
            if (this._purpose)
            {
                _local_2.source = this._purpose;
            };
            serverHandler.SendRequest(_local_2, this);
        }

        public function OpenFotostranaPaymentDialog():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("spendMoney", {"amount":this._amount});
                ExternalInterface.addCallback("spendMoneyCallback", this.SpendMoneyCallback);
            };
        }

        private function SpendMoneyCallback(_arg_1:Object):void
        {
            if (((!(_arg_1 == null)) && (!(_arg_1.result == null))))
            {
                logger.debug(("SpendMoneyCallback result: " + _arg_1.result));
                if (_arg_1.result == "success")
                {
                    logger.debug(("SpendMoneyCallback money: " + _arg_1.money));
                    this.SendRequestToServer(_arg_1.money);
                };
                ExternalInterface.addCallback("spendMoneyCallback", null);
            };
        }

        public function OpenVkontaktePaymentDialog():void
        {
            var _local_1:String = ((((this._purpose + ":") + this._transactionId) + ":") + int(this._amount));
            ExternalInterface.call("VK.callMethod", "showOrderBox", {
                "type":"item",
                "item":_local_1
            });
        }

        public function OpenMailRuDialog():void
        {
            var _local_1:int = int(this._amount);
            if (((_local_1 > 5000000) || (_local_1 < 100)))
            {
                throw (new ArgumentError("Amount must be between 100 and 5000000."));
            };
            if (this._purpose.length > 40)
            {
                throw (new ArgumentError("Description lenght may not be more than 40."));
            };
            if (this._transactionId == 0)
            {
                throw (new ArgumentError("Id parameter can't be 0."));
            };
            ExternalInterface.call("mailru.app.payments.showDialog", {
                "service_id":this._transactionId,
                "service_name":this._purpose,
                "other_price":_local_1
            });
        }

        public function OpenOdnoklDialog():void
        {
            Odnoklassniki.showPayment(this._purpose, this._purpose, this._transactionId.toString(), this._amount, null, null, "ok", "true");
        }

        public function SendOnlineDengiRequest():void
        {
            MethodName = "startOnlineDengiPaymentRequest";
            var _local_1:Object = {
                "amount":this._amount,
                "paymentSystemCode":this._transactionId,
                "onlineDengiProjectId":this._serviceId
            };
            _local_1 = AddAuthorisationData(_local_1);
            if (this._purpose)
            {
                _local_1.сomment = this._purpose;
            };
            serverHandler.SendRequest(_local_1, this);
        }


    }
}//package com.hbm.socialmodule.rrhandlers

