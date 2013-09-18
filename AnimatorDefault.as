package com.fastframework.module.d3animate{
	import flash.display.DisplayObject;

	/**
	 * @author digi3colin
	 */
	public class AnimatorDefault implements IAnimatorImpl {
		public function getProp(view : DisplayObject, prop : String) : Number {
			return view[prop];
		}

		public function setProp(view : DisplayObject, prop : String, val : Number) : void {
			view[prop] = val;
		}
	}
}
