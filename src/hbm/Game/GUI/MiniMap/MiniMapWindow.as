


//hbm.Game.GUI.MiniMap.MiniMapWindow

package hbm.Game.GUI.MiniMap
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JPanel;
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.filters.GlowFilter;
    import org.aswing.ASColor;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.Border;
    import org.aswing.border.EmptyBorder;
    import hbm.Application.ClientApplication;
    import flash.display.DisplayObject;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.EmptyLayout;
    import org.aswing.AssetBackground;
    import org.aswing.BoxLayout;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.Component;
    import hbm.Engine.Actors.GuildMember;
    import hbm.Engine.Actors.PartyMember;
    import hbm.Engine.Actors.GuildInfo;
    import hbm.Engine.Actors.PartyInfo;
    import flash.events.MouseEvent;
    import org.aswing.JLabel;
    import org.aswing.geom.IntDimension;
    import org.aswing.JTextArea;
    import org.aswing.ASFont;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Game.Character.CharacterStorage;

    public class MiniMapWindow extends CustomWindow 
    {

        private static const QUESTION_MAP_IMAGE:String = "QuestionSmall";
        private static const WHOOP_MAP_IMAGE:String = "WhoopSmall";
        private static const NPC_MAP_IMAGE:String = "PointNpc";
        private static const PORTAL_MAP_IMAGE:String = "PointPortal";
        private static const CHEST_MAP_IMAGE:String = "PointChest";
        private static const SHOP_MAP_IMAGE:String = "PointShop";
        private static const PARTY_LEADER_MAP_IMAGE:String = "PointPartyLeader";
        private static const GUILD_MEMBER_MAP_IMAGE:String = "PointGuildMember";

        private var _mapContainer:JPanel;
        private var _bitmap:Bitmap;
        private var _pointBitmap:Bitmap;
        private var _position:Point;
        private var _mapScaleToRealWorld:Number;
        private var _mapId:String = null;
        private var _glowFilter:GlowFilter = new GlowFilter(ASColor.HALO_ORANGE.getARGB());
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _debugBorder:Border = new EmptyBorder();
        private var _moveObjects:Object = {};

        public function MiniMapWindow(_arg_1:DisplayObject, _arg_2:Number, _arg_3:String)
        {
            var _local_4:int = ((_arg_1) ? (_arg_1.width - 11) : 400);
            var _local_5:int = ((_arg_1) ? (_arg_1.height - 20) : 400);
            this._mapScaleToRealWorld = _arg_2;
            super(null, _arg_3, false, _local_4, _local_5, true);
            setLocationXY(((ClientApplication.stageWidth - _local_4) / 2), (((0x0300 - _local_5) / 2) - 50));
            this.InitUI();
            this.SetMap(_arg_1, _arg_2);
        }

        private function InitUI():void
        {
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._mapContainer = new JPanel(new EmptyLayout());
            this._position = new Point(0, 0);
            this._pointBitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_PointPlayer");
            this._bitmap = new Bitmap();
            this._bitmap.x = 0;
            this._bitmap.y = 0;
            this._mapContainer.setBackgroundDecorator(new AssetBackground(this._bitmap));
            MainPanel.setLayout(new BoxLayout());
            MainPanel.append(this._mapContainer);
            pack();
        }

        public function SetMap(_arg_1:DisplayObject, _arg_2:Number, _arg_3:String=null):void
        {
            var _local_4:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (((_arg_1) && (_local_4)))
            {
                this._bitmap.bitmapData = (_arg_1 as Bitmap).bitmapData.clone();
                this._mapScaleToRealWorld = _arg_2;
                this._position.x = ((_local_4.coordinates.x * _arg_2) - (this._pointBitmap.width / 2));
                this._position.y = ((_arg_1.height - (_local_4.coordinates.y * _arg_2)) - (this._pointBitmap.height / 2));
                this._bitmap.bitmapData.copyPixels(this._pointBitmap.bitmapData, this._pointBitmap.bitmapData.rect, this._position, this._pointBitmap.bitmapData, this._pointBitmap.bitmapData.rect.topLeft, true);
                this.PlaceNpcObjectsToMap(ClientApplication.Instance.LocalGameClient.MapName);
                this.PlaceMoveObjectsToMap();
            };
        }

        private function CacheMoveObjects(_arg_1:Object, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:Bitmap):void
        {
            var _local_6:Component;
            var _local_7:int;
            var _local_8:int;
            if ((_arg_2 in this._moveObjects))
            {
                _local_6 = this._moveObjects[_arg_2];
                _arg_1[_arg_2] = _local_6;
                _local_7 = int(((_arg_3 * this._mapScaleToRealWorld) - (_arg_5.width / 2)));
                _local_8 = int(((this._bitmap.height - (_arg_4 * this._mapScaleToRealWorld)) - (_arg_5.height / 2)));
                _local_6.setBackgroundDecorator(new AssetBackground(_arg_5));
                _local_6.setLocationXY(_local_7, _local_8);
                delete this._moveObjects[_arg_2];
                if (!this._mapContainer.contains(_local_6))
                {
                    this._mapContainer.append(_local_6);
                };
            }
            else
            {
                _local_6 = this.CreateObjectLabel(_arg_2, _arg_3, _arg_4, _arg_5);
                _arg_1[_arg_2] = _local_6;
                this._mapContainer.append(_local_6);
            };
        }

        private function PlaceMoveObjectsToMap():void
        {
            var _local_1:CharacterInfo;
            var _local_5:Bitmap;
            var _local_6:Component;
            var _local_7:GuildMember;
            var _local_8:PartyMember;
            var _local_9:PartyMember;
            _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_2:GuildInfo = ((_local_1) ? _local_1.Guild : null);
            var _local_3:PartyInfo = ((_local_1) ? _local_1.Party : null);
            var _local_4:Object = {};
            if (_local_2 != null)
            {
                _local_5 = this.GetImage(GUILD_MEMBER_MAP_IMAGE);
                if (_local_5 != null)
                {
                    for each (_local_7 in _local_2.members)
                    {
                        if (((!(_local_7.coordinates == null)) && (!(_local_1.characterId == _local_7.characterId))))
                        {
                            if (_local_3 != null)
                            {
                                _local_8 = _local_3.PartyMembers[_local_7.accountId];
                                if (_local_8 != null) continue;
                            };
                            this.CacheMoveObjects(_local_4, _local_7.name, _local_7.coordinates.x, _local_7.coordinates.y, _local_5);
                        };
                    };
                };
            };
            if (_local_3 != null)
            {
                _local_5 = this.GetImage(PARTY_LEADER_MAP_IMAGE);
                if (_local_5 != null)
                {
                    for each (_local_9 in _local_3.PartyMembers)
                    {
                        if (((((_local_9.Online) && (_local_9.X >= 0)) && (_local_9.Y >= 0)) && (!(_local_1.characterId == _local_9.CharacterId))))
                        {
                            this.CacheMoveObjects(_local_4, _local_9.Name, _local_9.X, _local_9.Y, _local_5);
                        };
                    };
                };
            };
            for each (_local_6 in this._moveObjects)
            {
                _local_6.removeEventListener(MouseEvent.MOUSE_OVER, this.OnMouseIn);
                _local_6.removeEventListener(MouseEvent.MOUSE_OUT, this.OnMouseOut);
                _local_6.removeFromContainer();
            };
            this._moveObjects = _local_4;
        }

        private function PlaceNpcObjectsToMap(_arg_1:String):void
        {
            var _local_3:String;
            var _local_4:Object;
            if (((!(_arg_1)) || (_arg_1 == this._mapId)))
            {
                return;
            };
            this._mapId = _arg_1;
            this._mapContainer.removeAll();
            var _local_2:Array = this._dataLibrary.GetNpcIdArray(_arg_1);
            if (!_local_2)
            {
                return;
            };
            for each (_local_3 in _local_2)
            {
                _local_4 = this._dataLibrary.GetNpcDataFromId(_local_3);
                if (!((!(_local_4)) || ((_local_4.PositionX == -1) && (_local_4.PositionY == -1))))
                {
                    this._mapContainer.append(this.CreateNpcLabel(_local_4));
                };
            };
        }

        private function CreateObjectLabel(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Bitmap):Component
        {
            var _local_5:JLabel = new JLabel();
            _local_5.setSize(new IntDimension(_arg_4.width, _arg_4.height));
            _local_5.setBackgroundDecorator(new AssetBackground(_arg_4));
            _local_5.setBorder(this._debugBorder);
            _local_5.addEventListener(MouseEvent.MOUSE_OVER, this.OnMouseIn, false, 0, true);
            _local_5.addEventListener(MouseEvent.MOUSE_OUT, this.OnMouseOut, false, 0, true);
            var _local_6:int = int(((_arg_2 * this._mapScaleToRealWorld) - (_arg_4.width / 2)));
            var _local_7:int = int(((this._bitmap.height - (_arg_3 * this._mapScaleToRealWorld)) - (_arg_4.height / 2)));
            _local_5.setLocationXY(_local_6, _local_7);
            this.CreateToolTip(_local_5, _arg_1);
            return (_local_5);
        }

        private function CreateNpcLabel(_arg_1:Object):Component
        {
            var _local_2:JLabel = new JLabel();
            var _local_3:Bitmap = this.GetImageByNpcType(_arg_1);
            return (this.CreateObjectLabel(_arg_1["Name"], _arg_1.PositionX, _arg_1.PositionY, _local_3));
        }

        private function CreateToolTip(_arg_1:Component, _arg_2:String):void
        {
            var _local_3:ASFont = new JTextArea().getFont();
            var _local_4:int = _local_3.computeTextSize(_arg_2).width;
            new CustomToolTip(_arg_1, _arg_2, _local_4, 8);
        }

        private function OnMouseIn(_arg_1:MouseEvent):void
        {
            var _local_2:Component = (_arg_1.target as Component);
            _local_2.filters = [this._glowFilter];
        }

        private function OnMouseOut(_arg_1:MouseEvent):void
        {
            var _local_2:Component = (_arg_1.target as Component);
            _local_2.filters = [];
        }

        private function GetImageByNpcType(_arg_1:Object):Bitmap
        {
            var _local_2:int;
            switch (_arg_1.Type)
            {
                case 0:
                    _local_2 = CharacterStorage.Instance.LocalPlayerCharacter.GetQuestStatus(_arg_1.Id);
                    if (_local_2 == 2)
                    {
                        return (this.GetImage(QUESTION_MAP_IMAGE));
                    };
                    if (_local_2 == 1)
                    {
                        return (this.GetImage(WHOOP_MAP_IMAGE));
                    };
                    return (this.GetImage(NPC_MAP_IMAGE));
                case 1:
                case 2:
                case 3:
                    return (this.GetImage(SHOP_MAP_IMAGE));
                case 10:
                    return (this.GetImage(PORTAL_MAP_IMAGE));
                case 15:
                    return (this.GetImage(CHEST_MAP_IMAGE));
                default:
                    throw (new ArgumentError(("Unknown NPC type: " + _arg_1.Type)));
            };
        }

        private function GetImage(_arg_1:String):Bitmap
        {
            return (this._dataLibrary.GetBitmapAsset(("AdditionalData_Item_" + _arg_1)));
        }


    }
}//package hbm.Game.GUI.MiniMap

