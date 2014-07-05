package ar.edu.ddsutn

import java.util.Date

class Calificacion {
	
	@Property Partido partido
	@Property Jugador calificador
	@Property int puntaje
	@Property String comentario
	
  new(Jugador jugador, Partido unPartido, int unPuntaje, String unComentario){
        calificador = jugador
        puntaje = unPuntaje
	    comentario = unComentario
	    partido = unPartido
  }
  
 def Date fecha(){
 	partido.dia
 }

}