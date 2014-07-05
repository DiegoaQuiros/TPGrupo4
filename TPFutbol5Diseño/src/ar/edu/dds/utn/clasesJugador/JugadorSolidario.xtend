package ar.edu.dds.utn.clasesJugador

class JugadorSolidario extends ar.edu.ddsutn.TipoJugador{
	
	new(ar.edu.ddsutn.Jugador miJugador, ar.edu.ddsutn.Partido miPartido) {
		super(miJugador, miPartido)
	}

	override String tipo() {
		return "Solidario"
	}
	
	override int prioridad() {
		return 2
	}
	
}
