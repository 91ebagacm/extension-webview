package extension.webview;

import haxe.Json;
import lime.system.JNI;
	
class WebView  
{
	private static var initialized :Bool = false;
	private static var _open:String -> Void = null;
	public static var onClose:Void->Void=null;
	public static var onURLChanging:String->Void=null;

	public static function open(url:String = null, floating:Bool = false, ?urlWhitelist:Array<String>, ?urlBlacklist:Array<String>, ?useWideViewPort:Bool = false, ?mediaPlaybackRequiresUserGesture:Bool = false):Void 
        {
                #if android
		init();
		if(urlWhitelist!=null) 
                        urlWhitelist.push(url);
		if (urlWhitelist==null) {
			urlWhitelist = [];
		}
		if (urlBlacklist==null) {
			urlBlacklist = [];
		}
		var obj = {
			url : url,
			floating : floating,
			urlWhitelist : urlWhitelist,
			urlBlacklist : urlBlacklist,
			useWideViewPort : useWideViewPort,
			mediaPlaybackRequiresUserGesture : mediaPlaybackRequiresUserGesture
		}
		_open(Json.stringify(obj));
                #end
	}

	private static function init():Void 
        {
                #if android
		if(initialized == true) 
                        return;
		initialized = true;
		try {
		        _open = JNI.createStaticMethod("extensions/webview/WebViewExtension", "open", "(Ljava/lang/String;)V");
			var _callbackFunc = JNI.createStaticMethod("extensions/webview/WebViewExtension", "setCallback", "(Lorg/haxe/lime/HaxeObject;)V");
			_callbackFunc(new AndroidCallbackHelper());
		} catch(e:Dynamic) {
			trace("INIT Exception: "+e);
		}
                #end
	}	
}
