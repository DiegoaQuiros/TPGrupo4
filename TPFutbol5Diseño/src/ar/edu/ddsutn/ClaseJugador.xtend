package ar.edu.ddsutn;

abstract class ClaseJugador {
	Jugador jugador
	@Property Partido partido
	
	new(Jugador miJugador, Partido miPartido){
		jugador = miJugador
		partido = miPartido
		
	}
	
	def String tipo(){
		return null
	}
	
	def int prioridad() {
		return 0
	}
	
	def boolean juega(Partido partido){
		return true
	} 
	
	def boolean esEstandard(){
		return false
	}
	def boolean esDenegado(){
		return false
	}
	def boolean esPendiente(){
		return false
	}
}
