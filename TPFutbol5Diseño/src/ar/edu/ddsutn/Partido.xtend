package ar.edu.ddsutn

import ar.edu.dds.utn.exceptions.NoHay10Anotados
import ar.edu.dds.utn.exceptions.NoHayCupo
import ar.edu.dds.utn.observers.PartidoObserver
import java.util.Date
import java.util.List
import java.util.Collection
import java.util.ArrayList
import java.text.SimpleDateFormat
import ar.edu.dds.utn.criteriosOrden.CriterioOrdenimport ar.edu.dds.utn.exceptions.PartidoConfirmado
import ar.edu.dds.utn.criteriosDivision.CriterioDivision

class Partido {
	@Property Collection<Jugador> jugadores
	@Property Date dia
	@Property Collection<PartidoObserver> partidoObservers
	@Property Collection<Jugador> equipoA
	@Property Collection<Jugador> equipoB
	@Property boolean partidoConfirmado
	int indice = 0
	
	
	new(){
		jugadores = new ArrayList<Jugador>
		partidoObservers = new ArrayList<PartidoObserver>
	}
	
	def String getStringFecha(){
		val formato = new SimpleDateFormat("MM/dd/yyyy")
		formato.format(dia)
	}
	
	def boolean hayCupo(){

		return jugadores.filter[jugador | jugador.esEstandard(this)].size() <10
	}
	
	def void agregarJugador(Jugador jugador){
		   sePuedeModificarPartidoConfirmado()
		   sePuedeModificarPartidoCompleto()
			agregarJugadorALaLista(jugador)
			partidoObservers.forEach[ notifyAltaJugador(jugador, this)]
		}
		
	def void sePuedeModificarPartidoCompleto(){
	if (!this.hayCupo()){
			throw new NoHayCupo("Ya se encuentran 10 jugadores estandar anotados")
		}
	}
	
	def  void sePuedeModificarPartidoConfirmado(){
		if (isPartidoConfirmado()){
			throw new PartidoConfirmado("No es posible añadir jugadores, el partido ya se encuentra confirmado")
		}
	}
	
	def agregarJugadorALaLista(Jugador jugador){
			jugadores.add(jugador)
			jugador.setTimestamp(indice)
			indice=indice+1	
			jugadores.sort(new JugadorComparator(this)) 
	}
	
	def boolean hay10JugadoresConfirmados(){
		return jugadores.filter[jugador | jugador.juega(this)].size()>=10
	}
	
	def List<Jugador> finalizarInscripcion(){
		
		if(this.hay10JugadoresConfirmados()){
			
			 return ((jugadores.filter[juega(this)]).sort(new JugadorComparator(this))).toList.subList(0,10)
			
		}else
			throw new NoHay10Anotados("faltan jugadores")
			
	}
	
	
	def quitarJugador(Jugador jugador) {
		sePuedeModificarPartidoConfirmado()
		jugadores.remove(jugador)
		partidoObservers.forEach[ notifyBajaJugador(jugador, this)]
		jugador.generarInfraccion(dia,"Se dio de baja sin reemplazo")
	}
	
	def quitarJugador(Jugador jugador, Jugador jugadorReemplazo){
		sePuedeModificarPartidoConfirmado()
		jugadores.remove(jugador)
		agregarJugadorALaLista(jugadorReemplazo)
		partidoObservers.forEach[ notifyAltaJugador(jugadorReemplazo, this)]
	}
	
	def proponerJugador(Jugador jugador){
		jugador.setearTipoPendiente(this)
		agregarJugador(jugador)
	}	
	
	def List<Jugador> jugadoresDenegados(){
	return jugadores.filter[jugador |jugador.esDenegado(this)].toList
	}
	def List<Jugador> jugadoresPendientes(){
	return jugadores.filter[jugador |jugador.esPendiente(this)].toList
	}
	
	def List<Jugador> ordenarPor(List<Jugador> jugadoresInscriptos, CriterioOrden criterioOrden){
		jugadoresInscriptos.sortBy[ jugador | criterioOrden.valuarJugador(jugador)].reverse()
		
	}
	
	def void dividirEquiposPor(List<Jugador> jugadoresOrdenados, CriterioDivision criterioDivision){
		equipoA = criterioDivision.dividir(jugadoresOrdenados)
		equipoB = jugadoresOrdenados.filter[ jugador | !equipoA.contains(jugador)].toList()
	}
	
	def void generarEquiposTentativos(CriterioOrden criterioOrden, CriterioDivision criterioDivision){
		finalizarInscripcion.ordenarPor(criterioOrden).dividirEquiposPor(criterioDivision)
	}
	
	def void confirmarPartido(){
		setPartidoConfirmado(true);
	}

	
}