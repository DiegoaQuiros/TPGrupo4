package ar.edu.dds.utn.clasesJugador

import java.util.Date

class JugadorDenegado extends ar.edu.ddsutn.TipoJugador{
	@Property Date fechaDelRechazo
	@Property String motivo
	new(ar.edu.ddsutn.Jugador miJugador,ar.edu.ddsutn.Partido miPartido, String unMotivo) {
		super(miJugador, miPartido)
		fechaDelRechazo = new Date()
		motivo = unMotivo
	}
	
	override String tipo() {
		return "Denegado"
	}
	
	override int prioridad() {
		return 5
	}
	
	override boolean juega(ar.edu.ddsutn.Partido partido){
     return false 
	}
	override boolean esDenegado(){
		return true
	}
	
	
}