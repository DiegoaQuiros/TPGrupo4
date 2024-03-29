package ar.edu.dds.utn.observers
import java.util.Map
import java.util.HashMap
import java.util.HashSet
import java.util.Set

class StubMailSender implements MessageSender {
	Map<String, Set<String>> mailsEnviados
	
	override send(Mail mail) {
		simularEnvioMail(mail.from, mail.message)
		println("Simulación envío de mail | From: " + mail.from + " | To: " + mail.to + " | Message: " + mail.message)
	}
	
	def simularEnvioMail(String from, String message) {
		var mensajes = mailsDe(from)
		mensajes.add(message)
		mailsEnviados.put(from, mensajes)
	}
	
	def Set<String> mailsDe(String from) {
		var Set<String> mensajes = mailsEnviados.get(from)
		if (mensajes == null) {
			mensajes = new HashSet<String>
		}
		mensajes
	}
	def Set<String> mailsTo(String to) {
		var Set<String> mensajes = mailsEnviados.get(to)
		if (mensajes == null) {
			mensajes = new HashSet<String>
		}
		mensajes
	}
	

	static StubMailSender instance

	
	private new() {
		mailsEnviados = new HashMap<String, Set<String>>
	}

	def static getInstance() {
		if (instance == null) {
			instance = new StubMailSender()
		}	
		instance
	}
	
}