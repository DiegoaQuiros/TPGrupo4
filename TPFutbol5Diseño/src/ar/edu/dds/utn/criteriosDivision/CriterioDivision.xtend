package ar.edu.dds.utn.criteriosDivision

import java.util.List
import ar.edu.ddsutn.Jugador

interface CriterioDivision{
	
	def List<Jugador> dividir(List<Jugador> jugadores)

}