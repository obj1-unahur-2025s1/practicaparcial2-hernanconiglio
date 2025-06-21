class Personaje {
    const property fuerza
    const inteligencia
    var property rol
    method potencialOfensivo() {
        return fuerza * 10 + rol.extra()
    }
    method esGroso() = self.esInteligente() || rol.esGroso(self)
    method esInteligente()
}

class Humano inherits Personaje{
    override method esInteligente() = inteligencia > 50
}

class Orco inherits Personaje {
    override method potencialOfensivo() {
        return
        if(rol.toString() == brujo.toString()) super() * 1.1
        else super()
    }
    override method esInteligente() = false
}

class Cazador {
  const mascota
  method extra() = mascota.potencialOfensivo()
  method esGroso(unPersonaje) = mascota.esLongeva()
}

object guerrero {
  method extra() = 100
  method esGroso(unPersonaje) = unPersonaje.fuerza() > 50
}

object brujo {
  method extra() = 0
  method esGroso(unPersonaje) = true
}

class Mascota {
    const fuerza
    var edad
    const garras

    method cumplirAños() {edad +=1}
    method potencialOfensivo() = if(garras) fuerza*2 else fuerza
    method esLongeva() = edad > 10
}

object noTieneMascota {
    method potencialOfensivo() = 0
    method esLongeva() = false
}

class Localidad {
    var ejercito
    method poderDefensivo() = ejercito.poderOfensivo()
    method serOcupada(unEjercito) 
}
class Aldea inherits Localidad {
    const maximaTropa
    method initialize() {
        if(maximaTropa<10) {
            self.error("La poblacion debe ser mayor a 10")
        }
        
    }
    override method serOcupada(unEjercito) {
        if(maximaTropa < unEjercito.tamaño()) {
            ejercito = new Ejercito(tropa=unEjercito.losMasPorderosos())
            unEjercito.quitarLosMasFuertes()
        }
        else {ejercito = unEjercito}
        
    }
}

class Ciudad inherits Localidad {
    override method poderDefensivo() = super() + 300
    override method serOcupada(unEjercito) {ejercito=unEjercito}
}

class Ejercito {
    const tropa = []
    method poderOfensivo() = tropa.sum({p=>p.potencialOfensivo()})
    method invadir(unaLocalidad) {
        if(self.puedeInvadir(unaLocalidad)) {
            unaLocalidad.serOcupada(self)
        }
    }
    method puedeInvadir(unaLocalidad) {
        return self.poderOfensivo() > unaLocalidad.poderDefensivo()
    }
    method tamaño() = tropa.size()
    method losMasPorderosos() = self.ordenadosLosMasPoderosos().take(10)
    method ordenadosLosMasPoderosos() = tropa.sortBy({t1,t2=>t1.potencialOfensivo()>t2.potencialOfensivo()})
    method quitarLosMasFuertes() {
        tropa.removeAll(self.losMasPorderosos())
    }
}
