package extension.webview;

#if android
import haxe.Json;
import lime.system.JNI;
#end
	
class WebView
{
	public static var onClose:Void -> Void = null;
	public static var onComplete:Void -> Void = null;// for videos only
	public static var onURLChanging:String -> Void = null;

	public static function open(url:String = null, ?urlWhitelist:Array<String>, ?urlBlacklist:Array<String>, ?hideui:Bool = true):Void 
	{
		#if android
		_callbackFunc(new CallBack());

		if(urlWhitelist!=null) 
			urlWhitelist.push(url);
		if (urlWhitelist==null)
			urlWhitelist = [];
		if (urlBlacklist==null)
			urlBlacklist = [];

		var obj = {
			url:url, 
			urlWhitelist:urlWhitelist, 
			urlBlacklist:urlBlacklist, 
			hideui:hideui
		}

		_open(Json.stringify(obj));
		#end
	}

	public static function openHtml(html:String, ?hideui:Bool = true):Void 
	{
		#if android
		_callbackFunc(new CallBack());
		var obj = {
			html:html, 
			hideui:hideui
		}
		_openHtml(Json.stringify(obj));
		#end
	}

	public static function playVideo(videoPath:String = null, ?hideui:Bool = true):Void 
	{
		#if android
		open(videoPath, null, ['http://exitme/'], hideui);
		onClose = function(){
			if (onComplete != null){
				onComplete();
			}
		}
		onURLChanging = function(url:String){
			if (url == 'http://exitme/'){
				if (onComplete != null){
					onComplete();
				}
			}
		}
		#end
	}

	#if android
	private static var _open = JNI.createStaticMethod("extensions/webview/WebViewExtension", "open", "(Ljava/lang/String;)V");
	private static var _openHtml = JNI.createStaticMethod("extensions/webview/WebViewExtension", "openHtml", "(Ljava/lang/String;)V");	
	private static var _callbackFunc = JNI.createStaticMethod("extensions/webview/WebViewExtension", "setCallback", "(Lorg/haxe/lime/HaxeObject;)V");
	#end
}

class CallBack {

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
