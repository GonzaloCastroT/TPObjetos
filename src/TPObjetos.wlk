/* PUNTO 1 */
class Scalextric{
	var property precioInicial = 27300
	var property cantAutos = 2
	var property precioAutosExtra = 5250
	var property cantAutosExtra = 0
	
	method esValioso() = self.precio()>27500
	method precio() = precioInicial + cantAutosExtra*precioAutosExtra
	
}

class Yoyo{
	var property color = "azul"
	var property precioInicial = 5000
	var property adicionalColor = 1500
	
	method esValioso() = color=="azul" || color=="amarillo"
	method precio(){
		if(color=="azul" || color=="rojo")
		{return precioInicial+adicionalColor}
		return precioInicial
	}
}

class Balero{
	var property tieneAdorno = false
	var property precioInicial = 14100
	var property adicionalAdorno = 1900
	
	method esValioso() = tieneAdorno
	method precio(){
		if(tieneAdorno)
		{return precioInicial + adicionalAdorno}
		return precioInicial
	}
}

/* PUNTO 2 */
object stefan{
	var property valorMaximo = 6000
	method aceptaRegalo(unRegalo){
		return !unRegalo.esValioso() && unRegalo.precio()<valorMaximo
		} 
}

object justina{
	var property edad = 11
	method aceptaRegalo(unRegalo){
		if( edad.odd() ){
			return unRegalo.esValioso()
		}
		return unRegalo.precio().between(1000,9999)
	}

}
object pedro{
	var property mejorAmigo = justina
	//const amistades = [justina, stefan] /* esto va¿?¿?¿? no me parece */
	method aceptaRegalo(unRegalo) = return mejorAmigo.aceptaRegalo(unRegalo)
}

/* PUNTO 3 */
object giftDealer{
    const property conocidos = [stefan, justina, pedro]
    const listaRegalos = [new Scalextric(), new Yoyo(), new Balero()]
    method inconformistas(){
        return conocidos.filter({unConocido => self.noAceptaRegalos(unConocido)})
    }
    method noEsInconformista(){
    	return conocidos.filter({unConocido => !self.noAceptaRegalos(unConocido)})
    }
    method noAceptaRegalos(unaPersona){
        return listaRegalos.filter({unRegalo => unaPersona.aceptaRegalo(unRegalo)}).isEmpty()
    }
    method regalosQueAcepta(unaPersona){
        return listaRegalos.filter({unRegalo => unaPersona.aceptaRegalo(unRegalo)})
    }
    method regaloAceptadoMasBarato(unaPersona){
		return self.regalosQueAcepta(unaPersona).min({unRegalo=>unRegalo.precio()})
    }
}

/* PUNTO 4 */
object nazarena{
	const numero = [1,2,3,4,5,6,7]
	method aceptaRegalo(_){
		return numero.anyOne() > 4
	}
}

class PersonaGenerica{
	var property nombre
	var property fechaNacimiento
	method aceptaRegalo(unRegalo){
		if(fechaNacimiento.year() < 1990)
		{
			return unRegalo.precio()>25000 
		}
		return unRegalo.precio()<50000
	}
}

class Ropa{
	var property tipo
	var property marca
	var property fechaConfeccion
	var property valorBase
	const marcasPlus = ["Jordache","Feraldy","Charro"]
	method precio(){
		var ret = valorBase
		if(marcasPlus.contains(marca)){
			ret += 5000
		}
		if( (new Date() - fechaConfeccion) > 90 ){
			ret *= 0.8
		}
		return ret
	}
}

/* PUNTO 5 */

object negocio{	
  	const property historicoVentas = []
    method regalar(){
        if(!giftDealer.inconformistas().isEmpty())
        {	giftDealer.inconformistas().forEach({unaPersona => 
        	self.registrarVenta(unaPersona,new Voucher())})
        }else{
        	giftDealer.noEsInconformista().forEach({unaPersona => 
        	self.registrarVenta(unaPersona,giftDealer.regaloAceptadoMasBarato(unaPersona))})
    	}
    }
    
    method registrarVenta(unaPersona,unRegalo){
    	historicoVentas.add(new HistorialVentas(personaCliente=unaPersona, regalo=unRegalo, 
    		precioVenta=unRegalo.precio() ))
    }
    
    method quienRecibioMasDineroEnRegalos(){
    	
    	return giftDealer.conocidos().max({unConocido => historicoVentas.
    		filter({unaVenta => unaVenta.personaCliente() == unConocido}).
    		sum({laVenta=>laVenta.precioVenta()})
    	})
    }
    
} 

class Voucher{
	var property monto = 5000
	var property fechaVencimiento = new Date().plusMonths(3)
	method esValioso() = true
}

class HistorialVentas{
	var property personaCliente
	var property regalo
	var property precioVenta
	var property fechaOperacion = new Date()
}

/* PUNTO 6 */

// ver punto 5 metodo quienRecibioMasDineroEnRegalos





