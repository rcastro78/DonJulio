//
//  FavoritosTableViewController.swift
//  Don Julio
//
//  Created by Rafael David Castro Luna on 3/8/17.
//  Copyright © 2017 com.hn. All rights reserved.
//

import UIKit

class FavoritosTableViewController: UITableViewController{

    var data: NSMutableData = NSMutableData()
    var recetas = [Favorito]()
    
    @IBOutlet var tblFavoritos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo_app.jpg")!)
        let idDispositivo:String = UIDevice.current.identifierForVendor!.uuidString
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetasFavoritas.php?deviceId="+idDispositivo
        print(idDispositivo)
        let _url = URL(string: address);
        getRecetasFavoritas(url: _url!)
        tblFavoritos.delegate = self
        tblFavoritos.dataSource = self
        
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
      let favorita = self.recetas[indexPath.row]
        let alertController = UIAlertController(title:favorita.nombre,message:"Recetas favoritas",preferredStyle:.alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController,animated: true, completion: nil)
        
    }
        
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetas.count;
    }
    
    override func tableView( _ t : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let celda = t.dequeueReusableCell(withIdentifier: "Cell",for:indexPath) as! FavoritoTableViewCell;
        let receta = recetas[indexPath.row]
        celda.lblNombre?.text = receta.nombre
        celda.lblFecha?.text = receta.fecha
        celda.lblIdReceta?.text = receta.idReceta
        let _url = URL(string:receta.urlImagen)
        let data = try? Data(contentsOf: _url!)
        
        
        if data != nil {
            let image = UIImage(data: data!)
            celda.imgReceta.image = image
        }
        
        return celda
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="recetaFavSegue"){
            if let indexPath = self.tblFavoritos.indexPathForSelectedRow{
                let selFavorito = self.recetas[indexPath.row]
                let destinoViewController = segue.destination as! RecetaViewController
                UserDefaults.standard.set(selFavorito.idReceta, forKey: "idReceta")
                UserDefaults.standard.set(1, forKey:"tipo")
            }
        }
    }
    

  
    func getRecetasFavoritas(url: URL) {
        
       
        
            URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let datos = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:Any]] {
            
                if (((datos)?.count)!>0){
                    for index in 0...((datos)?.count)! - 1
                    {
                        let obj = datos![index] as [String : AnyObject]
                        
                        let nombre = obj["nombre"] as! String
                        let fechaMod = obj["fechaAgregado"] as! String
                        let urlImagen = obj["urlImagen"] as! String
                        let idReceta = obj["idReceta"] as! String
                        
                        
                        self.recetas.append(Favorito(idReceta:idReceta,nombre:nombre,urlImagen:"http://lamadriguerabrandstudio.com/DonJulioWeb/imgRecetas/"+urlImagen,fecha:fechaMod))
                        
                    }
                    OperationQueue.main.addOperation {
                        //self.tableView.reloadData()
                        self.tblFavoritos.reloadData()
                    }
                    
                }else{
                    let alert = UIAlertController(title: "Las Recetas de Don Julio", message: "No existen recetas favoritas", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
 
                }
                    
                }
                
            
            }.resume()
        
        
      }

    
}


