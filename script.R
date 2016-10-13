library(dplyr)

jeu_start<- expand.grid( forme=1:3, nombre=1:3, remplissage=1:3, couleur=1:3 )
#1 carte represente une ligne du tableau, on a le jeu de 81 cartes dans le tableau

#melange du jeu de carte
jeu <- jeu_start %>% sample_n(81) 
jeu <- jeu %>% mutate(idcards = as.numeric(row.names(jeu)))
jeu %>% head(12)
jeu


different_(c(2,3,1))
egal_(c(1,2,2))
is_set_1col(c(2,1,3))


is_set(jeu[1:3,])
test <- data.frame(x=1:3,y=rep(2,3),z=1:3,w=1:3)
test
is_set(test)

#il reste a appliquer is_set aux 220 tableaux de 3 possibilités parmi 12
nbcards <- 12
tab12<-jeu[1:nbcards,]

cbn<-combn(nbcards,3)
#combn(12,3)#donne les 3 id des 220 possibilités de choisir 3 cartes parmi 12 


is_set(tab12[cbn[,1],])
tab12[cbn[,1],]
tab12[cbn[,2],]
tab12[cbn[,110],]

find_set(12,jeu)

fliter


system.time(
for (i in 1:nrow(jeu)){
  filename <- paste("/home/bulle/git/SET/inst/app/www/cards/", jeu[i,"idcards"], ".png", sep="")
  print(filename)
  png(filename = filename,
      width = 400, height = 600, units = "px", pointsize = 12,
      bg = "white")
  par(mar=rep(0,4))
  draw_card(jeu[i,1],jeu[i,2],jeu[i,3],jeu[i,4])
  dev.off()
}
)

####deployer l'appli
install.packages('rsconnect')
library(rsconnect)
rsconnect::setAccountInfo(name='cecilesauder', token='557317F15D5B138698A64DD8DA2FC6E6', secret='lWG2AsOatUUJW1FRiwxc3EYvFCqE36mHViyuMQXV')
getwd()
#"C:/Users/Charles/Desktop/cec/SET"
setwd("/Users/Charles/Desktop/cec/SET/inst/app")
deployApp()
#probleme de package a regler ulterieurement...

