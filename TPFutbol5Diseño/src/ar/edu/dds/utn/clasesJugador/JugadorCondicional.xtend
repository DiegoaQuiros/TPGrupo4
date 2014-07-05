package ar.edu.dds.utn.clasesJugador
import java.util.function.Function

class JugadorCondicional extends ar.edu.ddsutn.TipoJugador{
	
		Function<ar.edu.ddsutn.Partido,Boolean> condicion
		
		new(ar.edu.ddsutn.Jugador miJugador, ar.edu.ddsutn.Partido miPartido, Function<ar.edu.ddsutn.Partido,Boolean> miCondicion){
			super(miJugador, miPartido)
			condicion = miCondicion
		}
						
		override String tipo() {
			return "Condicional"
		}
		
		override int prioridad() {
			return 3
		}
		
		override boolean juega(ar.edu.ddsutn.Partido partido){
			return condicion.apply(partido)
		}
		
		
	
}
