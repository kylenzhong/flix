//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Kyle Zhong  on 2/5/18.
//  Copyright © 2018 Kyle Zhong . All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource{


    @IBOutlet weak var tableView: UITableView!
    

    var movies: [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request){
            (data, response, error) in
            // This wil run when the network request returns
            if let error = error{
                print(error.localizedDescription)
            }else if let data = data{
                let dataDictionary = try!JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String : Any]]
                self.movies = movies
                self.tableView.reloadData()
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
  /*
        let movies = self.movies[indexPath.row]
        let title = movies["title"] as! String
        let overview = movies["overview"] as! String
        cell.titleLabel.text = title
        cell.overViewLabel.text = overview
        
        let posterPathString = movies["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p"
        let posterURL = URL(string : baseURLString + posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterURL) */
        return cell
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
