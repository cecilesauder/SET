HTMLWidgets.widget({

  name: 'SETwidget',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    var selected_cards = [] ;

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

    return {

      renderValue: function(x) {
        console.log(x);

        // TODO: code to render the widget, e.g.
        var table = x.table;
        var nrow = table.length;
        console.log(table);
        for (var iter=0; iter < nrow; iter++){
          $(el).append(ligne(table[iter]));
        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});