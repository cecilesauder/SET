HTMLWidgets.widget({

  name: 'SETwidget',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    
    image = function(idcard){
      var im = $('<img class="card"></img>') ; 
      im.attr("src", "cards/" + idcard  + ".png")  ;
      im.width(150) ;
      im.on("click", "alert(" + idcard + ")") ;
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