#' fonction teste si un critere est egal pour les 3 cartes et renvoie TRUE ou FALSE
#' 
#' @param trio un dataframe de 3 lignes et 1 colonne
#' @return TRUE if all values are equals FALSE otherwise
#' @export
egal_ <- function(trio){
  trio[1]==trio[2] & trio[2]==trio[3]
}

different_ <- function(trio){#trio est un dataframe de 3 lignes et 1 colonne
  trio[1]!=trio[2] & trio[2]!=trio[3] & trio[1]!=trio[3]
}



is_set_1col <- function(trio){
 egal_(trio) | different_(trio)
}

###########function is_set qui teste un tableau de 3*4 colonne et return TRUE si y a SET et FALSE
#' @export
is_set <- function(df){
  is_set_1col(df[,1]) & is_set_1col(df[,2]) & is_set_1col(df[,3]) & is_set_1col(df[,4]) 
}

#' @importFrom utils combn
find_set<-function(nbcards,jeu){
  tab<-jeu[1:nbcards,]
  cbn<-combn(nbcards,3)
  for (i in 1:ncol(cbn)){
    if(is_set(tab[cbn[,i],])){
      print("SET")
      print(tab[cbn[,i],])
    }#else(print("aucun SET ?!?"))
  }
}

#' @importFrom dplyr filter
#' @importFrom magrittr %>%
#' @export
verif_set <- function(trio,jeu){
  tab <-jeu[jeu$idcards %in% trio,]
  return(is_set(tab))
}

#' fonction qui repartie les cartes pour les afficher sur la table
#' 
#' @param une liste d'idcards
#' @return une liste de 3 vecteurs ( pour les 3 lignes affichees)
#' 
#' @export
allocate_cards <- function(cards){
  split( cards, rep(1:3, length.out = length(cards))  )
}


#' create un juego de SET! 81 cards in .png
#'
#' @param jeu data.frame created by create_game
#' @return time elapsed
draw_game <-function(jeu){
  system.time(
    for (i in 1:nrow(jeu)){
      filename <- paste("/home/cecile/git/SET/inst/app/www/cards/", jeu[i,"idcards"], ".png", sep="")
      png(filename = filename,
          width = 400, height = 600, units = "px", pointsize = 12,
          bg = "white")
      par(mar=rep(0,4))
      draw_card(jeu[i,1],jeu[i,2],jeu[i,3],jeu[i,4])
      dev.off()
    }
  )
}


#' dibujar una carta
#' 
#' @param forme (1 : rectangle, 2: circle, 3:losange)
#' @param nombre (1/2/3)
#' @param remplissage (vide / plein / hachure)
#' @param couleur (1/2/3)
#' 
#' @importFrom graphics polygon
#' @export
draw_card<-function(forme, nombre, remplissage, couleur){
  ### param couleur
  vectcol<-c("deeppink1","darkorchid","turquoise2" )
  couleur <- vectcol[couleur]
  
  ### param forme
  if(forme == 1){# rectangle
    x <- c(0.5,0.5,1.5,1.5)
    y <- c(0.5, 1.5,1.5,0.5)
  }
  if(forme == 2){# cercle
    z <- seq(0, 2*pi, length = 500)
    x <- 1 + cos(z)*0.5
    y <- 1 + sin(z)*0.5
  }
  if(forme == 3){# losange
    x <- c(0.5,1,1.5,1)
    y <- c(1,1.5,1,0.5)
  }
  
  ### param remplissage
  if (remplissage == 1){# 1 = vide
    density <- NULL
    angle <- NULL
    border <- couleur
    col <- NULL
  }
  if(remplissage == 2){# 2 = plein
    density <- NULL
    angle <- NULL
    border <- couleur
    col <- couleur
  }
  if(remplissage == 3){# 3 = hachures
    density <- 3
    angle <- 45
    border <- NULL
    col <- couleur
  }
  ###
  ####### plot 
  plot(x=c(0.3,1.7), y=c(0,5), type='n', xlab = "", ylab = "", axes = FALSE)

  ### param nombre
  lwd <-10
  if(nombre == 1){
    y <- y+1.5
    polygon(x=x, y=y, density = density, angle = angle, col=col, border = border, lwd=lwd)
  }
  if(nombre == 2){
    y <- y+0.75
    polygon(x=x, y=y, density = density, angle = angle, col=col, border = border, lwd=lwd)
    y <- y+1.5
    polygon(x=x, y=y, density = density, angle = angle, col=col, border = border, lwd=lwd)
  }
  if(nombre == 3){
    polygon(x=x, y=y, density = density, angle = angle, col=col, border = border, lwd=lwd)
    y <- y+1.5
    polygon(x=x, y=y, density = density, angle = angle, col=col, border = border, lwd=lwd)
    y <- y+1.5
    polygon(x=x, y=y, density = density, angle = angle, col=col, border = border, lwd=lwd)
  }
}


#' create a gameplay of 81 cards
#' 
#' @return a 81*5 data.frame
#' 
#' @importFrom dplyr mutate row_number
#' @importFrom magrittr %>%
#' @export
create_gameplay <- function(){  
  expand.grid( forme=1:3, nombre=1:3, remplissage=1:3, couleur=1:3 ) %>%
    mutate(idcards = row_number() )
}

#' draw ncards randomly 
#' 
#' @param ncards : an integer and jeu : a data.frame with the game play
#' @return a list of 2 data.frame : drawn_cards and remaining_cards
#' 
#' @examples 
#' draw_cards( 12, create_gameplay() )
#' 
#' @importFrom dplyr sample_n filter
#' @importFrom magrittr %>%
#' @export
draw_cards <- function(ncards, jeu){
  drawn_cards <- jeu %>% sample_n(ncards)
  remaining_cards <- jeu %>% filter(!idcards %in% drawn_cards$idcards)
  list(drawn_cards = drawn_cards, remaining_cards = remaining_cards)
}
