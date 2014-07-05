package ar.edu.ddsutn

import java.util.function.Function
import java.util.Date
import java.util.Collection
import java.util.ArrayList
import ar.edu.dds.utn.observers.StubMailSender
import ar.edu.dds.utn.observers.Mail
import ar.edu.dds.utn.exceptions.NoParticipo
import java.util.List

public class Jugador {
	@Property long timestamp = 0
	@Property Collection<Jugador> amigos
	@Property String nombre
	@Property String mail
	@Property Collection<Infraccion> infracciones
	@Property Collection<Calificacion> calificaciones
	@Property int handicap
	@Property List<TipoJugador> misTipos
	
	new(){
		amigos = new ArrayList<Jugador>
		infracciones = new ArrayList<Infraccion>
		calificaciones = new ArrayList<Calificacion>
		misTipos = new ArrayList<TipoJugador>
	}
	
	
	new(String name){
		amigos = new ArrayList<Jugador>
		infracciones = new ArrayList<Infraccion>
		nombre = name
		misTipos = new ArrayList<TipoJugador>		
	}
	
	def List<Calificacion> getNCalificaciones(int n){
		val list = new ArrayList<Calificacion>
		calificaciones
		for(i : 0..<n){
			list.add(calificaciones.get( calificaciones.size -1 - i))
		}
		return list
		
	} 
	
	def void setearTipoEstandard(Partido partido){
		misTipos.add(new JugadorEstandard(this, partido))
	}
	def void setearTipoSolidario(Partido partido){
		misTipos.add(new JugadorSolidario(this, partido))
	}
	def void setearTipoCondicional(Partido partido, Function<Partido, Boolean> condicion ){
		misTipos.add(new JugadorCondicional(this, partido, condicion))
	}
	
	def void setearTipoPendiente(Partido partido){
		misTipos.add(new JugadorPendiente(this, partido))
	}
	
	def void anotarJugador(Partido partido){
	
	}

	
	def TipoJugador tipoParaElPartido(Partido miPartido){
		misTipos.findFirst[tipo | tipo.partido == miPartido]
	}
	
	def String tipo(Partido partido){
		return tipoParaElPartido(partido).tipo()
	}
	
	def int prioridad(Partido partido){
		return tipoParaElPartido(partido).prioridad()
	}
	
	def boolean juega(Partido partido){
		return tipoParaElPartido(partido).juega(partido)
	}
	
	def boolean esEstandard(Partido partido){
		return tipoParaElPartido(partido).esEstandard()
	}
	def boolean esDenegado(Partido partido){
		return tipoParaElPartido(partido).esDenegado()
	}
	def boolean esPendiente(Partido partido){
		return tipoParaElPartido(partido).esPendiente()
	}
	
	def notificarAmigo(Jugador jugador,Partido partido){
		StubMailSender.instance.send(new Mail(jugador.mail, this.mail, "me anote al partido", "me anote al partido de la fecha " + partido.getStringFecha() +", copate"))
	}
	
	def generarInfraccion(Date dia, String motivo){
		infracciones.add(new Infraccion(dia, motivo))
	}
	
	def boolean tieneInfracciones(){
		return infracciones.size() != 0
	}
	
	def agregarAmigo(Jugador jugador){
		amigos.add(jugador)
	}
	
	def calificar(Jugador jugador, Partido partido, int puntaje, String comentario){
		if (partido.finalizarInscripcion().contains(jugador)){
			jugador.calificaciones.add(new Calificacion(this, partido, puntaje, comentario))
		 }else
		    throw new NoParticipo("El jugador no asistio al Partido")
		
	}
	
	def void sacarTipoDelPartido(Partido partido){
		misTipos.remove(tipoParaElPartido(partido))
	}
	
	def void aceptarJugador(TipoJugador tipo, Partido partido) {
		sacarTipoDelPartido(partido)
		misTipos.add(tipo)
	
	}
	
	def void denegarJugador(String motivo, Partido partido) {
		sacarTipoDelPartido(partido)
		misTipos.add(new JugadorDenegado(this, partido, motivo))
	}
		
	def List<Calificacion> calificacionesUltimoPartido(){
		val calificacionesOrdenadas = calificaciones.sortBy[fecha].reverse()
			
		val dia = calificacionesOrdenadas.head.fecha
		
		calificacionesOrdenadas.filter[ calificacion | calificacion.fecha == dia].toList()
	}
}
