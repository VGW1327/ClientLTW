


//com.hbm.socialmodule.connection.socialapi.APIHandlerFactory

package com.hbm.socialmodule.connection.socialapi
{
    import com.hbm.socialmodule.connection.socialapi.vkontakte.VkoAPIHandler;
    import com.hbm.socialmodule.data.SocialNetworkState;
    import com.hbm.socialmodule.connection.socialapi.mailru.MailruAPIHandler;
    import com.hbm.socialmodule.connection.socialapi.odnkl.OdklAPIHandler;
    import com.hbm.socialmodule.connection.socialapi.facebook.FacebookAPIHandler;
    import com.hbm.socialmodule.connection.socialapi.fotostrana.FsAPIHandler;
    import com.hbm.socialmodule.connection.socialapi.web.WebAPIHandler;

    public class APIHandlerFactory 
    {


        public static function CreateAPIHandler(_arg_1:Object, _arg_2:String, _arg_3:uint):NetworkAPIHandler
        {
            switch (_arg_3)
            {
                case SocialNetworkState.VKONTAKTE_API:
                    return (new VkoAPIHandler(_arg_1, _arg_2));
                case SocialNetworkState.MAILRU_API:
                    return (new MailruAPIHandler(_arg_1, _arg_2));
                case SocialNetworkState.ODNOKL_API:
                    return (new OdklAPIHandler(_arg_1, _arg_2));
                case SocialNetworkState.FACEBOOK_API:
                    return (new FacebookAPIHandler(_arg_1));
                case SocialNetworkState.FOTOSTRANA_API:
                    return (new FsAPIHandler(_arg_1, _arg_2));
                case SocialNetworkState.WEB_API:
                    return (new WebAPIHandler(_arg_1));
                default:
                    return (null);
            };
        }


    }
}//package com.hbm.socialmodule.connection.socialapi

