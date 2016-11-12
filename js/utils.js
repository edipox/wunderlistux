const {shell, remote} = require('electron');
window.jq = require('./js/jquery-3.1.0.min.js');

window.setCustomTheme = function(theme){
  var THEME_CONTAINER_ID = "window_theme_container";
  fs = require('fs');

  var createOrUpdate = function(id, content, type, appender) {
      jq('#' + id).remove();
      jq('<' + type + ' id="' + id + '">' + content + '</' + type + '>').appendTo(appender);
  }
  fs.readFile(process.resourcesPath+"/app/themes/"+theme+"/window.css", 'utf8', function (err, content) {
    if(err){
      fs.readFile("./themes/"+theme+"/window.css", 'utf8', function (err, content) {
        createOrUpdate(THEME_CONTAINER_ID, content, "style", "body")
      });
    }else{
      createOrUpdate(THEME_CONTAINER_ID, content, "style", "body")
    }
  });
  localStorage.setItem("theme", theme);
  getWebview().send('change-theme', theme);
}

var getWebview = function(){
  return document.getElementById('webview');
}

var checkEnableShareButton = function(e){
  var url = (e || {}).url;
  var notSharableLists = [
    "#/lists/all",
    "#/lists/week",
    "#/lists/starred",
    "#/lists/inbox"
  ];
  var path = url || jq("webview").attr("src");
  path = path.substring(path.indexOf("#"), path.length);
  var isSharableList = true;
  for(var i = 0; i < notSharableLists.length; i++){
    var listPath = notSharableLists[i];
    if(listPath == path) isSharableList = false;
  }
  if(isSharableList){
    jq("#share").removeClass("disabled");
  }else{
    jq("#share").addClass("disabled");
  }
}

var handleExternalLinkClick = function(e){
  const protocol = require('url').parse(e.url).protocol;
  if(protocol === 'http:' || protocol === 'https:'){
    shell.openExternal(e.url);
  }
}
