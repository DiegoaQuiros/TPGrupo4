package ar.edu.dds.utn.criteriosOrden

import ar.edu.ddsutn.Jugador
import ar.edu.dds.utn.exceptions.HandicapInvalido

class CriterioHandicap implements CriterioOrden {
	
	
	override int valuarJugador(Jugador jugador){
		
		if ((jugador.getHandicap() >0) && (jugador.getHandicap() <= 10)){
			
			return jugador.getHandicap()
			
		}else
	      throw new HandicapInvalido("jugador sin handicap")
	          
	}
	
}