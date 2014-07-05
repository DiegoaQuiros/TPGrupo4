package ar.edu.dds.utn.criteriosOrden

import ar.edu.ddsutn.Jugador

class CriterioPromedioUltimoPartido implements CriterioOrden{
	
	override int valuarJugador(Jugador jugador){
		val suma = jugador.calificacionesUltimoPartido.fold(0, [acum, calificacion | acum + calificacion.puntaje])
		
		suma / jugador.calificacionesUltimoPartido.size()
	}
}