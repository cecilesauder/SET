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
verif_set(1,2,3)


#### jeu de cartes plot

plot(x=c(0.3,1.7), y=c(0,5), type='n', xlab = "", ylab = "", axes = FALSE)
box()
#losange violet hachuré
polygon(x=c(0.5,1,1.5,1), y=c(1,1.5,1,0.5), density = c(7), angle = c(45), col="deeppink1", lwd=3)
polygon(x=c(0.5,1,1.5,1), y=c(1,1.5,1,0.5)+1.5,  border = "darkorchid", col="darkorchid", lwd=3)
polygon(x=c(0.5,1,1.5,1), y=c(1,1.5,1,0.5)+3, border="turquoise2", lwd=3)

plot(x=c(0.3,1.7), y=c(0,5), type='n', xlab = "", ylab = "", axes = FALSE)
box()
polygon(x=c(0.5,1,1.5,1), y=c(1,1.5,1,0.5)+0.75,  border = "darkorchid", col="darkorchid", lwd=3)
polygon(x=c(0.5,1,1.5,1), y=c(1,1.5,1,0.5)+2.25, border="turquoise2", lwd=3)

plot(x=c(0.3,1.7), y=c(0,5), type='n', xlab = "", ylab = "", axes = FALSE)
z <- seq(0, 2*pi, length = 500)
polygon( 1 + cos(z)*.5, 1 + sin(z)*.5 , col = NULL, border = "darkorchid", density = NULL, angle = NULL, lwd = 3)
polygon( 1 + cos(z)*.5, 2.5 + sin(z)*.5 , col = "darkorchid", border = "darkorchid", lwd = 3, density = 7)
polygon( 1 + cos(z)*.5, 4 + sin(z)*.5 , col = "darkorchid", border = "darkorchid", lwd = 3, density = 7)
box()

plot(x=c(0.3,1.7), y=c(0,5), type='n', xlab = "", ylab = "", axes = FALSE)
z <- seq(0, 2*pi, length = 500)
polygon( 1 + cos(z)*.5, 1.75 + sin(z)*.5 , col = "darkorchid", border = "darkorchid", lwd = 3, density = 7)
polygon( 1 + cos(z)*.5, 3.25 + sin(z)*.5 , col = "darkorchid", border = "darkorchid", lwd = 3, density = 7)
box()


plot(x=c(0.3,1.7), y=c(0,5), type='n', xlab = "", ylab = "", axes = FALSE)
polygon(x=c(0.5,0.5,1.5,1.5), y=c(0.5, 1.5,1.5,0.5), border = "deeppink1", density = NULL, angle = c(45), col="deeppink1", lwd=3)
polygon(x=c(0.5,0.5,1.5,1.5), y=1.5+c(0.5, 1.5,1.5,0.5), density = c(7), angle = c(45), col="deeppink1", lwd=3)
polygon(x=c(0.5,0.5,1.5,1.5), y=3+c(0.5, 1.5,1.5,0.5), density = NULL, angle = NULL, col=NULL, border = "deeppink1", lwd=3)
box()

draw_rectangle<-function(remplissage, couleur, hauteur){
  x <- c(0.5,0.5,1.5,1.5)
  y <- c(0.5, 1.5,1.5,0.5)
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
    density <- 7
    angle <- 45
    border <- NULL
    col <- couleur
  }
  if ( hauteur == 1){
    y <- y
  }
  if ( hauteur == 2){
    y <- y+0.75
  }
  if ( hauteur == 3){
    y <- y+1.5
  }
  if ( hauteur == 4){
    y <- y+2.25
  }
  if ( hauteur == 5){
    y <- y+3
  }
  polygon(x=x, y=y, density = density, angle = angle, col=col, border = border, lwd=3)
}

draw_rectangle(remplissage = 1,couleur = "turquoise2", 1)



draw_card(1,2,3,3)


png(filename = "/Users/cecile/git/set/inst/app/www/cards/test.jpg",
    width = 400, height = 600, units = "px", pointsize = 12,
    bg = "white")
par(mar=rep(0.15,4))
draw_card(3,3,3,3)
dev.off()

system.time(
for (i in 1:nrow(jeu)){
  filename <- paste("/Users/cecile/git/set/inst/app/www/cards/", jeu[i,"idcards"], ".png", sep="")
  print(filename)
  png(filename = filename,
      width = 400, height = 600, units = "px", pointsize = 12,
      bg = "white")
  par(mar=rep(0.15,4))
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

