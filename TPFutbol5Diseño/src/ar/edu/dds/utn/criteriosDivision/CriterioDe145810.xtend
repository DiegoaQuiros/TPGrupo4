package ar.edu.dds.utn.criteriosDivision

import ar.edu.ddsutn.Jugador
import java.util.List
import java.util.ArrayList

class Criterio145810 implements CriterioDivision{
	
	
	
	override List<Jugador> dividir(List<Jugador> jugadores){
		
		val list = new ArrayList<Jugador>
		
		list.add(jugadores.get(0));
		list.add(jugadores.get(3));
		list.add(jugadores.get(4));
		list.add(jugadores.get(7));
		list.add(jugadores.get(9));
		
		return list
	}
		
		
	
}
