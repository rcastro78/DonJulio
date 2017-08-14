//
//  RecetaCollectionViewCell.swift
//  Don Julio
//
//  Created by Rafael David Castro Luna on 2/8/17.
//  Copyright © 2017 com.hn. All rights reserved.
//

import UIKit


class RecetaCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var imgReceta: UIImageView!
    @IBOutlet weak var lblVideo: UILabel!
    
    @IBOutlet weak var bVideo: UIButton!
    @IBOutlet weak var bIngredientes: UIButton!
    
    @IBOutlet weak var bProceso: UIButton!
    
    
    
    @IBOutlet weak var lblIdReceta: UILabel!
    @IBAction func btnVideo(_ sender: UIButton) {
         var vidUrl:String? = lblVideo.text
         let videoViewController = VideoViewController()
         UserDefaults.standard.set(vidUrl, forKey: "videoUrl")
         self.window?.rootViewController?.presentedViewController?.addChildViewController(videoViewController)
    }
    
    @IBAction func btnIngredientes(_ sender: UIButton) {
        var idReceta:String? = lblIdReceta.text
        var tipo:Int? = 1
        let recetaViewController = RecetaViewController()
        print("Ingredientes")
       
        UserDefaults.standard.set(idReceta, forKey: "idReceta")
        UserDefaults.standard.set(tipo, forKey:"tipo")
        self.window?.rootViewController?.presentedViewController?.addChildViewController(recetaViewController)
        
    }
    
    @IBAction func btnProceso(_ sender: UIButton) {
        let idReceta:String? = lblIdReceta.text
        let tipo:Int? = 2
        print("Proceso")
        let recetaViewController = RecetaViewController()
        UserDefaults.standard.set(idReceta, forKey: "idReceta")
        UserDefaults.standard.set(tipo, forKey:"tipo")
        self.window?.rootViewController?.presentedViewController?.addChildViewController(recetaViewController)
    }
    
    
}
