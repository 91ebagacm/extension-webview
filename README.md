# extension-webview

A Haxe extension for Displaying Java WebViews on Android.

### Main Features

* Whitelist validation (the webview will close if the user goes to a non-whitelisted URL).
* Blacklist validation (the webview will close if the user goes to a blacklisted URL).
* onClose event.
* onURLChanging events for controling the WebView.
* On non-supported platforms, this extensions has no effect (makes nothing).

### Simple use Example

```haxe
// This example show a simple sharing of a text using the Share Class.

import extension.webview.WebView;

WebView.onClose = function(){
        trace("WebView has been closed!");
}
WebView.onURLChanging = function(url:String){
        trace("WebView is about to open: " + url);
}
WebView.open('http://www.puralax.com/help');
		
// Example using whitelist:
// WebView.open('http://www.puralax.com/help',['(http|https)://www.puralax.com/help(.*)','http://www.sempaigames.com/(.*)']);
		
// Example using blacklist:
// WebView.open('http://www.puralax.com/help',null,['(http|https)://(.*)facebook.com(.*)']);

```

### How to Install

```cmd
haxelib git extension-webview https://github.com/jigsaw-4277821/extension-webview.git
```
