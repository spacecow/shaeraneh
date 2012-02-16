$(function(){
  $("li#word_definitions_attributes_1_content_input").hide();
  $("li#word_definitions_attributes_1_source_token_input").hide();
  $("#word_form_tokens").tokenInput("/words.json", {
    crossDomain: false,
    allowCreation: true,
    preventDuplicates: true,
    hintText: "Type in a form",
    searchingText: "",
    theme: "facebook"
  });


  for(i=0; i<10; i++){
    var source_id = "#word_definitions_attributes_"+i+"_source_token";
    $(source_id).tokenInput("/sources.json", {
      crossDomain: false,
      allowCreation: true,
      tokenLimit: 1,
      prePopulate: $(source_id).data("pre")
    });
  }
});
