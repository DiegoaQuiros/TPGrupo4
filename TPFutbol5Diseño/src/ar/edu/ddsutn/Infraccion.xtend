package ar.edu.ddsutn

import java.util.Date
import java.text.SimpleDateFormat

class Infraccion {
	@Property Date dia
	@Property String motivo
	
	new(Date date, String string) {
		motivo = string
		dia = date
	}
	
	def getStringFecha(){
		val formato = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss")
		formato.format(dia)
	}
}