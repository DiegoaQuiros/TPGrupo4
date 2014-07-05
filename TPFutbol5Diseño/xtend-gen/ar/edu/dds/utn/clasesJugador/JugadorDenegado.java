package ar.edu.dds.utn.clasesJugador;

import ar.edu.ddsutn.Jugador;
import ar.edu.ddsutn.Partido;
import ar.edu.ddsutn.TipoJugador;
import java.util.Date;

@SuppressWarnings("all")
public class JugadorDenegado extends TipoJugador {
  private Date _fechaDelRechazo;
  
  public Date getFechaDelRechazo() {
    return this._fechaDelRechazo;
  }
  
  public void setFechaDelRechazo(final Date fechaDelRechazo) {
    this._fechaDelRechazo = fechaDelRechazo;
  }
  
  private String _motivo;
  
  public String getMotivo() {
    return this._motivo;
  }
  
  public void setMotivo(final String motivo) {
    this._motivo = motivo;
  }
  
  public JugadorDenegado(final Jugador miJugador, final Partido miPartido, final String unMotivo) {
    super(miJugador, miPartido);
    Date _date = new Date();
    this.setFechaDelRechazo(_date);
    this.setMotivo(unMotivo);
  }
  
  public String tipo() {
    return "Denegado";
  }
  
  public int prioridad() {
    return 5;
  }
  
  public boolean juega(final Partido partido) {
    return false;
  }
  
  public boolean esDenegado() {
    return true;
  }
}
