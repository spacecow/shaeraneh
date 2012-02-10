$(function(){
  $("li#word_definitions_attributes_1_content_input").hide();
  $("#word_form_tokens").tokenInput("/words.json", {
    crossDomain: false,
    allowCreation: true,
    preventDuplicates: true,
    hintText: "Type in a form",
    searchingText: "",
    theme: "facebook"
  });
});
