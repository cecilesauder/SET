
var SET_game = function(){

  var selected_cards = [] ;
  var set_id ; 
  
  update_selected = function(){
    Shiny.onInputChange( "selected_cards", selected_cards ) ; 
  } ;

  add_selected_card = function(id){
    selected_cards.push(id) ;
    update_selected();
  } ;

  rm_selected_card = function(id){
    index = selected_cards.indexOf(id) ;
    selected_cards.splice(index, 1) ;
    update_selected();
  } ;

  clear_selected_card = function(){
    selected_cards = [] ;
    update_selected();
  } ;
  
  click_card = function(){ 
      //alert( idcard );
      var im =$(this);
      var idcard = im.attr("id");
      if( im.hasClass("selected_card") ){
        im.attr("class", "card");
        rm_selected_card(idcard);
      }else{
        im.attr("class", "selected_card");
        add_selected_card(idcard);
      }
      

  } ;
  
  image = function(idcard){
    var im = $('<img class="card"></img>') ; 
    im.attr("src", "cards/" + idcard  + ".png")  ;
    im.attr("id", idcard) ;
    im.width(150) ;
    im.on("click", click_card) ;
    return im ;
  };
  
  ligne = function(tabcards){
    var div = $("<div></div>");
    for(var iter=0; iter < tabcards.length; iter++){
      div.append(image(tabcards[iter]));
    }
    return div;
  };
  
  Shiny.addCustomMessageHandler("is_set",
      function(is_set) {
        alert(is_set);
      }
  );

  Shiny.addCustomMessageHandler("init_set", function(x){
    set_id = x.id ;
    $el = $( "#" + set_id ) ;
    var table = x.table;
    var nrow = table.length;
    console.log(table);
    for (var iter=0; iter < nrow; iter++){
      $el.append(ligne(table[iter]));
    }
  }) ;

} ;

$(SET_game) ; 