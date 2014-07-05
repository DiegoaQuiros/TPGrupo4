package ar.edu.dds.utn.clasesJugador;

import ar.edu.ddsutn.Jugador;
import ar.edu.ddsutn.Partido;
import ar.edu.ddsutn.TipoJugador;
import java.util.function.Function;

@SuppressWarnings("all")
public class JugadorCondicional extends TipoJugador {
  private Function<Partido, Boolean> condicion;
  
  public JugadorCondicional(final Jugador miJugador, final Partido miPartido, final Function<Partido, Boolean> miCondicion) {
    super(miJugador, miPartido);
    this.condicion = miCondicion;
  }
  
  public String tipo() {
    return "Condicional";
  }
  
  public int prioridad() {
    return 3;
  }
  
  public boolean juega(final Partido partido) {
    return (this.condicion.apply(partido)).booleanValue();
  }
}
