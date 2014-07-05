package ar.edu.dds.utn.clasesJugador

class JugadorPendiente extends ar.edu.ddsutn.TipoJugador{
	
	
	new(ar.edu.ddsutn.Jugador miJugador,ar.edu.ddsutn.Partido miPartido) {
		super(miJugador, miPartido)
	}
	
	override String tipo() {
		return "Pendiente"
	}
	
	override int prioridad() {
		return 4
	}
	
	override boolean juega(ar.edu.ddsutn.Partido partido){
     return false 
	}
	override boolean esPendiente(){
		return true
	}
	
	
}