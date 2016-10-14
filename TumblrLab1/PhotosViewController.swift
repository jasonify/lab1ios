//
//  ViewController.swift
//  TumblrLab1
//
//  Created by jason on 10/13/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts: [NSDictionary] = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 320
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    // NSLog("response: \(responseDictionary)")
                    if let response = responseDictionary["response"] as? NSDictionary {
                        self.posts = response["posts"] as! [NSDictionary]
                        print(self.posts)
                        self.tableView.reloadData()
                    }
                }
            }
        });
        task.resume()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.refreshAction), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at:0)
    }
    
    
    func refreshAction(refreshControl: UIRefreshControl){

        
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    // NSLog("response: \(responseDictionary)")
                    if let response = responseDictionary["response"] as? NSDictionary {
                        self.posts = response["posts"] as! [NSDictionary]
                        print(self.posts)
                        self.tableView.reloadData()
                        refreshControl.endRefreshing()
                        
                    }
                }
            }
        });
        task.resume()
        
        
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCellTableViewCell
        
        
        cell.titleLabel.text = "bloop \(indexPath.section)"
        
        
        // TODO: figure out how to index into array with forKeyPath
        let post = self.posts[indexPath.section]
        let photos = post.value(forKeyPath: "photos") as! [NSDictionary]
        let imageURL = photos[0].value(forKeyPath: "original_size.url") as! String
        
        print(imageURL)
        let url = NSURL(string: imageURL ) as! URL
       // let url = NSURL(string: "https://assets.tumblr.com/images/default_header/optica_pattern_11.png?_v=4275fa0865b78225d79970023dde05a1") as! URL
        cell.photoImageView.setImageWith(url)
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1;
        // return self.posts.count
        
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // set the avatar
        
        profileView.setImageWith(NSURL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")! as URL)
        headerView.addSubview(profileView)
        
        // Add a UILabel for the date here
        // Use the section number to get the right URL
        let label = "Sdfdsfds"
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 50
    }
    public func numberOfSections(in tableView: UITableView) -> Int{
        return self.posts.count
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // MARK: - Navigation
 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! PhotoDetailsViewController
        var indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
        vc.titleLabel = "\(indexPath?.row)"
        // TODO: figure out how to index into array with forKeyPath
        let post = self.posts[(indexPath?.row)!]
        let photos = post.value(forKeyPath: "photos") as! [NSDictionary]
        let imageURL = photos[0].value(forKeyPath: "original_size.url") as! String
        
        vc.imageURL = NSURL(string: imageURL ) as! URL
    }

}

