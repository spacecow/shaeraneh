$(function(){
  $("#word_form_tokens").tokenInput("/words.json", {
    crossDomain: false,
    allowCreation: true,
    preventDuplicates: true,
    hintText: "Type in a form",
    searchingText: "",
    tokenDelimiter: "fe",
    theme: "facebook"
  });

  $("#word_category_tokens").tokenInput("/categories.json", {
    crossDomain: false,
    preventDuplicates: true,
    allowCreation: true,
    prePopulate: $("#word_category_tokens").data("pre"),
    theme: "facebook"
  });


  for(i=1; i<10; i++){
    $("li.hide").hide();
    $("li.hide").hide();
  }

  for(i=0; i<10; i++){
    var source_id = "#word_definitions_attributes_"+i+"_source_token";
    $(source_id).tokenInput("/sources.json", {
      crossDomain: false,
      allowCreation: true,
      tokenLimit: 1,
      prePopulate: $(source_id).data("pre")
    });
  }

  $("a#add_definition").click(function(){
    var i = $('li.definition').filter(':visible').size();
    $("li#content_"+i).show();
    $("li#source_"+i).show();
  });
});
