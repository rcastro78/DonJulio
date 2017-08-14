//
//  Favorito.swift
//  Don Julio
//
//  Created by Rafael David Castro Luna on 3/8/17.
//  Copyright © 2017 com.hn. All rights reserved.
//


class Favorito{
    var idReceta:String
    var nombre:String
    var urlImagen:String
    var fecha:String
    
    init(idReceta:String, nombre:String, urlImagen:String, fecha:String) {
        self.idReceta = idReceta
        self.nombre = nombre
        self.urlImagen = urlImagen
        self.fecha = fecha
    }
    
    
}
