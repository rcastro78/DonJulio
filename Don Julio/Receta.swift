//
//  Receta.swift
//  Don Julio
//
//  Created by Rafael David Castro Luna on 1/8/17.
//  Copyright © 2017 com.hn. All rights reserved.
//



class Receta {

    var nombre:String
    var ingredientes:String
    var pasos:String
    var fechaMod:String
    var orden:String
    var tiempoCoccion:String
    var tiempoPrep:String
    var porciones:String
    var urlImagen:String
    var urlVideo:String
    var idReceta:String
    
    init(nombre:String, ingredientes:String, pasos:String, fechaMod:String, orden:String, tiempoCoccion:String, tiempoPrep:String, porciones:String, urlImagen:String, urlVideo:String, idReceta:String) {
        
        self.nombre = nombre
        self.ingredientes = ingredientes
        self.pasos = pasos
        self.fechaMod = fechaMod
        self.orden = orden
        self.tiempoPrep = tiempoPrep
        self.tiempoCoccion=tiempoCoccion
        self.porciones = porciones
        self.urlImagen = urlImagen
        self.urlVideo = urlVideo
        self.idReceta = idReceta
        
    }
}
