


//hbm.Game.Character.Customizations.ManOrcAnimation

package hbm.Game.Character.Customizations
{
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Game.Renderer.CharacterAnimationState;
    import hbm.Game.Renderer.CharacterAnimationFrame;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class ManOrcAnimation extends CharacterAnimation 
    {

        public function ManOrcAnimation()
        {
            EnableNewImageFormat();
            SetCharacterName("ManOrc");
            AddTexture("ManOrcGraphics_Item00_Color", "ManOrcGraphics_Item00_Alpha");
            AddTexture("ManOrcGraphics_Item01_Color", "ManOrcGraphics_Item01_Alpha");
            var _local_1:CharacterAnimationState;
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, 1), new Point(51, 107), 0, new Rectangle(0, 0, 102, 214)));
            AddAnimationState("Background", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-7, -37), new Point(56, 63), 0, new Rectangle(380, 538, 112, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, -41), new Point(61, 62), 0, new Rectangle(332, 666, 122, 124)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-3, -36), new Point(52, 45), 0, new Rectangle(706, 906, 104, 90)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-3, -31), new Point(60, 57), 0, new Rectangle(0, 792, 120, 114)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, -30), new Point(62, 56), 0, new Rectangle(120, 792, 124, 112)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, -28), new Point(52, 53), 0, new Rectangle(584, 792, 104, 106)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-15, -38), new Point(67, 65), 0, new Rectangle(844, 384, 134, 130)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, -32), new Point(56, 58), 0, new Rectangle(778, 666, 112, 116)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, -41), new Point(61, 62), 0, new Rectangle(454, 666, 122, 124)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(0, -33), new Point(57, 56), 0, new Rectangle(368, 792, 114, 112)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-13, -29), new Point(61, 57), 0, new Rectangle(890, 666, 122, 114)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, -30), new Point(62, 56), 0, new Rectangle(244, 792, 124, 112)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, -36), new Point(62, 41), 1, new Rectangle(414, 0, 124, 82)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-9, -26), new Point(51, 54), 0, new Rectangle(482, 792, 102, 108)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, -38), new Point(63, 43), 1, new Rectangle(0, 0, 126, 86)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(5, -32), new Point(62, 52), 0, new Rectangle(688, 792, 124, 104)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, 7), new Point(63, 85), 0, new Rectangle(748, 0, 126, 170)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, 1), new Point(56, 91), 0, new Rectangle(216, 0, 112, 182)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-7, 9), new Point(58, 84), 0, new Rectangle(320, 214, 116, 168)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-15, 9), new Point(61, 87), 0, new Rectangle(328, 0, 122, 174)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-5, 8), new Point(54, 86), 0, new Rectangle(450, 0, 108, 172)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-4, 9), new Point(50, 86), 0, new Rectangle(558, 0, 100, 172)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-6, 7), new Point(52, 85), 0, new Rectangle(874, 0, 104, 170)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-7, 9), new Point(58, 84), 0, new Rectangle(88, 214, 116, 168)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-7, 9), new Point(58, 84), 0, new Rectangle(204, 214, 116, 168)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, -41), new Point(61, 62), 0, new Rectangle(576, 666, 122, 124)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(2, -31), new Point(71, 77), 0, new Rectangle(0, 384, 142, 154)));
            AddAnimationState("Body", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, 5), new Point(49, 80), 0, new Rectangle(818, 214, 98, 160)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, 1), new Point(44, 76), 0, new Rectangle(142, 384, 88, 152)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-3, 16), new Point(57, 92), 0, new Rectangle(102, 0, 114, 184)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 8), new Point(46, 83), 0, new Rectangle(530, 214, 92, 166)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-12, 8), new Point(47, 83), 0, new Rectangle(436, 214, 94, 166)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-7, 9), new Point(44, 85), 0, new Rectangle(0, 214, 88, 170)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, 5), new Point(49, 80), 0, new Rectangle(720, 214, 98, 160)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-9, 6), new Point(49, 81), 0, new Rectangle(622, 214, 98, 162)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, 1), new Point(44, 76), 0, new Rectangle(230, 384, 88, 152)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 8), new Point(45, 86), 0, new Rectangle(658, 0, 90, 172)));
            AddAnimationState("Cloak", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-15, -83), new Point(18, 24), 1, new Rectangle(0, 150, 36, 48)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-19, -83), new Point(37, 27), 1, new Rectangle(548, 86, 74, 54)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-15, -85), new Point(21, 25), 1, new Rectangle(922, 86, 42, 50)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-16, -85), new Point(18, 19), 1, new Rectangle(456, 150, 36, 38)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-23, -81), new Point(38, 27), 1, new Rectangle(398, 86, 76, 54)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-18, -78), new Point(27, 23), 1, new Rectangle(36, 150, 54, 46)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-19, -83), new Point(27, 27), 1, new Rectangle(678, 86, 54, 54)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-19, -83), new Point(37, 27), 1, new Rectangle(474, 86, 74, 54)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-19, -83), new Point(23, 27), 1, new Rectangle(780, 86, 46, 54)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-16, -86), new Point(23, 23), 1, new Rectangle(90, 150, 46, 46)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-15, -85), new Point(18, 21), 1, new Rectangle(420, 150, 36, 42)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-16, -81), new Point(25, 24), 1, new Rectangle(964, 86, 50, 48)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-19, -84), new Point(26, 26), 1, new Rectangle(826, 86, 52, 52)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-16, -86), new Point(23, 23), 1, new Rectangle(136, 150, 46, 46)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-13, -85), new Point(21, 22), 1, new Rectangle(378, 150, 42, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-19, -79), new Point(24, 27), 1, new Rectangle(732, 86, 48, 54)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-20, -80), new Point(31, 30), 1, new Rectangle(188, 86, 62, 60)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-17, -78), new Point(32, 32), 1, new Rectangle(914, 0, 64, 64)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-21, -77), new Point(28, 27), 1, new Rectangle(622, 86, 56, 54)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, -88), new Point(25, 22), 1, new Rectangle(278, 150, 50, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, -88), new Point(25, 22), 1, new Rectangle(328, 150, 50, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-18, -80), new Point(37, 30), 1, new Rectangle(114, 86, 74, 60)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-15, -78), new Point(27, 29), 1, new Rectangle(302, 86, 54, 58)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-16, -78), new Point(25, 32), 1, new Rectangle(0, 86, 50, 64)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-16, -86), new Point(23, 23), 1, new Rectangle(182, 150, 46, 46)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, -88), new Point(25, 22), 1, new Rectangle(228, 150, 50, 44)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-15, -81), new Point(21, 29), 1, new Rectangle(356, 86, 42, 58)));
            AddAnimationState("Head", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 93), new Point(41, 17), 1, new Rectangle(656, 150, 82, 34)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 94), new Point(41, 16), 1, new Rectangle(82, 198, 82, 32)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 93), new Point(41, 17), 1, new Rectangle(738, 150, 82, 34)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 93), new Point(41, 17), 1, new Rectangle(820, 150, 82, 34)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-10, 94), new Point(41, 16), 1, new Rectangle(0, 198, 82, 32)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 94), new Point(41, 16), 1, new Rectangle(902, 150, 82, 32)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 93), new Point(41, 17), 1, new Rectangle(574, 150, 82, 34)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 93), new Point(41, 17), 1, new Rectangle(492, 150, 82, 34)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-10, 39), new Point(40, 71), 0, new Rectangle(434, 384, 80, 142)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-10, 39), new Point(40, 71), 0, new Rectangle(0x0202, 384, 80, 142)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 46), new Point(41, 64), 0, new Rectangle(298, 538, 82, 128)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-9, 46), new Point(52, 64), 0, new Rectangle(106, 538, 104, 128)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-8, 46), new Point(40, 63), 0, new Rectangle(252, 666, 80, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 46), new Point(41, 63), 0, new Rectangle(170, 666, 82, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-12, 46), new Point(42, 63), 0, new Rectangle(86, 666, 84, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-10, 47), new Point(40, 62), 0, new Rectangle(698, 666, 80, 124)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-7, 47), new Point(47, 63), 0, new Rectangle(680, 538, 94, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-12, 47), new Point(43, 63), 0, new Rectangle(0, 666, 86, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 44), new Point(45, 66), 0, new Rectangle(754, 384, 90, 132)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-11, 47), new Point(44, 63), 0, new Rectangle(774, 538, 88, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-10, 38), new Point(40, 71), 0, new Rectangle(674, 384, 80, 142)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-7, 47), new Point(47, 63), 0, new Rectangle(586, 538, 94, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-12, 47), new Point(43, 63), 0, new Rectangle(862, 538, 86, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-10, 46), new Point(44, 64), 0, new Rectangle(210, 538, 88, 128)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-10, 39), new Point(40, 71), 0, new Rectangle(594, 384, 80, 142)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-7, 47), new Point(47, 63), 0, new Rectangle(492, 538, 94, 126)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-2, 46), new Point(53, 64), 0, new Rectangle(0, 538, 106, 128)));
            AddAnimationState("Leg", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-86, 50), new Point(46, 51), 0, new Rectangle(0, 906, 92, 102)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-86, 49), new Point(47, 51), 0, new Rectangle(906, 792, 94, 102)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-86, 41), new Point(49, 43), 1, new Rectangle(126, 0, 98, 86)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-96, 40), new Point(56, 47), 0, new Rectangle(498, 906, 112, 94)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-86, 51), new Point(47, 51), 0, new Rectangle(812, 792, 94, 102)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-96, 40), new Point(56, 47), 0, new Rectangle(386, 906, 112, 94)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-87, 45), new Point(48, 50), 0, new Rectangle(92, 906, 96, 100)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-88, 44), new Point(48, 48), 0, new Rectangle(290, 906, 96, 96)));
            AddAnimationState("Weapon/Blade2H", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-87, 34), new Point(48, 32), 1, new Rectangle(818, 0, 96, 64)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-87, 41), new Point(47, 41), 1, new Rectangle(538, 0, 94, 82)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-86, 39), new Point(47, 44), 0, new Rectangle(810, 906, 94, 88)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-87, 34), new Point(48, 46), 0, new Rectangle(610, 906, 96, 92)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-84, 37), new Point(51, 49), 0, new Rectangle(188, 906, 102, 98)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-86, 41), new Point(48, 43), 1, new Rectangle(224, 0, 96, 86)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(-87, 35), new Point(47, 42), 1, new Rectangle(320, 0, 94, 84)));
            AddAnimationState("Weapon/Mace", _local_1);
            _local_1 = new CharacterAnimationState();
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(32, 35), new Point(22, 25), 1, new Rectangle(878, 86, 44, 50)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(31, 35), new Point(26, 30), 1, new Rectangle(250, 86, 52, 60)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(33, 51), new Point(30, 41), 1, new Rectangle(632, 0, 60, 82)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(37, 41), new Point(32, 31), 1, new Rectangle(50, 86, 64, 62)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(25, 45), new Point(33, 35), 1, new Rectangle(752, 0, 66, 70)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(30, 47), new Point(30, 39), 1, new Rectangle(692, 0, 60, 78)));
            _local_1.AddAnimationFrame(new CharacterAnimationFrame(new Point(7, 10), new Point(58, 71), 0, new Rectangle(318, 384, 116, 142)));
            AddAnimationState("Weapon/Tambourine", _local_1);
        }

    }
}//package hbm.Game.Character.Customizations

