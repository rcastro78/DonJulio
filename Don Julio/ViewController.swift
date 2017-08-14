//
//  ViewController.swift
//  Don Julio
//
//  Created by Rafael David Castro Luna on 6/6/17.
//  Copyright © 2017 com.hn. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
var data: NSMutableData = NSMutableData()
var recetas = [Receta]()
    
    @IBOutlet weak var tblRecetas: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo_app.jpg")!)
        
        //Limpiar el objeto
        recetas.removeAll()
       
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetas.count;
    }
    
     func tableView( _ t : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let celda = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        //celda.textLabel?.text = recetas[indexPath.row].nombre
        
        let celda = t.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as! RecetaTableViewCell;
        let receta = recetas[indexPath.row]
        celda.lblReceta?.text = receta.nombre;
        
        
        let _url = URL(string:receta.urlImagen)
        let data = try? Data(contentsOf: _url!)
        
        
        if data != nil {
            let image = UIImage(data: data!)
            celda.imgReceta.image = image
        }
 
        
        
        return celda
    }
    
 
    
    
    
    func getDataFromURL(url: URL) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let datos = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:Any]] {
             for index in 0...((datos)?.count)! - 1
                {
                  let obj = datos?[index] as! [String : AnyObject]
                    
                  let nombre = obj["nombre"] as! String
                  let ingredientes = obj["ingredientes"] as! String
                  let pasos = obj["pasos"] as! String
                  let fechaMod = obj["fechaMod"] as! String
                  let orden = obj["orden"] as! String
                  let tiempoCocc = obj["tiempoCoccion"] as! String
                  let tiempoPrep = obj["tiempoPrep"] as! String
                  let porciones = obj["porciones"] as! String
                  let urlImagen = obj["urlImagen"] as! String
                  let urlVideo = obj["urlVideo"] as! String
                  let idReceta = obj["idReceta"] as! String

                    self.recetas.append(Receta(nombre: nombre, ingredientes: ingredientes, pasos: pasos, fechaMod: fechaMod, orden: orden, tiempoCoccion: tiempoCocc, tiempoPrep: tiempoPrep, porciones: porciones, urlImagen: "http://lamadriguerabrandstudio.com/DonJulioWeb/imgRecetas/"+urlImagen, urlVideo: urlVideo,idReceta:idReceta))
                    
                    
                }
                OperationQueue.main.addOperation {
                    //self.tableView.reloadData()
                    self.tblRecetas.reloadData()
                }
                
                
                                
                
                
            }
            }.resume()
        
        
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnDesayunoClick(_ sender: UIButton) {
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetas.php?tipo=1"
        let _url = URL(string: address);
        getDataFromURL(url: _url!)
       
    }
    
    
    @IBAction func btnAlmuerzoClick(_ sender: UIButton) {
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetas.php?tipo=2"
        let _url = URL(string: address);
        getDataFromURL(url: _url!)
            }
    
    
    @IBAction func btnCenaClick(_ sender: UIButton) {
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetas.php?tipo=3"
        let _url = URL(string: address);
        getDataFromURL(url: _url!)
           }
    
    @IBAction func btnSnackClick(_ sender: UIButton) {
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetas.php?tipo=4"
        let _url = URL(string: address);
        getDataFromURL(url: _url!)
        
    }
    

}

