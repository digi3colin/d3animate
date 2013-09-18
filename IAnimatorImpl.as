package com.fastframework.module.d3animate{
	import flash.display.DisplayObject;
	/**
	 * @author digi3colin
	 */
	public interface IAnimatorImpl {
		function getProp(view:DisplayObject,prop:String):Number;
		function setProp(view:DisplayObject,prop:String,val:Number):void;
	}
}
