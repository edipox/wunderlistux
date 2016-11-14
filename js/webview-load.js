const {ipcRenderer} = require('electron')

var loadJQuery = function(){
  var file = "/jquery-3.1.0.min.js"
  if(window.$ === undefined)
    try {
      window.$ = window.jQuery = require(process.resourcesPath+
        file);
    } catch(err) {
      window.$ = window.jQuery = require("." + file);
    }
}

window.setCustomTheme = function(_, theme){
  loadJQuery()
  $('#headerbar').remove();
  $("body").prepend("<div id='headerbar'></div>");
  var THEME_CONTAINER_ID = "webview_theme_container";
  fs = require('fs');
  var createOrUpdate = function(id, content, type, appender){
    $('#'+id).remove();
    $('<'+type+' id="'+id+'">'+content+'</'+type+'>').appendTo(appender);
  }
  fs.readFile(process.resourcesPath+"/app/themes/"+theme+"/webview.css", 'utf8', function (err, content) {
    if(err){
      fs.readFile("./themes/"+theme+"/webview.css", 'utf8', function (errSecond, content) {
        if(errSecond){
          fs.readFile(process.resourcesPath+"/app.asar/themes/"+theme+"/webview.css", 'utf8', function (errThird, content) {
              createOrUpdate(THEME_CONTAINER_ID, content, "style", "body")
          });
        }else{
          createOrUpdate(THEME_CONTAINER_ID, content, "style", "body")
        }
      });
    }else{
      createOrUpdate(THEME_CONTAINER_ID, content, "style", "body")
    }
  });
  localStorage.setItem("custom_electron_theme", theme);
}

window.onload = function() {
    loadJQuery()
    var onReady = function() {
      setCustomTheme(null, localStorage.getItem("custom_electron_theme") || "elementary");
    };
}


ipcRenderer.on('change-theme', setCustomTheme);
ipcRenderer.on("click-bell", function(){ $("a[data-path='activities']")[0].click() })
ipcRenderer.on("click-conversations", function(){ $("a[data-path='conversations']")[0].click() })
ipcRenderer.on("click-sort", function(){ $("[data-menu='sort']")[0].click() })
ipcRenderer.on("click-more", function(){ $("[data-menu='more']")[0].click() })
ipcRenderer.on("click-share", function(){ $("[data-menu='share']")[0].click() })
