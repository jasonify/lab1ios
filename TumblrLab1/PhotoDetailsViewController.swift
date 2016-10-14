//
//  PhotoDetailsViewController.swift
//  TumblrLab1
//
//  Created by jason on 10/13/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoDetail: UIImageView!
    @IBOutlet weak var titleDetail: UILabel!
    var imageURL: URL?
    var titleLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleDetail.text = titleLabel
        photoDetail.setImageWith(imageURL!)

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
