
var SET_game = function(){
  
  class SelectedCards {
    constructor(){
      this.selected_cards = [] ;
    }
    
    update(){
      Shiny.onInputChange( "selected_cards", this.selected_cards ) ;   
    }
    
    add( id ){
      this.selected_cards.push(id) ; 
      this.update() ;
    }
   
    rm( id ){
      var index = this.selected_cards.indexOf(id) ;
      this.selected_cards.splice(index, 1) ;
      this.update();
    } 
    
    clear(){
      this.selected_cards = [] ;
      this.update();
    }
    
  }
  
  var selected = new SelectedCards() ;
  
  click_card = function(){ 
    var im =$(this);
    var idcard = im.attr("id");
    if( im.hasClass("selected_card") ){
      im.attr("class", "card");
      selected.rm(idcard);
    } else{
      im.attr("class", "selected_card");
      selected.add(idcard);
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
  
  // listening to is_set event triggered on the server.R by 
  // session$sendCustomMessage( type = "is_set" )
  Shiny.addCustomMessageHandler("is_set",
    function(is_set) {
      alert(is_set);
    }
  );

  // listening to init_set event triggered on the server.R by 
  // session$sendCustomMessage( type = "init_set" )
  Shiny.addCustomMessageHandler("init_set", function(x){
    var $cards = $( "#cards" ) ;
    var table = x.table;
    var nrow = table.length;
    for (var iter=0; iter < nrow; iter++){
      $cards.append(ligne(table[iter]));
    }
  }) ;

} ;

// trigerred when the document is ready
$(SET_game) ; 
