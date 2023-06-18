


//de.nulldesign.nd2d.display.ParticleSystem2D

package de.nulldesign.nd2d.display
{
    import __AS3__.vec.Vector;
    import de.nulldesign.nd2d.geom.Face;
    import de.nulldesign.nd2d.materials.ParticleSystemMaterial;
    import de.nulldesign.nd2d.utils.ParticleSystemPreset;
    import flash.geom.Point;
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import flash.utils.getTimer;
    import de.nulldesign.nd2d.utils.NumberUtil;
    import de.nulldesign.nd2d.utils.VectorUtil;
    import de.nulldesign.nd2d.utils.ColorUtil;
    import flash.events.Event;
    import flash.display3D.Context3D;
    import __AS3__.vec.*;

    public class ParticleSystem2D extends Node2D 
    {

        protected var particles:Vector.<Particle>;
        protected var activeParticles:uint;
        protected var faceList:Vector.<Face>;
        protected var material:ParticleSystemMaterial;
        protected var texW:Number;
        protected var texH:Number;
        protected var maxCapacity:uint;
        protected var preset:ParticleSystemPreset;
        public var gravity:Point = new Point(0, 0);
        protected var currentTime:Number;
        protected var startTime:Number;
        protected var burst:Boolean;
        protected var burstDone:Boolean = false;
        protected var lastParticleDeathTime:Number = 0;

        public function ParticleSystem2D(_arg_1:Texture2D, _arg_2:uint, _arg_3:ParticleSystemPreset, _arg_4:Boolean=false)
        {
            this.preset = _arg_3;
            this.burst = _arg_4;
            this.init(_arg_1, _arg_2);
        }

        override public function get numTris():uint
        {
            return (this.activeParticles * 2);
        }

        override public function get drawCalls():uint
        {
            return (this.material.drawCalls);
        }

        public function reset():void
        {
            this.startTime = getTimer();
            this.currentTime = 0;
            this.activeParticles = 1;
            this.burstDone = false;
        }

        protected function init(_arg_1:Texture2D, _arg_2:uint):void
        {
            var _local_3:Texture2D;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            this.maxCapacity = _arg_2;
            _local_3 = _arg_1;
            this.material = new ParticleSystemMaterial(_local_3, this.burst);
            this.texW = (_local_3.textureWidth / 2);
            this.texH = (_local_3.textureHeight / 2);
            this.particles = new Vector.<Particle>(_arg_2, true);
            this.faceList = new Vector.<Face>((_arg_2 * 2), true);
            var _local_4:int;
            this.startTime = getTimer();
            this.currentTime = 0;
            var _local_5:int;
            while (_local_5 < _arg_2)
            {
                this.particles[_local_5] = new Particle();
                var _local_10:* = _local_4++;
                this.faceList[_local_10] = new Face(this.particles[_local_5].v1, this.particles[_local_5].v2, this.particles[_local_5].v3, this.particles[_local_5].uv1, this.particles[_local_5].uv2, this.particles[_local_5].uv3);
                var _local_11:* = _local_4++;
                this.faceList[_local_11] = new Face(this.particles[_local_5].v1, this.particles[_local_5].v3, this.particles[_local_5].v4, this.particles[_local_5].uv1, this.particles[_local_5].uv3, this.particles[_local_5].uv4);
                _local_6 = NumberUtil.rndMinMax(VectorUtil.deg2rad(this.preset.minEmitAngle), VectorUtil.deg2rad(this.preset.maxEmitAngle));
                _local_7 = NumberUtil.rndMinMax(this.preset.minSpeed, this.preset.maxSpeed);
                _local_8 = ColorUtil.mixColors(this.preset.startColor, this.preset.startColorVariance, NumberUtil.rnd0_1());
                _local_9 = ColorUtil.mixColors(this.preset.endColor, this.preset.endColorVariance, NumberUtil.rnd0_1());
                this.initParticle(NumberUtil.rndMinMax(this.preset.minStartPosition.x, this.preset.maxStartPosition.x), NumberUtil.rndMinMax(this.preset.minStartPosition.y, this.preset.maxStartPosition.y), (Math.sin(_local_6) * _local_7), (Math.cos(_local_6) * _local_7), _local_8, _local_9, this.preset.startAlpha, this.preset.endAlpha, NumberUtil.rndMinMax(this.preset.minStartSize, this.preset.maxStartSize), NumberUtil.rndMinMax(this.preset.minEndSize, this.preset.maxEndSize), NumberUtil.rndMinMax(this.preset.minLife, this.preset.maxLife), (this.preset.spawnDelay * _local_5));
                _local_5++;
            };
            this.activeParticles = 1;
            if (this.preset.spawnDelay == 0)
            {
                this.activeParticles = _arg_2;
            };
        }

        protected function initParticle(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number, _arg_9:Number, _arg_10:Number, _arg_11:Number, _arg_12:Number):void
        {
            var _local_13:Particle = this.particles[this.activeParticles];
            _local_13.v1.x = -(this.texW);
            _local_13.v1.y = -(this.texH);
            _local_13.v2.x = this.texW;
            _local_13.v2.y = -(this.texH);
            _local_13.v3.x = this.texW;
            _local_13.v3.y = this.texH;
            _local_13.v4.x = -(this.texW);
            _local_13.v4.y = this.texH;
            _local_13.v1.startColorR = (_local_13.v2.startColorR = (_local_13.v3.startColorR = (_local_13.v4.startColorR = ColorUtil.r(_arg_5))));
            _local_13.v1.startColorG = (_local_13.v2.startColorG = (_local_13.v3.startColorG = (_local_13.v4.startColorG = ColorUtil.g(_arg_5))));
            _local_13.v1.startColorB = (_local_13.v2.startColorB = (_local_13.v3.startColorB = (_local_13.v4.startColorB = ColorUtil.b(_arg_5))));
            _local_13.v1.startAlpha = (_local_13.v2.startAlpha = (_local_13.v3.startAlpha = (_local_13.v4.startAlpha = _arg_7)));
            _local_13.v1.startX = (_local_13.v2.startX = (_local_13.v3.startX = (_local_13.v4.startX = _arg_1)));
            _local_13.v1.startY = (_local_13.v2.startY = (_local_13.v3.startY = (_local_13.v4.startY = _arg_2)));
            _local_13.v1.startSize = (_local_13.v2.startSize = (_local_13.v3.startSize = (_local_13.v4.startSize = _arg_9)));
            _local_13.v1.startTime = (_local_13.v2.startTime = (_local_13.v3.startTime = (_local_13.v4.startTime = _arg_12)));
            _local_13.v1.endColorR = (_local_13.v2.endColorR = (_local_13.v3.endColorR = (_local_13.v4.endColorR = ColorUtil.r(_arg_6))));
            _local_13.v1.endColorG = (_local_13.v2.endColorG = (_local_13.v3.endColorG = (_local_13.v4.endColorG = ColorUtil.g(_arg_6))));
            _local_13.v1.endColorB = (_local_13.v2.endColorB = (_local_13.v3.endColorB = (_local_13.v4.endColorB = ColorUtil.b(_arg_6))));
            _local_13.v1.endAlpha = (_local_13.v2.endAlpha = (_local_13.v3.endAlpha = (_local_13.v4.endAlpha = _arg_8)));
            _local_13.v1.vx = (_local_13.v2.vx = (_local_13.v3.vx = (_local_13.v4.vx = _arg_3)));
            _local_13.v1.vy = (_local_13.v2.vy = (_local_13.v3.vy = (_local_13.v4.vy = _arg_4)));
            _local_13.v1.life = (_local_13.v2.life = (_local_13.v3.life = (_local_13.v4.life = _arg_11)));
            _local_13.v1.endSize = (_local_13.v2.endSize = (_local_13.v3.endSize = (_local_13.v4.endSize = _arg_10)));
            this.activeParticles++;
            this.lastParticleDeathTime = Math.max((_arg_12 + _arg_11), this.lastParticleDeathTime);
        }

        override protected function step(_arg_1:Number):void
        {
            this.currentTime = (getTimer() - this.startTime);
            if (this.activeParticles < this.maxCapacity)
            {
                this.activeParticles = Math.min(Math.ceil((this.currentTime / this.preset.spawnDelay)), this.maxCapacity);
            };
            if ((((this.burst) && (!(this.burstDone))) && (this.currentTime > this.lastParticleDeathTime)))
            {
                this.burstDone = true;
                dispatchEvent(new Event(Event.COMPLETE));
            };
        }

        override public function handleDeviceLoss():void
        {
            super.handleDeviceLoss();
            this.material.handleDeviceLoss();
        }

        override protected function draw(_arg_1:Context3D, _arg_2:Camera2D):void
        {
            if (this.burstDone)
            {
                return;
            };
            this.material.blendMode = blendMode;
            this.material.modelMatrix = worldModelMatrix;
            this.material.viewProjectionMatrix = _arg_2.getViewProjectionMatrix(false);
            this.material.currentTime = this.currentTime;
            this.material.gravity = this.gravity;
            this.material.render(_arg_1, this.faceList, 0, (this.activeParticles * 2));
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

import de.nulldesign.nd2d.geom.ParticleVertex;
import de.nulldesign.nd2d.geom.UV;

class Particle 
{

    public var v1:ParticleVertex = new ParticleVertex(-1, -1, 0);
    public var v2:ParticleVertex = new ParticleVertex(1, -1, 0);
    public var v3:ParticleVertex = new ParticleVertex(1, 1, 0);
    public var v4:ParticleVertex = new ParticleVertex(-1, 1, 0);
    public var uv1:UV = new UV(0, 0);
    public var uv2:UV = new UV(1, 0);
    public var uv3:UV = new UV(1, 1);
    public var uv4:UV = new UV(0, 1);


}


