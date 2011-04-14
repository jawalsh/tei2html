/* hiding elements */
function swap(shell, show) {
	document.getElementById(shell).innerHTML=document.getElementById(show).innerHTML;
}

function showDocInfo () {
  swap('docInfoShell','docInfoHidden');
  swap('docInfoLink','hide');
}
            
function hideDocInfo () {
  swap('docInfoShell','empty');
  swap('docInfoLink','show');
}

/* open in new window links */
function externalLinks() { 
 if (!document.getElementsByTagName) return; 
 var anchors = document.getElementsByTagName("a"); 
 for (var i=0; i<anchors.length; i++) { 
   var anchor = anchors[i]; 
   if (anchor.getAttribute("href") && 
       anchor.getAttribute("rel") == "external") 
     anchor.target = "_blank"; 
 } 
} 

function init () {
  externalLinks();
}

/* For search box default values */
function clearDefaultValue ( object, defaultText ) {
	if( object.value == defaultText ) {
	object.value = '';
	}
}

function addDefaultValue ( object, defaultText ) {
	if( object.value == '' ) {
		object.value = defaultText;
	}
}

function loadPage(url) {
window.location.href = url;
}

function parseURI(string, overwrite){
    if(!string || !string.length){
        return {};
    }
    var obj = {};
    var pairs = string.split(';');
    var pair, name, value;
    var lsregexp = /\+/g;
    for(var i = 0, len = pairs.length; i < len; i++){
        pair = pairs[i].split('=');
        name = unescape(pair[0]);
        value = unescape(pair[1]).replace(lsregexp, " ");
        if(overwrite !== true){
            if(typeof obj[name] == "undefined"){
                obj[name] = value;
            }else if(typeof obj[name] == "string"){
                obj[name] = [obj[name]];
                obj[name].push(value);
            }else{
                obj[name].push(value);
            }
        }else{
            obj[name] = value;
        }
    }
    return obj;
}