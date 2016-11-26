jq(document).on("click", ".close-btn", function(e) {
    remote.getCurrentWindow().close();
});

jq(document).on("click", ".min-btn", function(e) {
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

var showPopup = function(){
  jq("#overlay").show();
  jq("#popup").show();
}
var hidePopup = function(){
  jq("#overlay").hide();
  jq("#popup").hide();
}

jq(document).on("dblclick", "#controls", maximize);
jq(document).on("click", ".max-btn", maximize);

jq(document).on("click", "#overlay", hidePopup);


jq(document).on("click", "#settings-btn", function(e) {
    jq("#settings-panel").appendTo("#popup");
    showPopup()
});

jq(document).on('keydown', function(e) {
    if (e.which == 27) jq("#popup").hide();
});

jq(document).on("click", "#bell", function(){
  getWebview().send('click-bell');
});
jq(document).on("click", "#conv", function(){
  getWebview().send("click-conversations")
});

jq(document).on("click", "#sort", function(e, v){
  getWebview().send("click-sort", v)
});

jq(document).on("click", "#more", function(e, v){
  getWebview().send("click-more", v)
});

jq(document).on("click", "#share", function(e, v){
  getWebview().send("click-share", v)
});


jq(document).on("change", "#theme-selector", function(e) {
    var theme = jq(e.target).find("option:selected").text();
    setCustomTheme(theme);
});


$(".slider").slider({
  step: 10,
  max: 20,
  min: 0,
  slide: function( event, ui ) {
    const button = $(this).parent().data("button");
    const val = ui.value;
    updateWindowButtons(button, val);
  }
});
