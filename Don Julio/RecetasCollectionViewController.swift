//
//  RecetasCollectionViewController.swift
//  Don Julio
//
//  Created by Rafael David Castro Luna on 2/8/17.
//  Copyright © 2017 com.hn. All rights reserved.
//
import Swift_YouTube_Player
import UIKit

private let reuseIdentifier = "Cell"

class RecetasCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var data: NSMutableData = NSMutableData()
    var recetas = [Receta]()
    var vidBanner:String=""
  
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    @IBOutlet weak var bbtnDesayuno: UIBarButtonItem!
    @IBOutlet weak var bbtnAlmuerzo: UIBarButtonItem!
    @IBOutlet weak var bbtnCenas: UIBarButtonItem!
    @IBOutlet weak var bbtnSnacks: UIBarButtonItem!
    
    
    
    @IBOutlet weak var clvRecetas: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo_app.jpg")!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let _urlConfig = URL(string: "http://lamadriguerabrandstudio.com/serviciosdj/getConfig.php");
        getVideoConfig(url:_urlConfig!)
        // Register cell classes
        // Do any additional setup after loading the view.
        //videoPlayer.loadVideoID("Xdd0M2P_mKU")
        
        clvRecetas.delegate = self
        clvRecetas.dataSource = self
        
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetas.php?tipo=1"
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recetas.count
    }

     func collectionView(_ t : UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let celda = t.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,for:indexPath) as! RecetaCollectionViewCell;
        let receta = recetas[indexPath.row]
        
        celda.lblNombre?.text = receta.nombre;
        celda.lblIdReceta?.text = receta.idReceta;
        celda.lblVideo?.text = receta.urlVideo;
        
        
        
        let _url = URL(string:receta.urlImagen)
        let data = try? Data(contentsOf: _url!)
        
        
        if data != nil {
            let image = UIImage(data: data!)
            celda.imgReceta.image = image
            celda.imgReceta.layer.masksToBounds = true
            celda.imgReceta.layer.borderColor = UIColor.white.cgColor
            celda.imgReceta.layer.borderWidth = 5
        
            
            
        }
        // Configure the cell
    
        //Acciones de los botones
        celda.bIngredientes.addTarget(self, action: #selector(RecetasCollectionViewController.ingredientesAccion), for:.touchUpInside)
        celda.bProceso.addTarget(self, action: #selector(RecetasCollectionViewController.procesoAccion), for:.touchUpInside)
        celda.bVideo.addTarget(self, action: #selector(RecetasCollectionViewController.videoAccion), for:.touchUpInside)
       
        
        return celda
    }

    func ingredientesAccion() {
        self.performSegue(withIdentifier: "recetaSegue", sender: self)
        
    }
    
    func procesoAccion() {
        self.performSegue(withIdentifier: "recetaSegue", sender: self)
        
    }
    
    func videoAccion() {
        self.performSegue(withIdentifier: "videoSegue", sender: self)
        
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    
    func getVideoConfig(url:URL){
    
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let datos = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:Any]] {
                for index in 0...((datos)?.count)! - 1
                {
                    let obj = datos?[index] as! [String : AnyObject]
                    
                    let video = obj["valor"] as! String
                    self.vidBanner = video
                    let vidURL = URL(string:video)
                    self.videoPlayer.loadVideoURL(vidURL!)
                }
                OperationQueue.main.addOperation {
                
                }

            }
        }.resume()
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
                   self.clvRecetas.reloadData()
                }
            }
                
                
                
                
                
            
            }.resume()
        
        
    }

    
    
  
    
    
    
    @IBAction func bbtnDesayunoClick(_ sender: UIBarButtonItem) {
        
        bbtnDesayuno.tintColor = UIColor.yellow
        bbtnAlmuerzo.tintColor = UIColor.white
        bbtnCenas.tintColor = UIColor.white
        bbtnSnacks.tintColor = UIColor.white
        
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetas.php?tipo=1"
        let _url = URL(string: address);
        getDataFromURL(url: _url!)
        
        
    }
    
    
    
    
    
    @IBAction func bbtnAlmuerzoClick(_ sender: UIBarButtonItem) {
        
        recetas.removeAll()
        
        bbtnDesayuno.tintColor = UIColor.white
        bbtnAlmuerzo.tintColor = UIColor.yellow
        bbtnCenas.tintColor = UIColor.white
        bbtnSnacks.tintColor = UIColor.white
        
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetas.php?tipo=2"
        let _url = URL(string: address);
        getDataFromURL(url: _url!)
        
    }
    
    
    
    
    
    
   
    
    @IBAction func bbtnCenasClick(_ sender: UIBarButtonItem) {
        
        bbtnDesayuno.tintColor = UIColor.white
        bbtnAlmuerzo.tintColor = UIColor.white
        bbtnCenas.tintColor = UIColor.yellow
        bbtnSnacks.tintColor = UIColor.white
        
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetas.php?tipo=3"
        let _url = URL(string: address);
        getDataFromURL(url: _url!)
        
        
    }
    
    
    
   
    
    
    @IBAction func bbtnSnacksClick(_ sender: UIBarButtonItem) {
       
        bbtnDesayuno.tintColor = UIColor.white
        bbtnAlmuerzo.tintColor = UIColor.white
        bbtnCenas.tintColor = UIColor.white
        bbtnSnacks.tintColor = UIColor.yellow
        
        recetas.removeAll()
        let address="http://lamadriguerabrandstudio.com/serviciosdj/getRecetas.php?tipo=4"
        let _url = URL(string: address);
        getDataFromURL(url: _url!)
        
    }
    
    @IBAction func bbtnFavoritosClick(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "favoritosSegue", sender: self)
    }
    
    /*
   
     
    
 */
    

}
