const remote = require('electron').remote;
window.jq = require('./js/jquery-3.1.0.min.js');

var getWebview = function(){
  return document.getElementById('webview');
}

jq(document).on("click", "#close-btn", function(e) {
    remote.getCurrentWindow().close();
});

jq(document).on("click", "#min-btn", function(e) {
    remote.getCurrentWindow().minimize();
});
var maximize = function(e) {
    var window = remote.getCurrentWindow();
    if (!window.isMaximized()) {
        window.maximize();
    } else {
        window.unmaximize();
    }
};
jq(document).on("dblclick", "#controls", maximize);
jq(document).on("click", "#max-btn", maximize);

jq(document).on("click", "#settings-btn", function(e) {
    jq("#settings-panel").appendTo("#popup");
    jq("#popup").show();
    jq("#theme-selector").trigger('click').attr("size","2");

});
jq(document).on("mouseup", ":not(#settings-btn), :not(#settings-panel)", function() {
    jq("#popup").hide();
});

jq(document).on('keydown', function(e) {
    if (e.which == 27) jq("#popup").hide();
});

var setCustomTheme = function(theme){
  console.log("starting custom theme - window..")
  var THEME_CONTAINER_ID = "window_theme_container";
  fs = require('fs');

  var createOrUpdate = function(id, content, type, appender) {
      jq('#' + id).remove();
      jq('<' + type + ' id="' + id + '">' + content + '</' + type + '>').appendTo(appender);
  }
  fs.readFile("./themes/" + theme + "/window.css", 'utf8', function(err, content) {
      createOrUpdate(THEME_CONTAINER_ID, content, "style", "body")
  });
  var webview = getWebview();
  localStorage.setItem("theme", theme);
  webview.send('change-theme', theme);
  console.log("Finished custom theme - window!")
}

var clickBell = function(){
  getWebview().send('click-bell');
}

var clickConversations = function(){
  getWebview().send("click-conversations")
}

jq(document).on("change", "#theme-selector", function(e) {
    var theme = jq(e.target).find("option:selected").text();
    setCustomTheme(theme)
    jq("#popup").hide();
})

var onReady = function(){
  var theme = localStorage.getItem("theme") || "elementary";
  jq("#bell").on("click", clickBell);
  jq("#conv").on("click", clickConversations);
  jq('#theme-selector option').removeAttr("selected");
  jq('#theme-selector option:contains("'+theme+'")').attr("selected", "selected");
  jq("#theme-selector").trigger("change")
};
jq(document).ready(onReady).on("turbolinks:load", onReady);
