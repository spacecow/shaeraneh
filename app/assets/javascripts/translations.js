$(function() {
  var key = "#translation_locale_token"
  $(key).tokenInput($(key).data("url"), {
    crossDomain: false,
    allowCreation: true,
    tokenLimit: 1,
    theme: ""
  });
});
