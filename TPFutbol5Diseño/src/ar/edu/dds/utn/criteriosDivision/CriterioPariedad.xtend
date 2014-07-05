package ar.edu.dds.utn.criteriosDivision

import ar.edu.ddsutn.Jugador
import java.util.List
import java.util.ArrayList

class CriterioPariedad implements CriterioDivision{
	
	
	
	override dividir(List<Jugador> jugadores){
		
		val list = new ArrayList<Jugador>
		
	for (i : 1 ..< 6){
		
		val n = (i*2) - 1
		
		list.add(jugadores.get(n))};	
		
		return list
	}
		
}
