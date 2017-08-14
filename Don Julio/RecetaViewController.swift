//
//  RecetaViewController.swift
//  Don Julio
//
//  Created by Rafael David Castro Luna on 3/8/17.
//  Copyright © 2017 com.hn. All rights reserved.
//

import UIKit
import Swift_YouTube_Player
class RecetaViewController: UIViewController {

    @IBOutlet weak var imgReceta: UIImageView!
    @IBOutlet weak var txtDescripcion: UITextView!
    
    
    var data: NSMutableData = NSMutableData()
    var recetas = [Receta]()
    var idReceta:String = ""
    var tipo:Int = 0
    var recetaAgregada:Bool=false
   
   
    @IBOutlet weak var lblTiempoCoccion: UILabel!
    @IBOutlet weak var lblPreparacion: UILabel!
    @IBOutlet weak var lblPorciones: UILabel!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var btnIngredientes: UIButton!
    @IBOutlet weak var btnPasos: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo_app.jpg")!)
        self.navigationController?.navigationBar.isHidden=false
        
        let fontDescr = UIFont(name: "gotham-rounded-medium", size: 14)

        idReceta = UserDefaults.standard.string(forKey: "idReceta")!
        tipo = UserDefaults.standard.integer(forKey:"tipo")
        
        if(tipo==2){
            btnIngredientes.setImage(UIImage(named:"ingredientes"), for:UIControlState.normal)
            btnPasos.setImage(UIImage(named:"proceso_selec"), for:UIControlState.normal)
        }
        
        if(tipo==1){
            btnIngredientes.setImage(UIImage(named:"ingredientes_selec"), for:UIControlState.normal)
            btnPasos.setImage(UIImage(named:"proceso"), for:UIControlState.normal)
        }
       
        
        txtDescripcion.font = fontDescr
        
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetaId.php?idReceta="+idReceta
        let _url = URL(string: address);
        getDataFromURL(url: _url!)
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   
    
    
    
    @IBAction func btnIngredientesClick(_ sender: UIButton) {
        btnIngredientes.setImage(UIImage(named:"ingredientes_selec"), for:UIControlState.normal)
        btnPasos.setImage(UIImage(named:"proceso"), for:UIControlState.normal)
        txtDescripcion.text=""
        txtDescripcion.text = recetas[0].ingredientes
    }
   
    
    @IBAction func btnProcesoClick(_ sender: UIButton) {
        btnIngredientes.setImage(UIImage(named:"ingredientes"), for:UIControlState.normal)
        btnPasos.setImage(UIImage(named:"proceso_selec"), for:UIControlState.normal)
        txtDescripcion.text=""
        txtDescripcion.text = recetas[0].pasos
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
                    
                    print(nombre)
                    
                }
                OperationQueue.main.addOperation {
                    let _urlImagen = URL(string:self.recetas[0].urlImagen)
                    let data = try? Data(contentsOf: _urlImagen!)
                    
                    
                    if data != nil {
                        let image = UIImage(data: data!)
                        self.imgReceta.image = image
                    }
                    
                    if (self.tipo==1)
                    {
                       self.txtDescripcion.text = self.recetas[0].ingredientes
                    }
                    
                    if (self.tipo==2)
                    {
                        self.txtDescripcion.text = self.recetas[0].pasos
                    }
                    
                    
                    self.lblTiempoCoccion.text = self.recetas[0].tiempoCoccion
                    
                    self.lblPorciones.text = self.recetas[0].porciones+" porciones"
                    
                    self.lblPreparacion.text = self.recetas[0].tiempoPrep
                    
                    
                    //self.navigationController?.title = self.recetas[0].nombre
                    self.title = self.recetas[0].nombre
                }
            }
            
            
            
            
            
            
            }.resume()
        
        
    }

    
    @IBAction func btnAddFavoritoClick(_ sender: UIBarButtonItem) {
        
        //Agregar la receta a favoritos
        let idDispositivo:String = UIDevice.current.identifierForVendor!.uuidString
        let address="http://lamadriguerabrandstudio.com/serviciosdj/addFavorita.php?imei="+idDispositivo+"&idReceta="+idReceta
        let _url = URL(string: address);
        crearFavorita(url: _url!)
    }
    
    
    
    @IBAction func btnVideoPlayerClick(_ sender: UIButton) {
        let vidUrl:String = recetas[0].urlVideo
        let video = URL(string:vidUrl)
        videoPlayer.loadVideoURL(video!)
    }
    
    
    func crearFavorita(url: URL) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let datos = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:Any]] {
                for index in 0...((datos)?.count)! - 1
                {
                    let obj = datos![index] as [String : AnyObject]
                    let idFav = obj["id"] as! String
                    if (idFav != "-1"){
                        self.recetaAgregada=true
                    }else{
                        self.recetaAgregada=false
                    }
                    
                    
                }
                OperationQueue.main.addOperation {
                    if (self.recetaAgregada){
                        let alert = UIAlertController(title: "Las Recetas de Don Julio", message: "La receta ha sido agregada a sus favoritos", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        
                        let alert = UIAlertController(title: "Las Recetas de Don Julio", message: "La receta no se puede agregar", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)

                    }
                }
                
            }
            }.resume()
    }

}
