class Personaje {
    const fuerza
    const inteligencia
    var property rol
    method potencialOfensivo() {
        return
        fuerza * 10 + rol.extra()
    }
    method esGroso() = self.esInteligente() || self.esGrosoEnSuRol()
    method esInteligente()
    method esGrosoEnSuRol() = rol.esGroso(self)
}

class Orco inherits Personaje {
    override method potencialOfensivo() {
        return
        if(rol==brujo) super() * 1.1 else super()
    }
    override method esInteligente() = false
}

class Humano inherits Personaje {
    override method esInteligente() = inteligencia > 50
}

object guerrero {
    method extra() = 100
    method esGroso(unPersonaje) = unPersonaje.fuerza() > 50
}

class Cazador {
    const property mascota
    method extra() = mascota.extra()
    method esGroso(unPersonaje) = mascota.esLongeva()
}

object brujo {
    method extra() = 0
    method esGroso(unPersonaje) = true
}

class Mascota {
    const property fuerza
    var edad
    method cumplirAños() {edad += 1} 
    const property tieneGarras
    method extra() = if(tieneGarras) fuerza * 2 else fuerza
    method esLongeva() = edad > 10
}

class Localidad {
    var ejercito 
    method ejercito() = ejercito
    method poderDefensivo() = ejercito.poderOfensivo()
    method serOcupada(unEjercito)
}
class Aldea inherits Localidad {

    const cantidadMaximaHabitantes

    override method serOcupada(unEjercito) {
        if(unEjercito.personajes().size() > cantidadMaximaHabitantes) {
            ejercito = unEjercito.ejercitoMasFuerte()
        }
        else {ejercito = unEjercito}
    }
}

class Ciudad inherits Localidad{
    override method poderDefensivo() = super() + 300
    override method serOcupada(unEjercito) {
        ejercito = unEjercito
    }
}

class Ejercito {
    const property personajes = []
    method invadir(unaLocalidad) {
        if(self.puedeTomarLocalidad(unaLocalidad)) {
            unaLocalidad.serOcupada(self)
        }
    }
    method poderOfensivo() = personajes.sum({p=>p.potencialOfensivo()})
    method puedeTomarLocalidad(unaLocalidad) {
        return
        self.poderOfensivo() > unaLocalidad.poderDefensivo()
    }
    method ejercitoMasFuerte() = self.ordenadosLosMasPoderosos().take(10)
    method ordenadosLosMasPoderosos() {
        return
        personajes.sortBy({p1,p2=> p1.potencialOfensivo() > p2.potencialOfensivo()})
    }

}