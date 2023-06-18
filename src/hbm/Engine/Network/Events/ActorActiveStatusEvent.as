


//hbm.Engine.Network.Events.ActorActiveStatusEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class ActorActiveStatusEvent extends Event 
    {

        public static const ON_ACTOR_ACTIVE_STATUS:String = "ON_ACTOR_ACTIVE_STATUS";
        public static const SI_BLANK:int = -1;
        public static const SI_PROVOKE:int = 0;
        public static const SI_ENDURE:int = 1;
        public static const SI_TWOHANDQUICKEN:int = 2;
        public static const SI_CONCENTRATE:int = 3;
        public static const SI_HIDING:int = 4;
        public static const SI_CLOAKING:int = 5;
        public static const SI_ENCPOISON:int = 6;
        public static const SI_POISONREACT:int = 7;
        public static const SI_QUAGMIRE:int = 8;
        public static const SI_ANGELUS:int = 9;
        public static const SI_BLESSING:int = 10;
        public static const SI_SIGNUMCRUCIS:int = 11;
        public static const SI_INCREASEAGI:int = 12;
        public static const SI_DECREASEAGI:int = 13;
        public static const SI_SLOWPOISON:int = 14;
        public static const SI_IMPOSITIO:int = 15;
        public static const SI_SUFFRAGIUM:int = 16;
        public static const SI_ASPERSIO:int = 17;
        public static const SI_BENEDICTIO:int = 18;
        public static const SI_KYRIE:int = 19;
        public static const SI_MAGNIFICAT:int = 20;
        public static const SI_GLORIA:int = 21;
        public static const SI_AETERNA:int = 22;
        public static const SI_ADRENALINE:int = 23;
        public static const SI_WEAPONPERFECTION:int = 24;
        public static const SI_OVERTHRUST:int = 25;
        public static const SI_MAXIMIZEPOWER:int = 26;
        public static const SI_RIDING:int = 27;
        public static const SI_FALCON:int = 28;
        public static const SI_TRICKDEAD:int = 29;
        public static const SI_LOUD:int = 30;
        public static const SI_ENERGYCOAT:int = 31;
        public static const SI_BROKENARMOR:int = 32;
        public static const SI_BROKENWEAPON:int = 33;
        public static const SI_HALLUCINATION:int = 34;
        public static const SI_WEIGHT50:int = 35;
        public static const SI_WEIGHT90:int = 36;
        public static const SI_ASPDPOTION:int = 37;
        public static const SI_SPEEDPOTION1:int = 41;
        public static const SI_SPEEDPOTION2:int = 42;
        public static const SI_STRIPWEAPON:int = 50;
        public static const SI_STRIPSHIELD:int = 51;
        public static const SI_STRIPARMOR:int = 52;
        public static const SI_STRIPHELM:int = 53;
        public static const SI_CP_WEAPON:int = 54;
        public static const SI_CP_SHIELD:int = 55;
        public static const SI_CP_ARMOR:int = 56;
        public static const SI_CP_HELM:int = 57;
        public static const SI_AUTOGUARD:int = 58;
        public static const SI_REFLECTSHIELD:int = 59;
        public static const SI_PROVIDENCE:int = 61;
        public static const SI_DEFENDER:int = 62;
        public static const SI_AUTOSPELL:int = 65;
        public static const SI_SPEARQUICKEN:int = 68;
        public static const SI_EXPLOSIONSPIRITS:int = 86;
        public static const SI_STEELBODY:int = 87;
        public static const SI_FIREWEAPON:int = 90;
        public static const SI_WATERWEAPON:int = 91;
        public static const SI_WINDWEAPON:int = 92;
        public static const SI_EARTHWEAPON:int = 93;
        public static const SI_STOP:int = 95;
        public static const SI_UNDEAD:int = 97;
        public static const SI_AURABLADE:int = 103;
        public static const SI_PARRYING:int = 104;
        public static const SI_CONCENTRATION:int = 105;
        public static const SI_TENSIONRELAX:int = 106;
        public static const SI_BERSERK:int = 107;
        public static const SI_ASSUMPTIO:int = 110;
        public static const SI_LANDENDOW:int = 112;
        public static const SI_MAGICPOWER:int = 113;
        public static const SI_EDP:int = 114;
        public static const SI_TRUESIGHT:int = 115;
        public static const SI_WINDWALK:int = 116;
        public static const SI_MELTDOWN:int = 117;
        public static const SI_CARTBOOST:int = 118;
        public static const SI_REJECTSWORD:int = 120;
        public static const SI_MARIONETTE:int = 121;
        public static const SI_MARIONETTE2:int = 122;
        public static const SI_MOONLIT:int = 123;
        public static const SI_BLEEDING:int = 124;
        public static const SI_JOINTBEAT:int = 125;
        public static const SI_BABY:int = 130;
        public static const SI_AUTOBERSERK:int = 132;
        public static const SI_RUN:int = 133;
        public static const SI_BUMP:int = 134;
        public static const SI_READYSTORM:int = 135;
        public static const SI_READYDOWN:int = 137;
        public static const SI_READYTURN:int = 139;
        public static const SI_READYCOUNTER:int = 141;
        public static const SI_DODGE:int = 143;
        public static const SI_SPURT:int = 145;
        public static const SI_SHADOWWEAPON:int = 146;
        public static const SI_ADRENALINE2:int = 147;
        public static const SI_GHOSTWEAPON:int = 148;
        public static const SI_SPIRIT:int = 149;
        public static const SI_DEVIL:int = 152;
        public static const SI_KAITE:int = 153;
        public static const SI_KAIZEL:int = 156;
        public static const SI_KAAHI:int = 157;
        public static const SI_KAUPE:int = 158;
        public static const SI_SMA:int = 159;
        public static const SI_NIGHT:int = 160;
        public static const SI_ONEHAND:int = 161;
        public static const SI_WARM:int = 165;
        public static const SI_SUN_COMFORT:int = 169;
        public static const SI_MOON_COMFORT:int = 170;
        public static const SI_STAR_COMFORT:int = 171;
        public static const SI_PRESERVE:int = 181;
        public static const SI_INCSTR:int = 182;
        public static const SI_INTRAVISION:int = 184;
        public static const SI_DOUBLECAST:int = 186;
        public static const SI_MAXOVERTHRUST:int = 188;
        public static const SI_TAROT:int = 191;
        public static const SI_SHRINK:int = 197;
        public static const SI_SIGHTBLASTER:int = 198;
        public static const SI_WINKCHARM:int = 199;
        public static const SI_CLOSECONFINE:int = 200;
        public static const SI_CLOSECONFINE2:int = 201;
        public static const SI_MADNESSCANCEL:int = 203;
        public static const SI_GATLINGFEVER:int = 204;
        public static const SI_TKREST:int = 205;
        public static const SI_UTSUSEMI:int = 206;
        public static const SI_BUNSINJYUTSU:int = 207;
        public static const SI_NEN:int = 208;
        public static const SI_ADJUSTMENT:int = 209;
        public static const SI_ACCURACY:int = 210;
        public static const SI_FOODSTR:int = 241;
        public static const SI_FOODAGI:int = 242;
        public static const SI_FOODVIT:int = 243;
        public static const SI_FOODDEX:int = 244;
        public static const SI_FOODINT:int = 245;
        public static const SI_FOODLUK:int = 246;
        public static const SI_FOODFLEE:int = 247;
        public static const SI_FOODHIT:int = 248;
        public static const SI_FOODCRI:int = 249;
        public static const SI_EXPBOOST:int = 250;
        public static const SI_LIFEINSURANCE:int = 251;
        public static const SI_ITEMBOOST:int = 252;
        public static const SI_BOSSMAPINFO:int = 253;
        public static const SI_SLOWCAST:int = 282;
        public static const SI_CRITICALWOUND:int = 286;
        public static const SI_DEF_RATE:int = 290;
        public static const SI_MDEF_RATE:int = 291;
        public static const SI_INCCRI:int = 292;
        public static const SI_INCHEALRATE:int = 293;
        public static const SI_HPREGEN:int = 294;
        public static const SI_SPCOST_RATE:int = 300;
        public static const SI_COMMONSC_RESIST:int = 301;
        public static const SI_ARMOR_RESIST:int = 302;
        public static const SI_DEATHFEAR:int = 305;
        public static const SI_BREAKRIB:int = 310;
        public static const SI_GUILDAURA:int = 314;
        public static const SI_JAILED:int = 381;
        public static const SI_MDEFAURA:int = 382;
        public static const SI_ETERNALCHAOS:int = 383;
        public static const SI_DECMATKRATE:int = 384;
        public static const SI_DECATKRATE:int = 385;
        public static const SI_COMA:int = 386;
        public static const SI_CONFUSION:int = 387;
        public static const SI_DECDEFRATE:int = 388;
        public static const SI_DECMDEFRATE:int = 389;
        public static const SI_DECFLEERATE:int = 390;
        public static const SI_DECHITRATE:int = 391;
        public static const SI_FREEZE:int = 393;
        public static const SI_SLEEP:int = 394;
        public static const SI_STONE:int = 395;
        public static const SI_STUN:int = 396;
        public static const SI_POISON:int = 397;
        public static const SI_SILENCE:int = 398;
        public static const SI_BLIND:int = 399;
        public static const SI_MANNER:int = 400;
        public static const SI_DPOISON:int = 401;
        public static const SI_CURSE:int = 402;
        public static const SI_LADDER:int = 404;
        public static const SI_BREAKHEAD:int = 405;
        public static const SI_DURABILITY30:int = 900;
        public static const SI_DURABILITY5:int = 901;

        public var characterId:uint;
        public var statusType:int;
        public var flag:int;
        public var duration:uint;

        public function ActorActiveStatusEvent()
        {
            super(ON_ACTOR_ACTIVE_STATUS);
        }

    }
}//package hbm.Engine.Network.Events

