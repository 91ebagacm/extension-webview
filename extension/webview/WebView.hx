package extension.webview;

#if android
import haxe.Json;
import lime.system.JNI;
#end
	
class WebView  
{
	public static var onClose:Void->Void=null;
	public static var onURLChanging:String->Void=null;

	public static function open(url:String = null, floating:Bool = false, ?urlWhitelist:Array<String>, ?urlBlacklist:Array<String>, ?useWideViewPort:Bool = false, ?mediaPlaybackRequiresUserGesture:Bool = false):Void {
                #if android
		_callbackFunc(new AndroidCallbackHelper());

		if(urlWhitelist!=null) 
                        urlWhitelist.push(url);
		if (urlWhitelist==null)
			urlWhitelist = [];
		if (urlBlacklist==null)
			urlBlacklist = [];

		var obj = {url:url, floating:floating, urlWhitelist:urlWhitelist, urlBlacklist:urlBlacklist, useWideViewPort:useWideViewPort, mediaPlaybackRequiresUserGesture:mediaPlaybackRequiresUserGesture}
		_open(Json.stringify(obj));
                #end
	}

        #if android
        private static var _open = JNI.createStaticMethod("extensions/webview/WebViewExtension", "open", "(Ljava/lang/String;)V");	
        private static var _callbackFunc = JNI.createStaticMethod("extensions/webview/WebViewExtension", "setCallback", "(Lorg/haxe/lime/HaxeObject;)V");
        #end
}

class AndroidCallbackHelper {

	public function new() {

	}

	public function onClose() {
		if (WebView.onClose != null) {
			WebView.onClose();
		}
	}

	public function onURLChanging(url:String) {      
		if (WebView.onURLChanging != null) {
			WebView.onURLChanging(url);
		}        
	}
}
