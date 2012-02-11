$(function() {
  $("#translation_locale_token").tokenInput("/locales.json", {
    crossDomain: false,
    allowCreation: true,
    tokenLimit: 1,
    prePopulate: $("#translation_locale_token").data("pre"),
    theme: ""
  });
});
