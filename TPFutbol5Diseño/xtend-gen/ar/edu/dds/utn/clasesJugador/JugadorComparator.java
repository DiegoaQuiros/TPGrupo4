package ar.edu.dds.utn.clasesJugador;

import ar.edu.ddsutn.Jugador;
import ar.edu.ddsutn.Partido;
import java.util.Comparator;

@SuppressWarnings("all")
public class JugadorComparator implements Comparator<Jugador> {
  private Partido partido;
  
  public JugadorComparator(final Partido miPartido) {
    this.partido = miPartido;
  }
  
  public int compare(final Jugador uno, final Jugador dos) {
    int _prioridad = uno.prioridad(this.partido);
    int _prioridad_1 = dos.prioridad(this.partido);
    boolean _notEquals = (_prioridad != _prioridad_1);
    if (_notEquals) {
      int _prioridad_2 = uno.prioridad(this.partido);
      int _prioridad_3 = dos.prioridad(this.partido);
      return Integer.valueOf(_prioridad_2).compareTo(Integer.valueOf(_prioridad_3));
    } else {
      long _timestamp = uno.getTimestamp();
      long _timestamp_1 = dos.getTimestamp();
      int _compareTo = Long.valueOf(_timestamp).compareTo(Long.valueOf(_timestamp_1));
      return (-_compareTo);
    }
  }
}
