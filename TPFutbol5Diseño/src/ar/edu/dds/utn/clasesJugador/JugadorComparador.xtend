package ar.edu.dds.utn.clasesJugador

import java.util.Comparator

class JugadorComparator implements Comparator<ar.edu.ddsutn.Jugador>{
	
	ar.edu.ddsutn.Partido partido
	
	new(ar.edu.ddsutn.Partido miPartido){
		partido = miPartido
	}
	
	override int compare(ar.edu.ddsutn.Jugador uno, ar.edu.ddsutn.Jugador dos){
		if(uno.prioridad(partido)!=dos.prioridad(partido))
			return uno.prioridad(partido).compareTo(dos.prioridad(partido))
		else{
			return -(uno.getTimestamp.compareTo(dos.getTimestamp))
				
		}
	}
	
}