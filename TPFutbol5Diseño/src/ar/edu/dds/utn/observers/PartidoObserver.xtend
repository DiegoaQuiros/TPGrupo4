package ar.edu.dds.utn.observers

import ar.edu.ddsutn.Jugador
import ar.edu.ddsutn.Partido

interface PartidoObserver {

def void notifyAltaJugador(Jugador jugador, Partido partido)
def void notifyBajaJugador(Jugador jugador, Partido partido)		
}