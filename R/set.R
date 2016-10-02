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

#######test si un trio est ou tout egal ou tout different
is_set_1col <- function(trio){
 egal_(trio) | different_(trio)
}

###########function is_set qui teste un tableau de 3*4 colonne et return TRUE si y a SET et FALSE

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
verif_set <- function(id1,id2,id3){
  tab <-jeu %>% filter(idcards == id1 | idcards == id2 | idcards == id3)
  return(is_set(tab))
}

