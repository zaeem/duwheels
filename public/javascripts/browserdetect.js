if(typeof(AC)==="undefined"){AC={}}AC.Detector={getAgent:function(){return navigator.userAgent.toLowerCase()
},isMac:function(b){var a=b||this.getAgent();return !!a.match(/mac/i)},isSnowLeopard:function(b){var a=b||this.getAgent();
return !!a.match(/mac os x 10_6/i)},isWin:function(b){var a=b||this.getAgent();
return !!a.match(/win/i)},isWin2k:function(b){var a=b||this.getAgent();return this.isWin(a)&&(a.match(/nt\s*5/i))
},isWinVista:function(b){var a=b||this.getAgent();return this.isWin(a)&&(a.match(/nt\s*6\.0([0-9]{0,2})?/i))
},isWebKit:function(b){if(this._isWebKit===undefined){var a=b||this.getAgent();
this._isWebKit=!!a.match(/AppleWebKit/i);this.isWebKit=function(){return this._isWebKit
}}return this._isWebKit},isSafari2:function(c){if(this._isSafari2===undefined){if(!this.isWebKit()){this._isSafari2=false
}else{var b=navigator.userAgent.toLowerCase();var a=parseInt(parseFloat(b.substring(b.lastIndexOf("safari/")+7)),10);
this._isSafari2=(a>=419)}this.isSafari2=function(){return this._isSafari2}}return this._isSafari2
},isChrome:function(b){if(this._isChrome===undefined){var a=b||this.getAgent();
this._isChrome=!!a.match(/Chrome/i);this.isChrome=function(){return this._isChrome
}}return this._isChrome},isOpera:function(b){var a=b||this.getAgent();return !!a.match(/opera/i)
},isIE:function(b){var a=b||this.getAgent();return !!a.match(/msie/i)},isIEStrict:function(b){var a=b||this.getAgent();
return a.match(/msie/i)&&!this.isOpera(a)},isIE8:function(c){var b=c||this.getAgent();
var a=b.match(/msie\D*([\.\d]*)/i);if(a&&a[1]){version=a[1]}return +version>=8},isFirefox:function(b){var a=b||this.getAgent();
return !!a.match(/firefox/i)},isiPhone:function(b){var a=b||this.getAgent();return this.isMobile(a)
},iPhoneOSVersion:function(d){var c=d||this.getAgent(),a=this.isMobile(c),e,f,b;
if(a){var e=c.match(/.*CPU ([\w|\s]+) like/i);if(e&&e[1]){f=e[1].split(" ");b=f[2].split("_");
return b}else{return[1]}}else{return null}},isiPad:function(b){var a=b||this.getAgent();
return !!(this.isWebKit(a)&&a.match(/ipad/i))},isMobile:function(b){var a=b||this.getAgent();
return this.isWebKit(a)&&(a.match(/Mobile/i)&&!this.isiPad(a))},isiTunesOK:function(b){var a=b||this.getAgent();
return this.isMac(a)||this.isWin2k(a)},_isQTInstalled:undefined,isQTInstalled:function(){if(this._isQTInstalled===undefined){var a=false;
if(navigator.plugins&&navigator.plugins.length){for(var b=0;b<navigator.plugins.length;
b++){var c=navigator.plugins[b];if(c.name.indexOf("QuickTime")>-1){a=true}}}else{if(typeof(execScript)!="undefined"){qtObj=false;
execScript('on error resume next: qtObj = IsObject(CreateObject("QuickTimeCheckObject.QuickTimeCheck.1"))',"VBScript");
a=qtObj}}this._isQTInstalled=a}return this._isQTInstalled},getQTVersion:function(){var a="0";
if(navigator.plugins&&navigator.plugins.length){for(var c=0;c<navigator.plugins.length;
c++){var d=navigator.plugins[c];var b=d.name.match(/quicktime\D*([\.\d]*)/i);if(b&&b[1]){a=b[1]
}}}else{if(typeof(execScript)!="undefined"){ieQTVersion=null;execScript('on error resume next: ieQTVersion = CreateObject("QuickTimeCheckObject.QuickTimeCheck.1").QuickTimeVersion',"VBScript");
if(ieQTVersion){a=ieQTVersion.toString(16);a=[a.charAt(0),a.charAt(1),a.charAt(2)].join(".")
}}}return a},isQTCompatible:function(c,e){function b(g,i){var f=parseInt(g[0],10);
if(isNaN(f)){f=0}var h=parseInt(i[0],10);if(isNaN(h)){h=0}if(f===h){if(g.length>1){return b(g.slice(1),i.slice(1))
}else{return true}}else{if(f<h){return true}else{return false}}}var d=c.split(/\./);
var a=e?e.split(/\./):this.getQTVersion().split(/\./);return b(d,a)},isValidQTAvailable:function(a){return this.isQTInstalled()&&this.isQTCompatible(a)
},isSBVDPAvailable:function(a){return false},isCSSAvailable:function(b){try{var a=document.createElement("div").style;
b=b.toLowerCase();a.setProperty("-webkit-"+b,"inherit",null);a.setProperty("-moz-"+b,"inherit",null);
a.setProperty("-o-"+b,"inherit",null);a.setProperty(b,"inherit",null);return(a.getPropertyValue("-webkit-"+b)=="inherit"||a.getPropertyValue("-moz-"+b)=="inherit"||a.getPropertyValue("-o-"+b)=="inherit"||a.getPropertyValue(b)=="inherit")
}catch(c){return false}},_supportsThreeD:false,supportsThreeD:function(){try{this._supportsThreeD=false;
if("styleMedia" in window){this._supportsThreeD=window.styleMedia.matchMedium("(-webkit-transform-3d)")
}else{if("media" in window){this._supportsThreeD=window.media.matchMedium("(-webkit-transform-3d)")
}}if(!this._supportsThreeD){if(!document.getElementById("supportsThreeDStyle")){var a=document.createElement("style");
a.id="supportsThreeDStyle";a.textContent="@media (transform-3d),(-o-transform-3d),(-moz-transform-3d),(-ms-transform-3d),(-webkit-transform-3d) { #supportsThreeD { height:3px } }";
document.querySelector("head").appendChild(a)}if(!(div=document.querySelector("#supportsThreeD"))){div=document.createElement("div");
div.id="supportsThreeD";document.body.appendChild(div)}this._supportsThreeD=(div.offsetHeight===3)
}return this._supportsThreeD}catch(b){return false}},_hasLocalStorage:null,hasLocalStorage:function(){if(this._hasLocalStorage!==null){return this._hasLocalStorage
}try{if(typeof localStorage!=="undefined"&&"setItem" in localStorage){localStorage.setItem("ac_browser_detect","test");
this._hasLocalStorage=true;localStorage.removeItem("ac_browser_detect","test")}else{this._hasLocalStorage=false
}}catch(a){this._hasLocalStorage=false}return this._hasLocalStorage},_hasSessionStorage:null,hasSessionStorage:function(){if(this._hasSessionStorage!==null){return this._hasSessionStorage
}try{if(typeof sessionStorage!=="undefined"&&"setItem" in sessionStorage){sessionStorage.setItem("ac_browser_detect","test");
this._hasSessionStorage=true;sessionStorage.removeItem("ac_browser_detect","test")
}else{this._hasSessionStorage=false}}catch(a){this._hasSessionStorage=false}return this._hasSessionStorage
},_hasCookies:null,hasCookies:function(){if(this._hasCookies!==null){return this._hasCookies
}this._hasCookies="cookie" in document&&!!navigator.cookieEnabled?true:false;return this._hasCookies
}};