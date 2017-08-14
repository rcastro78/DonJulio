//
//  VideoViewController.swift
//  Don Julio
//
//  Created by Rafael David Castro Luna on 4/8/17.
//  Copyright © 2017 com.hn. All rights reserved.
//

import UIKit
import Swift_YouTube_Player

class VideoViewController: UIViewController {

    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var videoUrl = UserDefaults.standard.string(forKey: "videoUrl")!
        let video = URL(string:videoUrl)
        videoPlayer.loadVideoURL(video!)
        // Do any additional setup after loading the view.
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

}
