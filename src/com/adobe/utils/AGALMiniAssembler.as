


//com.adobe.utils.AGALMiniAssembler

package com.adobe.utils
{
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    import flash.utils.Endian;
    import flash.utils.*;

    public class AGALMiniAssembler 
    {

        protected static const USE_NEW_SYNTAX:Boolean = false;
        protected static const REGEXP_OUTER_SPACES:RegExp = /^\s+|\s+$/g;
        protected static const COMPONENTS:Object = {
            "120":0,
            "121":1,
            "122":2,
            "119":3,
            "114":0,
            "103":1,
            "98":2,
            "97":3
        };
        private static var initialized:Boolean = false;
        private static const OPMAP:Dictionary = new Dictionary();
        private static const REGMAP:Dictionary = new Dictionary();
        private static const SAMPLEMAP:Dictionary = new Dictionary();
        private static const MAX_NESTING:int = 4;
        private static const MAX_OPCODES:int = 0x0100;
        private static const FRAGMENT:String = "fragment";
        private static const VERTEX:String = "vertex";
        private static const SAMPLER_DIM_SHIFT:uint = 12;
        private static const SAMPLER_SPECIAL_SHIFT:uint = 16;
        private static const SAMPLER_REPEAT_SHIFT:uint = 20;
        private static const SAMPLER_MIPMAP_SHIFT:uint = 24;
        private static const SAMPLER_FILTER_SHIFT:uint = 28;
        private static const REG_WRITE:uint = 1;
        private static const REG_READ:uint = 2;
        private static const REG_FRAG:uint = 32;
        private static const REG_VERT:uint = 64;
        private static const OP_SCALAR:uint = 1;
        private static const OP_INC_NEST:uint = 2;
        private static const OP_DEC_NEST:uint = 4;
        private static const OP_SPECIAL_TEX:uint = 8;
        private static const OP_SPECIAL_MATRIX:uint = 16;
        private static const OP_FRAG_ONLY:uint = 32;
        private static const OP_VERT_ONLY:uint = 64;
        private static const OP_NO_DEST:uint = 128;
        private static const MOV:String = "mov";
        private static const ADD:String = "add";
        private static const SUB:String = "sub";
        private static const MUL:String = "mul";
        private static const DIV:String = "div";
        private static const RCP:String = "rcp";
        private static const MIN:String = "min";
        private static const MAX:String = "max";
        private static const FRC:String = "frc";
        private static const SQT:String = "sqt";
        private static const RSQ:String = "rsq";
        private static const POW:String = "pow";
        private static const LOG:String = "log";
        private static const EXP:String = "exp";
        private static const NRM:String = "nrm";
        private static const SIN:String = "sin";
        private static const COS:String = "cos";
        private static const CRS:String = "crs";
        private static const DP3:String = "dp3";
        private static const DP4:String = "dp4";
        private static const ABS:String = "abs";
        private static const NEG:String = "neg";
        private static const SAT:String = "sat";
        private static const M33:String = "m33";
        private static const M44:String = "m44";
        private static const M34:String = "m34";
        private static const IFZ:String = "ifz";
        private static const INZ:String = "inz";
        private static const IFE:String = "ife";
        private static const INE:String = "ine";
        private static const IFG:String = "ifg";
        private static const IFL:String = "ifl";
        private static const IEG:String = "ieg";
        private static const IEL:String = "iel";
        private static const ELS:String = "els";
        private static const EIF:String = "eif";
        private static const REP:String = "rep";
        private static const ERP:String = "erp";
        private static const BRK:String = "brk";
        private static const KIL:String = "kil";
        private static const TEX:String = "tex";
        private static const SGE:String = "sge";
        private static const SLT:String = "slt";
        private static const SGN:String = "sgn";
        private static const VA:String = "va";
        private static const VC:String = "vc";
        private static const VT:String = "vt";
        private static const VO:String = ((USE_NEW_SYNTAX) ? "vo" : "op");
        private static const I:String = ((USE_NEW_SYNTAX) ? "i" : "v");
        private static const FC:String = "fc";
        private static const FT:String = "ft";
        private static const FS:String = "fs";
        private static const FO:String = ((USE_NEW_SYNTAX) ? "fo" : "oc");
        private static const D2:String = "2d";
        private static const D3:String = "3d";
        private static const CUBE:String = "cube";
        private static const MIPNEAREST:String = "mipnearest";
        private static const MIPLINEAR:String = "miplinear";
        private static const MIPNONE:String = "mipnone";
        private static const NOMIP:String = "nomip";
        private static const NEAREST:String = "nearest";
        private static const LINEAR:String = "linear";
        private static const CENTROID:String = "centroid";
        private static const SINGLE:String = "single";
        private static const DEPTH:String = "depth";
        private static const REPEAT:String = "repeat";
        private static const WRAP:String = "wrap";
        private static const CLAMP:String = "clamp";

        private var _agalcode:ByteArray = null;
        private var _error:String = "";
        private var debugEnabled:Boolean = false;
        public var verbose:Boolean = false;

        public function AGALMiniAssembler(_arg_1:Boolean=false):void
        {
            this.debugEnabled = _arg_1;
            if (!initialized)
            {
                init();
            };
        }

        private static function init():void
        {
            initialized = true;
            OPMAP[MOV] = new OpCode(MOV, 2, 0, 0);
            OPMAP[ADD] = new OpCode(ADD, 3, 1, 0);
            OPMAP[SUB] = new OpCode(SUB, 3, 2, 0);
            OPMAP[MUL] = new OpCode(MUL, 3, 3, 0);
            OPMAP[DIV] = new OpCode(DIV, 3, 4, 0);
            OPMAP[RCP] = new OpCode(RCP, 2, 5, 0);
            OPMAP[MIN] = new OpCode(MIN, 3, 6, 0);
            OPMAP[MAX] = new OpCode(MAX, 3, 7, 0);
            OPMAP[FRC] = new OpCode(FRC, 2, 8, 0);
            OPMAP[SQT] = new OpCode(SQT, 2, 9, 0);
            OPMAP[RSQ] = new OpCode(RSQ, 2, 10, 0);
            OPMAP[POW] = new OpCode(POW, 3, 11, 0);
            OPMAP[LOG] = new OpCode(LOG, 2, 12, 0);
            OPMAP[EXP] = new OpCode(EXP, 2, 13, 0);
            OPMAP[NRM] = new OpCode(NRM, 2, 14, 0);
            OPMAP[SIN] = new OpCode(SIN, 2, 15, 0);
            OPMAP[COS] = new OpCode(COS, 2, 16, 0);
            OPMAP[CRS] = new OpCode(CRS, 3, 17, 0);
            OPMAP[DP3] = new OpCode(DP3, 3, 18, 0);
            OPMAP[DP4] = new OpCode(DP4, 3, 19, 0);
            OPMAP[ABS] = new OpCode(ABS, 2, 20, 0);
            OPMAP[NEG] = new OpCode(NEG, 2, 21, 0);
            OPMAP[SAT] = new OpCode(SAT, 2, 22, 0);
            OPMAP[M33] = new OpCode(M33, 3, 23, OP_SPECIAL_MATRIX);
            OPMAP[M44] = new OpCode(M44, 3, 24, OP_SPECIAL_MATRIX);
            OPMAP[M34] = new OpCode(M34, 3, 25, OP_SPECIAL_MATRIX);
            OPMAP[IFZ] = new OpCode(IFZ, 1, 26, ((OP_NO_DEST | OP_INC_NEST) | OP_SCALAR));
            OPMAP[INZ] = new OpCode(INZ, 1, 27, ((OP_NO_DEST | OP_INC_NEST) | OP_SCALAR));
            OPMAP[IFE] = new OpCode(IFE, 2, 28, ((OP_NO_DEST | OP_INC_NEST) | OP_SCALAR));
            OPMAP[INE] = new OpCode(INE, 2, 29, ((OP_NO_DEST | OP_INC_NEST) | OP_SCALAR));
            OPMAP[IFG] = new OpCode(IFG, 2, 30, ((OP_NO_DEST | OP_INC_NEST) | OP_SCALAR));
            OPMAP[IFL] = new OpCode(IFL, 2, 31, ((OP_NO_DEST | OP_INC_NEST) | OP_SCALAR));
            OPMAP[IEG] = new OpCode(IEG, 2, 32, ((OP_NO_DEST | OP_INC_NEST) | OP_SCALAR));
            OPMAP[IEL] = new OpCode(IEL, 2, 33, ((OP_NO_DEST | OP_INC_NEST) | OP_SCALAR));
            OPMAP[ELS] = new OpCode(ELS, 0, 34, ((OP_NO_DEST | OP_INC_NEST) | OP_DEC_NEST));
            OPMAP[EIF] = new OpCode(EIF, 0, 35, (OP_NO_DEST | OP_DEC_NEST));
            OPMAP[REP] = new OpCode(REP, 1, 36, ((OP_NO_DEST | OP_INC_NEST) | OP_SCALAR));
            OPMAP[ERP] = new OpCode(ERP, 0, 37, (OP_NO_DEST | OP_DEC_NEST));
            OPMAP[BRK] = new OpCode(BRK, 0, 38, OP_NO_DEST);
            OPMAP[KIL] = new OpCode(KIL, 1, 39, (OP_NO_DEST | OP_FRAG_ONLY));
            OPMAP[TEX] = new OpCode(TEX, 3, 40, (OP_FRAG_ONLY | OP_SPECIAL_TEX));
            OPMAP[SGE] = new OpCode(SGE, 3, 41, 0);
            OPMAP[SLT] = new OpCode(SLT, 3, 42, 0);
            OPMAP[SGN] = new OpCode(SGN, 2, 43, 0);
            REGMAP[VA] = new Register(VA, "vertex attribute", 0, 7, (REG_VERT | REG_READ));
            REGMAP[VC] = new Register(VC, "vertex constant", 1, 127, (REG_VERT | REG_READ));
            REGMAP[VT] = new Register(VT, "vertex temporary", 2, 7, ((REG_VERT | REG_WRITE) | REG_READ));
            REGMAP[VO] = new Register(VO, "vertex output", 3, 0, (REG_VERT | REG_WRITE));
            REGMAP[I] = new Register(I, "varying", 4, 7, (((REG_VERT | REG_FRAG) | REG_READ) | REG_WRITE));
            REGMAP[FC] = new Register(FC, "fragment constant", 1, 27, (REG_FRAG | REG_READ));
            REGMAP[FT] = new Register(FT, "fragment temporary", 2, 7, ((REG_FRAG | REG_WRITE) | REG_READ));
            REGMAP[FS] = new Register(FS, "texture sampler", 5, 7, (REG_FRAG | REG_READ));
            REGMAP[FO] = new Register(FO, "fragment output", 3, 0, (REG_FRAG | REG_WRITE));
            SAMPLEMAP[D2] = new Sampler(D2, SAMPLER_DIM_SHIFT, 0);
            SAMPLEMAP[D3] = new Sampler(D3, SAMPLER_DIM_SHIFT, 2);
            SAMPLEMAP[CUBE] = new Sampler(CUBE, SAMPLER_DIM_SHIFT, 1);
            SAMPLEMAP[MIPNEAREST] = new Sampler(MIPNEAREST, SAMPLER_MIPMAP_SHIFT, 1);
            SAMPLEMAP[MIPLINEAR] = new Sampler(MIPLINEAR, SAMPLER_MIPMAP_SHIFT, 2);
            SAMPLEMAP[MIPNONE] = new Sampler(MIPNONE, SAMPLER_MIPMAP_SHIFT, 0);
            SAMPLEMAP[NOMIP] = new Sampler(NOMIP, SAMPLER_MIPMAP_SHIFT, 0);
            SAMPLEMAP[NEAREST] = new Sampler(NEAREST, SAMPLER_FILTER_SHIFT, 0);
            SAMPLEMAP[LINEAR] = new Sampler(LINEAR, SAMPLER_FILTER_SHIFT, 1);
            SAMPLEMAP[CENTROID] = new Sampler(CENTROID, SAMPLER_SPECIAL_SHIFT, (1 << 0));
            SAMPLEMAP[SINGLE] = new Sampler(SINGLE, SAMPLER_SPECIAL_SHIFT, (1 << 1));
            SAMPLEMAP[DEPTH] = new Sampler(DEPTH, SAMPLER_SPECIAL_SHIFT, (1 << 2));
            SAMPLEMAP[REPEAT] = new Sampler(REPEAT, SAMPLER_REPEAT_SHIFT, 1);
            SAMPLEMAP[WRAP] = new Sampler(WRAP, SAMPLER_REPEAT_SHIFT, 1);
            SAMPLEMAP[CLAMP] = new Sampler(CLAMP, SAMPLER_REPEAT_SHIFT, 0);
        }


        public function get error():String
        {
            return (this._error);
        }

        public function get agalcode():ByteArray
        {
            return (this._agalcode);
        }

        public function assemble(_arg_1:String, _arg_2:String):ByteArray
        {
            var _local_8:int;
            var _local_10:String;
            var _local_11:int;
            var _local_12:int;
            var _local_13:Array;
            var _local_14:Array;
            var _local_15:OpCode;
            var _local_16:Array;
            var _local_17:Boolean;
            var _local_18:uint;
            var _local_19:uint;
            var _local_20:int;
            var _local_21:Boolean;
            var _local_22:Array;
            var _local_23:Array;
            var _local_24:Register;
            var _local_25:Array;
            var _local_26:uint;
            var _local_27:uint;
            var _local_28:Array;
            var _local_29:Boolean;
            var _local_30:Boolean;
            var _local_31:uint;
            var _local_32:uint;
            var _local_33:int;
            var _local_34:uint;
            var _local_35:uint;
            var _local_36:String;
            var _local_37:int;
            var _local_38:Array;
            var _local_39:Register;
            var _local_40:Array;
            var _local_41:Array;
            var _local_42:uint;
            var _local_43:uint;
            var _local_44:Number;
            var _local_45:Sampler;
            var _local_46:String;
            var _local_47:uint;
            var _local_48:uint;
            var _local_49:String;
            var _local_3:uint = getTimer();
            this._agalcode = new ByteArray();
            this._error = "";
            var _local_4:Boolean;
            if (_arg_1 == FRAGMENT)
            {
                _local_4 = true;
            }
            else
            {
                if (_arg_1 != VERTEX)
                {
                    this._error = (((((('ERROR: mode needs to be "' + FRAGMENT) + '" or "') + VERTEX) + '" but is "') + _arg_1) + '".');
                };
            };
            this.agalcode.endian = Endian.LITTLE_ENDIAN;
            this.agalcode.writeByte(160);
            this.agalcode.writeUnsignedInt(1);
            this.agalcode.writeByte(161);
            this.agalcode.writeByte(((_local_4) ? 1 : 0));
            var _local_5:Array = _arg_2.replace(/[\f\n\r\v]+/g, "\n").split("\n");
            var _local_6:int;
            var _local_7:int;
            var _local_9:int = _local_5.length;
            _local_8 = 0;
            while (((_local_8 < _local_9) && (this._error == "")))
            {
                _local_10 = new String(_local_5[_local_8]);
                _local_10 = _local_10.replace(REGEXP_OUTER_SPACES, "");
                _local_11 = _local_10.search("//");
                if (_local_11 != -1)
                {
                    _local_10 = _local_10.slice(0, _local_11);
                };
                _local_12 = _local_10.search(/<.*>/g);
                if (_local_12 != -1)
                {
                    _local_13 = _local_10.slice(_local_12).match(/([\w\.\-\+]+)/gi);
                    _local_10 = _local_10.slice(0, _local_12);
                };
                _local_14 = _local_10.match(/^\w{3}/ig);
                _local_15 = OPMAP[_local_14[0]];
                if (this.debugEnabled)
                {
                    trace(_local_15);
                };
                if (_local_15 == null)
                {
                    if (_local_10.length >= 3)
                    {
                        trace(((("warning: bad line " + _local_8) + ": ") + _local_5[_local_8]));
                    };
                }
                else
                {
                    _local_10 = _local_10.slice((_local_10.search(_local_15.name) + _local_15.name.length));
                    if ((_local_15.flags & OP_DEC_NEST))
                    {
                        if (--_local_6 < 0)
                        {
                            this._error = "error: conditional closes without open.";
                            break;
                        };
                    };
                    if ((_local_15.flags & OP_INC_NEST))
                    {
                        if (++_local_6 > MAX_NESTING)
                        {
                            this._error = (("error: nesting to deep, maximum allowed is " + MAX_NESTING) + ".");
                            break;
                        };
                    };
                    if (((_local_15.flags & OP_FRAG_ONLY) && (!(_local_4))))
                    {
                        this._error = "error: opcode is only allowed in fragment programs.";
                        break;
                    };
                    if (this.verbose)
                    {
                        trace(("emit opcode=" + _local_15));
                    };
                    this.agalcode.writeUnsignedInt(_local_15.emitCode);
                    if (++_local_7 > MAX_OPCODES)
                    {
                        this._error = (("error: too many opcodes. maximum is " + MAX_OPCODES) + ".");
                        break;
                    };
                    if (USE_NEW_SYNTAX)
                    {
                        _local_16 = _local_10.match(/vc\[([vif][acost]?)(\d*)?(\.[xyzwrgba](\+\d{1,3})?)?\](\.[xyzwrgba]{1,4})?|([vif][acost]?)(\d*)?(\.[xyzwrgba]{1,4})?/gi);
                    }
                    else
                    {
                        _local_16 = _local_10.match(/vc\[([vof][actps]?)(\d*)?(\.[xyzwrgba](\+\d{1,3})?)?\](\.[xyzwrgba]{1,4})?|([vof][actps]?)(\d*)?(\.[xyzwrgba]{1,4})?/gi);
                    };
                    if (_local_16.length != _local_15.numRegister)
                    {
                        this._error = (((("error: wrong number of operands. found " + _local_16.length) + " but expected ") + _local_15.numRegister) + ".");
                        break;
                    };
                    _local_17 = false;
                    _local_18 = ((64 + 64) + 32);
                    _local_19 = _local_16.length;
                    _local_20 = 0;
                    while (_local_20 < _local_19)
                    {
                        _local_21 = false;
                        _local_22 = _local_16[_local_20].match(/\[.*\]/ig);
                        if (_local_22.length > 0)
                        {
                            _local_16[_local_20] = _local_16[_local_20].replace(_local_22[0], "0");
                            if (this.verbose)
                            {
                                trace("IS REL");
                            };
                            _local_21 = true;
                        };
                        _local_23 = _local_16[_local_20].match(/^\b[A-Za-z]{1,2}/ig);
                        _local_24 = REGMAP[_local_23[0]];
                        if (this.debugEnabled)
                        {
                            trace(_local_24);
                        };
                        if (_local_24 == null)
                        {
                            this._error = (((("error: could not parse operand " + _local_20) + " (") + _local_16[_local_20]) + ").");
                            _local_17 = true;
                            break;
                        };
                        if (_local_4)
                        {
                            if (!(_local_24.flags & REG_FRAG))
                            {
                                this._error = (((("error: register operand " + _local_20) + " (") + _local_16[_local_20]) + ") only allowed in vertex programs.");
                                _local_17 = true;
                                break;
                            };
                            if (_local_21)
                            {
                                this._error = (((("error: register operand " + _local_20) + " (") + _local_16[_local_20]) + ") relative adressing not allowed in fragment programs.");
                                _local_17 = true;
                                break;
                            };
                        }
                        else
                        {
                            if (!(_local_24.flags & REG_VERT))
                            {
                                this._error = (((("error: register operand " + _local_20) + " (") + _local_16[_local_20]) + ") only allowed in fragment programs.");
                                _local_17 = true;
                                break;
                            };
                        };
                        _local_16[_local_20] = _local_16[_local_20].slice((_local_16[_local_20].search(_local_24.name) + _local_24.name.length));
                        _local_25 = ((_local_21) ? _local_22[0].match(/\d+/) : _local_16[_local_20].match(/\d+/));
                        _local_26 = 0;
                        if (_local_25)
                        {
                            _local_26 = uint(_local_25[0]);
                        };
                        if (_local_24.range < _local_26)
                        {
                            this._error = (((((("error: register operand " + _local_20) + " (") + _local_16[_local_20]) + ") index exceeds limit of ") + (_local_24.range + 1)) + ".");
                            _local_17 = true;
                            break;
                        };
                        _local_27 = 0;
                        _local_28 = _local_16[_local_20].match(/(\.[xyzwrgba]{1,4})/);
                        _local_29 = ((_local_20 == 0) && (!(_local_15.flags & OP_NO_DEST)));
                        _local_30 = ((_local_20 == 2) && (_local_15.flags & OP_SPECIAL_TEX));
                        _local_31 = 0;
                        _local_32 = 0;
                        _local_33 = 0;
                        if (((_local_29) && (_local_21)))
                        {
                            this._error = "error: relative can not be destination";
                            _local_17 = true;
                            break;
                        };
                        if (_local_28)
                        {
                            _local_27 = 0;
                            _local_35 = _local_28[0].length;
                            _local_36 = _local_28[0];
                            _local_37 = 1;
                            while (_local_37 < _local_35)
                            {
                                _local_34 = COMPONENTS[_local_36.charCodeAt(_local_37)];
                                if (_local_34 > 2)
                                {
                                    _local_34 = 3;
                                };
                                if (_local_29)
                                {
                                    _local_27 = (_local_27 | (1 << _local_34));
                                }
                                else
                                {
                                    _local_27 = (_local_27 | (_local_34 << ((_local_37 - 1) << 1)));
                                };
                                _local_37++;
                            };
                            if (!_local_29)
                            {
                                while (_local_37 <= 4)
                                {
                                    _local_27 = (_local_27 | (_local_34 << ((_local_37 - 1) << 1)));
                                    _local_37++;
                                };
                            };
                        }
                        else
                        {
                            _local_27 = ((_local_29) ? 15 : 228);
                        };
                        if (_local_21)
                        {
                            _local_38 = _local_22[0].match(/[A-Za-z]{1,2}/ig);
                            _local_39 = REGMAP[_local_38[0]];
                            if (_local_39 == null)
                            {
                                this._error = "error: bad index register";
                                _local_17 = true;
                                break;
                            };
                            _local_31 = _local_39.emitCode;
                            _local_40 = _local_22[0].match(/(\.[xyzwrgba]{1,1})/);
                            if (_local_40.length == 0)
                            {
                                this._error = "error: bad index register select";
                                _local_17 = true;
                                break;
                            };
                            _local_32 = COMPONENTS[_local_40[0].charCodeAt(1)];
                            if (_local_32 > 2)
                            {
                                _local_32 = 3;
                            };
                            _local_41 = _local_22[0].match(/\+\d{1,3}/ig);
                            if (_local_41.length > 0)
                            {
                                _local_33 = _local_41[0];
                            };
                            if (((_local_33 < 0) || (_local_33 > 0xFF)))
                            {
                                this._error = (("error: index offset " + _local_33) + " out of bounds. [0..255]");
                                _local_17 = true;
                                break;
                            };
                            if (this.verbose)
                            {
                                trace(((((((((((("RELATIVE: type=" + _local_31) + "==") + _local_38[0]) + " sel=") + _local_32) + "==") + _local_40[0]) + " idx=") + _local_26) + " offset=") + _local_33));
                            };
                        };
                        if (this.verbose)
                        {
                            trace((((((("  emit argcode=" + _local_24) + "[") + _local_26) + "][") + _local_27) + "]"));
                        };
                        if (_local_29)
                        {
                            this.agalcode.writeShort(_local_26);
                            this.agalcode.writeByte(_local_27);
                            this.agalcode.writeByte(_local_24.emitCode);
                            _local_18 = (_local_18 - 32);
                        }
                        else
                        {
                            if (_local_30)
                            {
                                if (this.verbose)
                                {
                                    trace("  emit sampler");
                                };
                                _local_42 = 5;
                                _local_43 = _local_13.length;
                                _local_44 = 0;
                                _local_37 = 0;
                                while (_local_37 < _local_43)
                                {
                                    if (this.verbose)
                                    {
                                        trace(("    opt: " + _local_13[_local_37]));
                                    };
                                    _local_45 = SAMPLEMAP[_local_13[_local_37]];
                                    if (_local_45 == null)
                                    {
                                        _local_44 = Number(_local_13[_local_37]);
                                        if (this.verbose)
                                        {
                                            trace(("    bias: " + _local_44));
                                        };
                                    }
                                    else
                                    {
                                        if (_local_45.flag != SAMPLER_SPECIAL_SHIFT)
                                        {
                                            _local_42 = (_local_42 & (~(15 << _local_45.flag)));
                                        };
                                        _local_42 = (_local_42 | (uint(_local_45.mask) << uint(_local_45.flag)));
                                    };
                                    _local_37++;
                                };
                                this.agalcode.writeShort(_local_26);
                                this.agalcode.writeByte(int((_local_44 * 8)));
                                this.agalcode.writeByte(0);
                                this.agalcode.writeUnsignedInt(_local_42);
                                if (this.verbose)
                                {
                                    trace(("    bits: " + (_local_42 - 5)));
                                };
                                _local_18 = (_local_18 - 64);
                            }
                            else
                            {
                                if (_local_20 == 0)
                                {
                                    this.agalcode.writeUnsignedInt(0);
                                    _local_18 = (_local_18 - 32);
                                };
                                this.agalcode.writeShort(_local_26);
                                this.agalcode.writeByte(_local_33);
                                this.agalcode.writeByte(_local_27);
                                this.agalcode.writeByte(_local_24.emitCode);
                                this.agalcode.writeByte(_local_31);
                                this.agalcode.writeShort(((_local_21) ? (_local_32 | (1 << 15)) : 0));
                                _local_18 = (_local_18 - 64);
                            };
                        };
                        _local_20++;
                    };
                    _local_20 = 0;
                    while (_local_20 < _local_18)
                    {
                        this.agalcode.writeByte(0);
                        _local_20 = (_local_20 + 8);
                    };
                    if (_local_17) break;
                };
                _local_8++;
            };
            if (this._error != "")
            {
                this._error = (this._error + ((("\n  at line " + _local_8) + " ") + _local_5[_local_8]));
                this.agalcode.length = 0;
                trace(this._error);
            };
            if (this.debugEnabled)
            {
                _local_46 = "generated bytecode:";
                _local_47 = this.agalcode.length;
                _local_48 = 0;
                while (_local_48 < _local_47)
                {
                    if (!(_local_48 % 16))
                    {
                        _local_46 = (_local_46 + "\n");
                    };
                    if (!(_local_48 % 4))
                    {
                        _local_46 = (_local_46 + " ");
                    };
                    _local_49 = this.agalcode[_local_48].toString(16);
                    if (_local_49.length < 2)
                    {
                        _local_49 = ("0" + _local_49);
                    };
                    _local_46 = (_local_46 + _local_49);
                    _local_48++;
                };
                trace(_local_46);
            };
            if (this.verbose)
            {
                trace((("AGALMiniAssembler.assemble time: " + ((getTimer() - _local_3) / 1000)) + "s"));
            };
            return (this.agalcode);
        }


    }
}//package com.adobe.utils

class OpCode 
{

    private var _emitCode:uint;
    private var _flags:uint;
    private var _name:String;
    private var _numRegister:uint;

    public function OpCode(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint)
    {
        this._name = _arg_1;
        this._numRegister = _arg_2;
        this._emitCode = _arg_3;
        this._flags = _arg_4;
    }

    public function get emitCode():uint
    {
        return (this._emitCode);
    }

    public function get flags():uint
    {
        return (this._flags);
    }

    public function get name():String
    {
        return (this._name);
    }

    public function get numRegister():uint
    {
        return (this._numRegister);
    }

    public function toString():String
    {
        return (((((((('[OpCode name="' + this._name) + '", numRegister=') + this._numRegister) + ", emitCode=") + this._emitCode) + ", flags=") + this._flags) + "]");
    }


}

class Register 
{

    private var _emitCode:uint;
    private var _name:String;
    private var _longName:String;
    private var _flags:uint;
    private var _range:uint;

    public function Register(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:uint, _arg_5:uint)
    {
        this._name = _arg_1;
        this._longName = _arg_2;
        this._emitCode = _arg_3;
        this._range = _arg_4;
        this._flags = _arg_5;
    }

    public function get emitCode():uint
    {
        return (this._emitCode);
    }

    public function get longName():String
    {
        return (this._longName);
    }

    public function get name():String
    {
        return (this._name);
    }

    public function get flags():uint
    {
        return (this._flags);
    }

    public function get range():uint
    {
        return (this._range);
    }

    public function toString():String
    {
        return (((((((((('[Register name="' + this._name) + '", longName="') + this._longName) + '", emitCode=') + this._emitCode) + ", range=") + this._range) + ", flags=") + this._flags) + "]");
    }


}

class Sampler 
{

    private var _flag:uint;
    private var _mask:uint;
    private var _name:String;

    public function Sampler(_arg_1:String, _arg_2:uint, _arg_3:uint)
    {
        this._name = _arg_1;
        this._flag = _arg_2;
        this._mask = _arg_3;
    }

    public function get flag():uint
    {
        return (this._flag);
    }

    public function get mask():uint
    {
        return (this._mask);
    }

    public function get name():String
    {
        return (this._name);
    }

    public function toString():String
    {
        return (((((('[Sampler name="' + this._name) + '", flag="') + this._flag) + '", mask=') + this.mask) + "]");
    }


}


