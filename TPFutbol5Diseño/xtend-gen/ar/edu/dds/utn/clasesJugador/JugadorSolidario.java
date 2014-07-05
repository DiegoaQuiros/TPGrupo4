package ar.edu.dds.utn.clasesJugador;

import ar.edu.ddsutn.Jugador;
import ar.edu.ddsutn.Partido;
import ar.edu.ddsutn.TipoJugador;

@SuppressWarnings("all")
public class JugadorSolidario extends TipoJugador {
  public JugadorSolidario(final Jugador miJugador, final Partido miPartido) {
    super(miJugador, miPartido);
  }
  
  public String tipo() {
    return "Solidario";
  }
  
  public int prioridad() {
    return 2;
  }
}
