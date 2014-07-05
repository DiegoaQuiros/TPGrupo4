package ar.edu.ddsutn
import java.util.concurrent.Callable

class Condicion {
	Partido partido
	Callable<Boolean> condicion
	
	
	new(Callable<Boolean> miCondicion, Partido miPartido){
		partido=miPartido
		condicion = miCondicion
	}
	def boolean seCumple(){
		return condicion.call()
		
	}

}
