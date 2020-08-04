//
//  TweetsDetailsViewController.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 04/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import UIKit

class TweetsDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /// MARK: Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TweetsDetailsCell

        return cell
        
    }
    

}
