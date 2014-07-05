package ar.edu.dds.utn.observers

import ar.edu.ddsutn.Jugador
import ar.edu.ddsutn.Partido
import ar.edu.dds.utn.exceptions.NoHayCupo

class PartidoConfirmadoObserver implements PartidoObserver {

boolean partidoConfirmado

new(){
	partidoConfirmado = false
}

override notifyAltaJugador(Jugador jugador, Partido partido){
	if(partidoConfirmado == false && partido.hay10JugadoresConfirmados()){
		enviarMailConfirm(partido.getStringFecha())	
		partidoConfirmado = true
	}
}

def enviarMailConfirm(String fecha) {
		var mail = new Mail()
		mail.from = "sistemafutbol5@misistema.com"
		mail.to = "admin@misistema.com"
		mail.titulo = "Partido Completo"
		mail.message = "Las plazas de la fecha " + fecha + " estan completas"
		StubMailSender.instance.send(mail)
		}
	
override notifyBajaJugador(Jugador jugador, Partido partido){
	if (partidoConfirmado == true && !partido.hay10JugadoresConfirmados()){
		enviarMailNoConfirm(partido.getStringFecha())
		partidoConfirmado = false
	}

}

def enviarMailNoConfirm(String fecha) {
		var mail = new Mail()
		mail.from = "sistemafutbol5@misistema.com"
		mail.to = "admin@misistema.com"
		mail.titulo = "Partido Completo"
		mail.message = "Las plazas de la fecha " + fecha + " ya no estan completas"
		StubMailSender.instance.send(mail)
		}
}

