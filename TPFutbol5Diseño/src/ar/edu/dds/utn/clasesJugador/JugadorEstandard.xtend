package ar.edu.dds.utn.clasesJugador

class JugadorEstandard extends ar.edu.ddsutn.TipoJugador {
	
	new(ar.edu.ddsutn.Jugador miJugador,ar.edu.ddsutn.Partido miPartido) {
		super(miJugador, miPartido)
	}

	override String tipo() {
		return "Estandard"
	}
	
	override int prioridad() {
		return 1
	}
	
	override boolean esEstandard(){
		return true
	}
}
