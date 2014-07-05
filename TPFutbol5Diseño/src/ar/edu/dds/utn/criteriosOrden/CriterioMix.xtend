package ar.edu.dds.utn.criteriosOrden

import ar.edu.ddsutn.Jugador
import java.util.List
import java.util.ArrayList

class CriterioMix implements CriterioOrden{
	
	@Property List<CriterioOrden> lista
	
	new(){
		lista = new ArrayList<CriterioOrden>
	}
	def void agregarCriterio(CriterioOrden criterio){
		
		lista.add(criterio)
	}
	
	override int valuarJugador(Jugador jugador){

        val suma = lista.fold(0, [acum, criterio | acum + criterio.valuarJugador(jugador)])
	
	    return suma / lista.size()
	
   }


}