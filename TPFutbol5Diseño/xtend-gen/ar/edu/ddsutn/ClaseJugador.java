package ar.edu.ddsutn;

import ar.edu.ddsutn.Jugador;
import ar.edu.ddsutn.Partido;

@SuppressWarnings("all")
public abstract class ClaseJugador {
  private Jugador jugador;
  
  private Partido _partido;
  
  public Partido getPartido() {
    return this._partido;
  }
  
  public void setPartido(final Partido partido) {
    this._partido = partido;
  }
  
  public ClaseJugador(final Jugador miJugador, final Partido miPartido) {
    this.jugador = miJugador;
    this.setPartido(miPartido);
  }
  
  public String tipo() {
    return null;
  }
  
  public int prioridad() {
    return 0;
  }
  
  public boolean juega(final Partido partido) {
    return true;
  }
  
  public boolean esEstandard() {
    return false;
  }
  
  public boolean esDenegado() {
    return false;
  }
  
  public boolean esPendiente() {
    return false;
  }
}
