import example.*
import comidas.*
import extras.*
import wollok.game.*

object pepita{

	var property energia = 100
	var property position = game.origin()

	method image() {
		return if (self.estaEnElNido()) "pepita-grande.png" else  if (self.position() == silvestre.position() or self.estaCansada()) "pepita-gris.png" else "pepita.png"
	}

	method come(comida) {
		energia = energia + comida.energiaQueOtorga()
		game.removeVisual(comida)
	}

	method encuentra_comida(){
		return position == (manzana.position() or alpiste.position())
	}

	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		if(!self.estaCansada() && (nuevaPosicion.x().between(0, 9) && nuevaPosicion.y().between(0, 9))){
			self.vola(position.distance(nuevaPosicion))
			position = nuevaPosicion
		}else{
			self.pepita_estrellada()
		}
	}

	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}

	method llegoAlNido(){
		return if (self.estaEnElNido()) nido.teEncontro(self)	
	}
	
	
	method estaEnElSuelo() {
		return position.y() == 0 
	}

	method pepita_estrellada(){
		if (self.estaEnElSuelo()) {game.stop()}
	}

	method atrapada(){
		if(self.position()==silvestre.position()){
			game.say(silvestre,"PERDISTE. FIN DEL JUEGO")
			game.schedule(2000, { game.stop() })
		}
		
	}

	
	method cayendo() {
	    if (position.y() > 0) { 
            position = position.down(1)
        }
	}

}

