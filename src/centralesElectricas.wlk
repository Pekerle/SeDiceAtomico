object burns {
	
	var cantidadVarillas = 0
	
	method produccionEnergetica(ciudad) {
		return 0.1 * cantidadVarillas
	}
	
	method contamina() {
		return cantidadVarillas > 20
	}
	
	method cantidadVarillas(){
		return cantidadVarillas
	}

	method cantidadVarillas(nuevaCandidadVarillas){
		cantidadVarillas = nuevaCandidadVarillas
	}	
}

object exBosque {
	
	var capacidad = 1
	
	method produccionEnergetica(ciudad) {
		return 0.5 + capacidad * ciudad.riquezaDelSuelo()
	}
	
	method contamina() {
		return true
	}
	
	method capacidad(){
		return capacidad
	}

	method capacidad(nuevaCapacidad){
		capacidad = nuevaCapacidad
	}	
}

object elSuspiro {
	
	var turbinas = [turbinaEolica]

	method produccionEnergetica(ciudad){
		return turbinas.sum({ turbina => turbina.produccion(ciudad) })
	}

	method contamina(){
		return false
	}

	method turbinas(){
		return turbinas
	}

	method turbinas(nuevaTurbina){
		turbinas.add(nuevaTurbina)
	}
}

object turbinaEolica{
	
	method produccion(ciudad){
		return 0.2 * ciudad.velocidadDelViento()
	}
}

object plantaHidroelectrica{

	method produccionEnergetica(ciudad){
		return 2 * ciudad.caudalRio()
	}
}

object springfield {
	
	const velocidadDelViento = 10
	const riquezaDelSuelo = 0.9
	const centralesSpringfield = #{burns,exBosque,elSuspiro}
	var necesidadEnergetica = 0
	var suministroElectrico = 22
	
	method velocidadDelViento() {
		return velocidadDelViento
	}
	
	method riquezaDelSuelo() {
		return riquezaDelSuelo
	}
	
	method necesidadEnergetica() {
		return necesidadEnergetica
	}
	
	method necesidadEnergetica(nuevaNecesidadEnergetica) {
		return nuevaNecesidadEnergetica
	}
	
	method suministroElectrico() {
		return suministroElectrico
	}
	
	method centralesContaminantes(){
		return centralesSpringfield.filter({ centrales => centrales.contamina() })
	}

	method cubrioNecesidades(){
		return suministroElectrico > necesidadEnergetica 
	}

	method estaEnElHorno(){
		return self.todasLasCentralesContaminan() || self.centralesAportanMasDel50()
	}

	method todasLasCentralesContaminan(){
		return centralesSpringfield.size() == self.centralesContaminantes().size()
	}

	method centralesAportanMasDel50(){
		return self.centralesContaminantes().sum({ planta => planta.produccionEnergetica(self) }) >= necesidadEnergetica * 1.5
	}

	method laCentralQueMasProduce(){
		return centralesSpringfield.max({ centrales => centrales.produccionEnergetica(self) })
	}	

	method centrales(){
		return centralesSpringfield
	}
}

object albuquerque{

	const centralesAlbuquerque = #{plantaHidroelectrica}
	var caudalRio = 150

	method laCentralQueMasProduce(){
		return centralesAlbuquerque.max({ centrales => centrales.produccionEnergetica(self) })
	}	

	method caudalRio(){
		return caudalRio
	}	

	method caudalRio(nuevoCaudalRio){
		caudalRio = nuevoCaudalRio
	}

	method centrales(){
		return centralesAlbuquerque
	}
}

object region{

	const ciudadesDeLaRegion = #{springfield.centrales(),albuquerque.centrales()}
	
	method plantaMasProductoraDeLaRegion(){
		return ciudadesDeLaRegion.max({ ciudades => ciudades.laCentralQueMasProduce().produccionEnergetica(ciudades) })
	}
	
	method ciudades(){
		return ciudadesDeLaRegion
	}
}