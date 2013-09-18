package com.fastframework.module.d3animate {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getTimer;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Animator extends FASTEventDispatcher{
		public static var EVENT_START:String = "EVENT_START";
		public static var EVENT_END:String = "EVENT_END";

		public static var EASE_LINEAR:Vector.<Number> 	= new <Number>[0.008,0.016,0.024,0.032,0.04,0.048,0.055,0.063,0.071,0.079,0.087,0.095,0.103,0.11,0.118,0.126,0.134,0.142,0.15,0.158,0.166,0.173,0.181,0.189,0.197,0.205,0.213,0.221,0.229,0.236,0.244,0.252,0.26,0.268,0.276,0.284,0.292,0.299,0.307,0.315,0.323,0.331,0.339,0.347,0.355,0.362,0.37,0.378,0.386,0.394,0.402,0.41,0.418,0.425,0.433,0.441,0.449,0.457,0.465,0.473,0.481,0.488,0.496,0.504,0.512,0.52,0.528,0.536,0.544,0.551,0.559,0.567,0.575,0.583,0.591,0.599,0.607,0.614,0.622,0.63,0.638,0.646,0.653,0.662,0.67,0.677,0.685,0.693,0.701,0.709,0.717,0.725,0.733,0.74,0.748,0.756,0.764,0.772,0.78,0.788,0.796,0.803,0.811,0.819,0.827,0.835,0.843,0.851,0.859,0.866,0.874,0.882,0.89,0.898,0.906,0.914,0.922,0.929,0.937,0.945,0.953,0.961,0.969,0.977,0.985,0.992,1,1];
		public static var EASE_OUT:Vector.<Number> 		= new <Number>[0.1,0.166,0.219,0.265,0.305,0.341,0.374,0.405,0.433,0.46,0.485,0.508,0.531,0.552,0.572,0.591,0.609,0.626,0.642,0.658,0.673,0.687,0.701,0.714,0.726,0.738,0.749,0.76,0.77,0.78,0.79,0.798,0.807,0.815,0.822,0.83,0.836,0.843,0.849,0.854,0.86,0.865,0.869,0.874,0.878,0.882,0.885,0.889,0.893,0.896,0.899,0.902,0.905,0.908,0.911,0.914,0.916,0.919,0.921,0.924,0.926,0.929,0.931,0.933,0.935,0.937,0.939,0.941,0.943,0.945,0.947,0.949,0.95,0.952,0.954,0.956,0.957,0.959,0.96,0.962,0.963,0.965,0.966,0.968,0.969,0.97,0.971,0.973,0.974,0.975,0.976,0.978,0.979,0.98,0.981,0.982,0.983,0.984,0.985,0.986,0.987,0.988,0.988,0.989,0.99,0.991,0.992,0.992,0.993,0.994,0.994,0.995,0.996,0.996,0.997,0.997,0.998,0.998,0.999,0.999,0.999,1,1,1,1,1,1,1];
		public static var EASE_IN_OUT:Vector.<Number> 	= new <Number>[0.002,0.004,0.006,0.009,0.012,0.015,0.018,0.021,0.025,0.028,0.032,0.036,0.04,0.045,0.049,0.054,0.059,0.064,0.069,0.074,0.08,0.085,0.091,0.097,0.104,0.11,0.117,0.123,0.13,0.138,0.145,0.153,0.16,0.168,0.177,0.185,0.194,0.203,0.212,0.222,0.231,0.242,0.252,0.263,0.274,0.285,0.296,0.308,0.32,0.333,0.347,0.36,0.374,0.388,0.403,0.419,0.435,0.451,0.468,0.486,0.504,0.523,0.542,0.56,0.577,0.594,0.611,0.626,0.642,0.657,0.671,0.685,0.699,0.712,0.724,0.737,0.749,0.76,0.772,0.782,0.793,0.803,0.813,0.822,0.832,0.84,0.849,0.857,0.865,0.873,0.881,0.888,0.895,0.901,0.908,0.914,0.92,0.925,0.931,0.936,0.941,0.946,0.95,0.954,0.959,0.962,0.966,0.97,0.973,0.976,0.979,0.981,0.984,0.986,0.988,0.99,0.992,0.994,0.995,0.996,0.997,0.998,0.999,1,1,1,1,1];

		private var view:DisplayObject;
		private var st:Number;
		private var sv:Number;
		private var dv:Number;

		private var elapseMS : Number;
		private var property : String;
		
		public var ease:Vector.<Number>;
		public var imp:IAnimatorImpl;

		public function Animator(view : DisplayObject,property:String,elapseMS:Number=2000) {
			this.view = view;
			this.elapseMS = elapseMS;
			this.property = property;
			this.ease = Animator.EASE_OUT;
			this.imp = new AnimatorDefault();
		}

		private function getProp():Number{
			return imp.getProp(view, property);
		}

		private function loop(e:Event):void{
			var dt:Number = getTimer()-st;
			//dt>2
			if(dt>elapseMS)dt = elapseMS;
	
			//nPos=rPos+fDeltaPos*interpolate
			var interpolate:Number = ease[Math.round((dt/elapseMS)*127)];
			imp.setProp(view, property, (sv + dv*interpolate));
			
			if(dt>=elapseMS)skip();
		}
	
		public function skip():Animator{
			imp.setProp(view, property, (sv + dv));

			dispatchEvent(new Event(Animator.EVENT_END));
			view.removeEventListener(Event.ENTER_FRAME, loop);

			if(view.alpha==0){
				view.visible = false;
			}
			return this;
		}

		public function fromTo(val:Number,toVal:Number):Animator{
			imp.setProp(view, property, (val));
			to(toVal);
			return this;
		}

		public function to(value:Number):Animator{
			if(value>0 && view.visible==false){
				view.visible = true;
			}

			st = getTimer();
			sv = getProp();
			dv = value-sv;
			dispatchEvent(new Event(Animator.EVENT_START));
			if(dv==0)return this;
			if(view.stage==null){
				skip();
				return this;
			}

			view.removeEventListener(Event.ENTER_FRAME, loop);
			view.addEventListener(Event.ENTER_FRAME, loop,false,0,true);
			return this;
		}
	}
}
