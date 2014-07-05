package ar.edu.dds.utn.clasesJugador;

import ar.edu.ddsutn.Jugador;
import ar.edu.ddsutn.Partido;
import ar.edu.ddsutn.TipoJugador;

@SuppressWarnings("all")
public class JugadorEstandard extends TipoJugador {
  public JugadorEstandard(final Jugador miJugador, final Partido miPartido) {
    super(miJugador, miPartido);
  }
  
  public String tipo() {
    return "Estandard";
  }
  
  public int prioridad() {
    return 1;
  }
  
  public boolean esEstandard() {
    return true;
  }
}
