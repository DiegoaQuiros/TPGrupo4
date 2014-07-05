package ar.edu.dds.utn.criteriosOrden

import ar.edu.ddsutn.Jugador

class CriterioPromedioNCalificaciones implements CriterioOrden{
	
    @Property int numCalificaciones
		
		
	new(int num){
		numCalificaciones = num
	}
		
	override int valuarJugador(Jugador jugador){
		
		val suma = jugador.getNCalificaciones(numCalificaciones).fold(0, [acum, calificacion | acum + calificacion.puntaje])
	
	    return suma / numCalificaciones
	}
	
}