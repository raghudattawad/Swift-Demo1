//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Raghavendra Dattawad on 12/20/17.
//  Copyright © 2017 Raghavendra Dattawad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON




class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

@IBOutlet weak var tableView: UITableView!
    
    
    var  contactNames = [String]()
    var contactEmailAddreess = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        Alamofire.request("http://api.androidhive.info/contacts").responseJSON {
            (responsseData) -> Void in
            
            
            if responsseData.result.isSuccess
    {
                let resJson = JSON(responsseData.result.value!)
                
                
         let json =       JSON (resJson["contacts"])
               
                
       for conNamesDetails in json.array! {
        
        let nameString:String? = conNamesDetails["name"].stringValue
        let emailAddress:String? = conNamesDetails["email"].stringValue
        
        
        
        /// append array //
        self.contactNames.append(nameString!)
        self.contactEmailAddreess.append(emailAddress!)
        
            }
            
                
       self.tableView.reloadData()
         
            
    }
            if responsseData.result.isFailure {
                let error : NSError = responsseData.result.error! as NSError
            print(error)
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactNames.count;
      
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = self.contactNames[indexPath.row]
        
        cell.detailTextLabel?.text = self.contactEmailAddreess[indexPath.row]
        return cell
        
    }
    
}

