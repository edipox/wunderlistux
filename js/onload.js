const onWebviewReady = function() {
  const onLoaded = function(){
    var theme = localStorage.getItem("theme") || "elementary";
    jq("option[value='"+theme+"']").attr('selected', 'selected');
    setCustomTheme(theme);
    checkEnableShareButton();
  }
  jq.wait = function(ms) {
    var defer = jq.Deferred();
    setTimeout(function() { defer.resolve(); }, ms);
    return defer;
  };
  jq.wait(100).then(onLoaded);
  jq.wait(1000).then(onLoaded);
  jq.wait(6000).then(onLoaded);
  jq.wait(15000).then(onLoaded);
};

const onDomReady = function(){
  const defaultConf = JSON.stringify({close: 0, min: 10, max: 20});
  var buttonConf = localStorage.getItem("window_buttons");
  if(!buttonConf){
    buttonConf = defaultConf;
    localStorage.setItem("window_buttons", defaultConf);
  }
  buttonConf = JSON.parse(buttonConf);
  for(var button in buttonConf){
    updateWindowButtons(button, buttonConf[button]);
    $(".slider-container[data-button='"+button+"'] .slider").slider("value", buttonConf[button]);
  }
}

getWebview().addEventListener('did-finish-load', onWebviewReady);
getWebview().addEventListener("dom-ready", onWebviewReady);
getWebview().addEventListener("dom-ready", onDomReady);
getWebview().addEventListener("did-navigate-in-page", checkEnableShareButton);
getWebview().addEventListener("new-window", handleExternalLinkClick);
