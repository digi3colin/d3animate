package com.fastframework.module.d3animate{
	import flash.display.DisplayObject;

	/**
	 * @author digi3colin
	 */
	public class AnimatorScale implements IAnimatorImpl {
		public function getProp(view : DisplayObject, prop : String) : Number {
			return view.scaleX;
		}

		public function setProp(view : DisplayObject, prop : String, val : Number) : void {
			view.scaleX = val;
			view.scaleY = val;
		}
	}
}
