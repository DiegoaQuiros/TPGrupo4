package ar.edu.ddsutn

import ar.edu.dds.utn.exceptions.NoHay10Anotados
import ar.edu.dds.utn.exceptions.NoHayCupo
import java.util.Date
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import ar.edu.dds.utn.observers.StubMailSender
import ar.edu.dds.utn.observers.PartidoConfirmadoObserver
import ar.edu.dds.utn.observers.AmigosObserver
import ar.edu.dds.utn.exceptions.NoParticipo
import ar.edu.dds.utn.exceptions.PartidoConfirmado
import ar.edu.dds.utn.criteriosOrden.CriterioPromedioUltimoPartido
import ar.edu.dds.utn.criteriosOrden.CriterioPromedioNCalificaciones
import ar.edu.dds.utn.criteriosOrden.CriterioMix
import ar.edu.dds.utn.criteriosOrden.CriterioHandicap
import ar.edu.dds.utn.criteriosDivision.CriterioPariedad
import ar.edu.dds.utn.criteriosDivision.Criterio145810

class InscripcionTests {

	Partido partido
	Jugador jugador
	Jugador jugadorSol1
	Jugador jugadorSol2
	Jugador jugadorCondCumple
	Jugador jugadorCondNoCumple
	Jugador nuevoJugador
	Jugador nuevoJugador1
	Jugador nuevoJugador2
	StubMailSender stubMailSender
	
	@Before
    def void init (){
     	stubMailSender= StubMailSender.instance
        partido= new Partido()
        partido.partidoObservers.add(new PartidoConfirmadoObserver)
        partido.partidoObservers.add(new AmigosObserver)
		partido.setDia(new Date(114,4,30))
		
		
		
		for (i : 0 ..< 8){
	        jugador = new Jugador()
	        jugador.setearTipoEstandard(partido)
	        partido.agregarJugador(jugador)
		}
		
		jugadorSol1 = new Jugador()
		jugadorSol1.setearTipoSolidario(partido)
		partido.agregarJugador(jugadorSol1)
		
		//EL PARTIDO INICIA CON 8 ESTANDARES INSCRIPTOS y JugadorSol1 inscripto
		jugadorCondCumple= new Jugador()
		jugadorCondCumple.setearTipoCondicional(partido,[partido | partido.getDia.before(new Date(114,5,1))])
		jugadorCondNoCumple = new Jugador()
		jugadorCondNoCumple.setearTipoCondicional(partido,[partido | partido.getDia.before(new Date(114,3,1))])

    }
	
	@Test
    def void testJugadorSePuedeAgregar(){

		nuevoJugador = new Jugador()
		nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		Assert.assertTrue(partido.jugadores.contains(nuevoJugador));
    }
    
    @Test (expected=typeof(NoHay10Anotados))
    def void testEquipoCompleto() {
        partido.finalizarInscripcion();
    }
    
    @Test
    def void testJugadorCondicionalCumpleyJuega(){

    	partido.agregarJugador(jugadorCondCumple)
    	Assert.assertTrue(partido.finalizarInscripcion().contains(jugadorCondCumple))
    }
    
    @Test
    def void testJugadorCondicionalNoCumpleNoJuega(){
		//TERMINAR ESTO
		partido.agregarJugador(jugadorCondNoCumple)
		partido.agregarJugador(jugadorCondCumple)
    	Assert.assertFalse(partido.finalizarInscripcion().contains(jugadorCondNoCumple))
    }
    
    @Test
    def void testSeDesplazaAlPrimerSolidarioInscripto() {
    	jugadorSol2 = new Jugador()
    	jugadorSol2.setearTipoSolidario(partido)
		partido.agregarJugador(jugadorSol2)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoSolidario(partido)
        partido.agregarJugador(nuevoJugador)
        Assert.assertFalse(partido.finalizarInscripcion().contains(jugadorSol1))
    }
    
    @Test
    def void testSeDesplazaAlCondicional(){
    	partido.agregarJugador(jugadorCondCumple)
    	jugadorSol2 = new Jugador()
    	jugadorSol2.setearTipoSolidario(partido)
    	partido.agregarJugador(jugadorSol2)
    	Assert.assertFalse(partido.finalizarInscripcion().contains(jugadorCondCumple))	
    }
    
    @Test (expected=typeof(NoHayCupo))
    def void testNoSePuedeInscribirJugadorEstandar(){

		nuevoJugador = new Jugador()
		nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		
		nuevoJugador1 = new Jugador()
		nuevoJugador1.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador1)
		
		nuevoJugador2 = new Jugador()
		nuevoJugador2.setearTipoEstandard(partido) 
		partido.agregarJugador(nuevoJugador2)
		
    }
    
    //ENTREGA 2
    @Test
    def void testJugadorSeSacaDePartido(){
    	nuevoJugador = new Jugador()
		nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		partido.quitarJugador(nuevoJugador)
		Assert.assertFalse(partido.jugadores.contains(nuevoJugador))
    }
    
    @Test
    def void testJugadorRecibeInfraccion(){
    	nuevoJugador = new Jugador()
		nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		partido.quitarJugador(nuevoJugador)
		Assert.assertTrue(nuevoJugador.tieneInfracciones())
    }
    
    @Test
    def void testCambioJugadorAnteReemplazo(){
    	nuevoJugador = new Jugador()
		nuevoJugador.setearTipoEstandard(partido)
		nuevoJugador1 = new Jugador()
		nuevoJugador1.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		partido.quitarJugador(nuevoJugador, nuevoJugador1)
		Assert.assertTrue(partido.jugadores.contains(nuevoJugador1) && !(partido.jugadores.contains(nuevoJugador)))
    }
    
    @Test
    def void testBajaConCambioNoDaInfraccion(){
    	nuevoJugador = new Jugador()
		nuevoJugador.setearTipoEstandard(partido)
		nuevoJugador1 = new Jugador()
		nuevoJugador1.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		partido.quitarJugador(nuevoJugador, nuevoJugador1)
    	Assert.assertFalse(nuevoJugador.tieneInfracciones())	
    }
    
    @Test
    def void testJugadorAgregaAmigo(){
    	nuevoJugador = new Jugador()
    	nuevoJugador1 = new Jugador()
    	nuevoJugador.agregarAmigo(nuevoJugador1)
    	Assert.assertTrue(nuevoJugador.amigos.contains(nuevoJugador1))
    }
    
    @Test
    def void testAmigoFueNotificado(){
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
    	nuevoJugador.setMail("jugadorqueseinscribe@gmail.com")
    	nuevoJugador1 = new Jugador()
    	nuevoJugador1.setMail("mijugador@mimail.com")
    	nuevoJugador.agregarAmigo(nuevoJugador1)
    	partido.agregarJugador(nuevoJugador)
    	Assert.assertEquals(1, stubMailSender.mailsDe(nuevoJugador.getMail()).size)
    }
    
    	   
    // ENTREGA 3
 	@Test
    def void testJugadorFueCalificado(){
    	nuevoJugador = new Jugador()
		nuevoJugador.setearTipoEstandard(partido)
		nuevoJugador1 = new Jugador()
		nuevoJugador1.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador.calificar(nuevoJugador1, partido, 1, "Es de madera")
		
    }
    
    @Test (expected=typeof(NoParticipo))
    
    def void testJugadorNoPuedeSerCalificado(){
    	nuevoJugador = new Jugador()
		nuevoJugador.setearTipoEstandard(partido)
		nuevoJugador1 = new Jugador()
		nuevoJugador1.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
    	nuevoJugador.calificar(nuevoJugador1, partido, 1, "No Jugo, pero me cae mal y lo califico igual")
    }
    
    @Test 
    def void testJugadorPropuestoQuedaPendiente(){
    	nuevoJugador = new Jugador()
    	partido.proponerJugador(nuevoJugador)
    	Assert.assertTrue(partido.jugadoresPendientes.contains(nuevoJugador))
    }
    
    @Test
    def void testJugadorPentienteEsAceptadoYJuega(){
    	//AGREGO UN NUEVO ESTANDARD PARA ASEGURAR QUE HAYA 10 JUGADORES Y SE PUEDAN ARMAR EQUIPOS TENTATIVOS
    	nuevoJugador1 = new Jugador()
		nuevoJugador1.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador1)
		//SUGIERO UN JUGADOR
    	nuevoJugador = new Jugador()
    	partido.proponerJugador(nuevoJugador)
    	//ACEPTO AL JUGADOR
    	partido.jugadoresPendientes.forEach[jugador|jugador.aceptarJugador(new JugadorEstandard(jugador, partido),partido)]
    	Assert.assertTrue(partido.finalizarInscripcion.contains(nuevoJugador))
    }
    
    @Test
    def void testJugadorPendienteEsDenegadoYNoJuega(){
    	//AGREGO UN NUEVO ESTANDARD PARA ASEGURAR QUE HAYA 10 JUGADORES Y SE PUEDAN ARMAR EQUIPOS TENTATIVOS
    	nuevoJugador1 = new Jugador()
		nuevoJugador1.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador1)
		//SUGIERO UN JUGADOR
    	nuevoJugador = new Jugador()
    	partido.proponerJugador(nuevoJugador)
    	//ACEPTO AL JUGADOR
    	partido.jugadoresPendientes.forEach[jugador|jugador.denegarJugador("Me cae mal", partido)]
    	Assert.assertTrue(partido.jugadoresDenegados.contains(nuevoJugador))
    	Assert.assertFalse(partido.jugadores.filter[jugador|jugador.juega(partido)].toList.contains(nuevoJugador))
    }
    
    // ENTREGA 4
    
    @Test (expected=typeof(PartidoConfirmado))
    def void testPartidoConfirmadoYaNoSePuedeAgregarJugador(){
    	nuevoJugador1 = new Jugador()
    	nuevoJugador1.setearTipoEstandard(partido)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		partido.confirmarPartido()    	
		jugadorSol1 = new Jugador()
		partido.agregarJugador(jugadorSol1)
    }
    
    @Test (expected=typeof(PartidoConfirmado))
    def void testPartidoConfirmadoYaNoSePuedeQuitarJugador(){
    	nuevoJugador1 = new Jugador()
    	nuevoJugador1.setearTipoEstandard(partido)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		partido.confirmarPartido()    	
		jugadorSol1 = new Jugador()
		partido.quitarJugador(jugadorSol1)
    }
    
    @Test
    def void testCriterioPromedioUltimoPartido(){
    	nuevoJugador1 = new Jugador()
    	nuevoJugador1.setearTipoEstandard(partido)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		nuevoJugador1.calificar(nuevoJugador,partido,4,"Estuvo Flojo");
		jugador.calificar(nuevoJugador,partido,6,"Estuvo Flojo");
		val criterio = new CriterioPromedioUltimoPartido();
		Assert.assertEquals(5, criterio.valuarJugador(nuevoJugador))
    }
    
    @Test
    def void testCriterioHandicap(){
    	nuevoJugador1 = new Jugador()
    	nuevoJugador1.setearTipoEstandard(partido)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		nuevoJugador.setHandicap(5);
		val criterio = new CriterioHandicap();
		Assert.assertEquals(5, criterio.valuarJugador(nuevoJugador))
    }
    
    @Test
    def void testCriterioPromedioNCalificaciones(){
    	nuevoJugador1 = new Jugador()
    	nuevoJugador1.setearTipoEstandard(partido)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		nuevoJugador.calificar(nuevoJugador,partido,2,"Sorry, jugue como el orto")
		nuevoJugador1.calificar(nuevoJugador,partido,4,"Estuvo Flojo");
		jugador.calificar(nuevoJugador,partido,6,"Estuvo Flojo");
		val criterio = new CriterioPromedioNCalificaciones(2);
		Assert.assertEquals(5, criterio.valuarJugador(nuevoJugador))
    }
    
    @Test
    def void testCriterioMix(){
    	nuevoJugador1 = new Jugador()
    	nuevoJugador1.setearTipoEstandard(partido)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		nuevoJugador.calificar(nuevoJugador,partido,2,"Sorry, jugue como el orto")
		nuevoJugador1.calificar(nuevoJugador,partido,4,"Estuvo Flojo");
		jugador.calificar(nuevoJugador,partido,6,"Estuvo Flojo")
		val criterio1 = new CriterioPromedioNCalificaciones(2)
		val criterio2 = new CriterioPromedioUltimoPartido()
		val criterioMix = new CriterioMix()
		criterioMix.agregarCriterio(criterio1)
		criterioMix.agregarCriterio(criterio2)
		//COMO ES CON DOUBLE SOLICITA UN TERCER ARGUMENTO DELTA
		Assert.assertEquals(4, criterioMix.valuarJugador(nuevoJugador), 0.1)
    }
    
    
    @Test
    
    def void testPertenecePariedad(){
 	    
 	    nuevoJugador1 = new Jugador()
    	nuevoJugador1.setearTipoEstandard(partido)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		
		val criterioPariedad = new CriterioPariedad()
		
		Assert.assertTrue(criterioPariedad.dividir(partido.finalizarInscripcion()).contains(nuevoJugador1) && !criterioPariedad.dividir(partido.finalizarInscripcion()).contains(nuevoJugador))
	}
	@Test
	def void testPerteneceCriterio145810(){
 	    
 	    nuevoJugador1 = new Jugador()
    	nuevoJugador1.setearTipoEstandard(partido)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		for (i:1..10){
			partido.finalizarInscripcion.get(i-1).setHandicap(i)
		}
		val criterioOrden = new CriterioHandicap()
		val jugadoresOrdenados = partido.ordenarPor(partido.finalizarInscripcion, criterioOrden)
		val criterioDivision = new Criterio145810()
		val jugadoresDivididos = criterioDivision.dividir(jugadoresOrdenados)
		Assert.assertTrue(jugadoresDivididos.contains(jugadoresOrdenados.get(1-1))&&jugadoresDivididos.contains(jugadoresOrdenados.get(4-1))&&jugadoresDivididos.contains(jugadoresOrdenados.get(5-1))&&!jugadoresDivididos.contains(jugadoresOrdenados.get(2-1)))
	}
	@Test
	def void testGenerarEquiposTentativos(){
		 nuevoJugador1 = new Jugador()
    	nuevoJugador1.setearTipoEstandard(partido)
    	partido.agregarJugador(nuevoJugador1)
    	nuevoJugador = new Jugador()
    	nuevoJugador.setearTipoEstandard(partido)
		partido.agregarJugador(nuevoJugador)
		for (i:1..10){
			partido.finalizarInscripcion.get(i-1).setHandicap(i)
		}
		val criterioOrden = new CriterioHandicap()
		val jugadoresOrdenados = partido.ordenarPor(partido.finalizarInscripcion, criterioOrden)
		val criterioDivision = new Criterio145810()
		partido.generarEquiposTentativos(criterioOrden,criterioDivision)
		Assert.assertTrue(partido.getEquipoA.contains(jugadoresOrdenados.get(1-1))&&partido.getEquipoA.contains(jugadoresOrdenados.get(4-1))&&partido.getEquipoA.contains(jugadoresOrdenados.get(5-1))&&!partido.getEquipoA.contains(jugadoresOrdenados.get(2-1))&&partido.getEquipoB.contains(jugadoresOrdenados.get(2-1)))
		
	}
	
	
}

 