package ar.edu.dds.utn.observers

import ar.edu.ddsutn.Jugador
import ar.edu.ddsutn.Partido

class AmigosObserver implements PartidoObserver{

override notifyAltaJugador(Jugador jugador, Partido partido){
	jugador.amigos.forEach[notificarAmigo(jugador, partido)]
	
}

override notifyBajaJugador(Jugador jugador, Partido partido){
	
}
}