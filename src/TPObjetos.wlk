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
	const conocidos = [stefan, justina, pedro]
	method inconformistas(listaRegalos){
		return conocidos.filter({unConocido => listaRegalos.all({unRegalo => !unConocido.aceptaRegalo(unRegalo)})})
	}
	method inconformistas(listaPersonas, listaRegalos){
		return listaPersonas.filter({unConocido => listaRegalos.all({unRegalo => !unConocido.aceptaRegalo(unRegalo)})})
	}
	
}

/* PUNTO 4 */
object nazarena{
	const numero = [1,2,3,4,5,6,7]
	method aceptaRegalo(){
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
// a simple vista, la forma de implementar el proceso es con un objeto (como todo xd)
// la idea de este objeto es que se ocupe de manejar todo el proceso y sus metodos
object negocio{
	method correrProceso(listaPersonas){
		giftDealer.inconformistas(listaPersonas, [1]).forEach({unInconformista => unInconformista.aceptaRegalo( new Voucher() )}) //¿?¿?¿?
		
		//giftDealer.inconformistas([1]).forEach({unInconformista => unInconformista.aceptaRegalo(new Voucher(fechaVencimiento = new Date()))})
		
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