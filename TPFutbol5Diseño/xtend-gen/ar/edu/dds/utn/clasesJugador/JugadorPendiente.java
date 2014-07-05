package ar.edu.dds.utn.clasesJugador;

import ar.edu.ddsutn.Jugador;
import ar.edu.ddsutn.Partido;
import ar.edu.ddsutn.TipoJugador;

@SuppressWarnings("all")
public class JugadorPendiente extends TipoJugador {
  public JugadorPendiente(final Jugador miJugador, final Partido miPartido) {
    super(miJugador, miPartido);
  }
  
  public String tipo() {
    return "Pendiente";
  }
  
  public int prioridad() {
    return 4;
  }
  
  public boolean juega(final Partido partido) {
    return false;
  }
  
  public boolean esPendiente() {
    return true;
  }
}
