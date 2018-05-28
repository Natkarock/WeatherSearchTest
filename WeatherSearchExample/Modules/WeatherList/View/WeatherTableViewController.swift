//
//  WeatherTableViewController.swift
//  WeatherSearchExample
//
//  Created by Karapats on 21/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift



class WeatherTableViewController: UITableViewController {
    var weatherList: [WeatherEntity]? = []
    static let KtoC = 274
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        tableView.reloadData()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        let backgroundImage = #imageLiteral(resourceName: "footer_second")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFit
        tableView.backgroundView = imageView
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let weather = weatherList else { return 0}
        return weather.count
    }
    
    
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.backgroundColor = .clear
        if let weather = weatherList?[indexPath.row]{
                cell.labelDate.text = formatDate(dateMillis: weather.dt)
            if  let temp = weather.main?.temp {
                cell.labelWeather.text = String(Int(temp - 274))+" °C"
            }
        }
        return cell
    }
    
    
    func clearTable(){
        self.weatherList = []
        self.tableView.reloadData()
    }
    
    func isNeedUpdateCurrent()->Bool{
        guard let firstWeather = weatherList?[0] else {
            return false
        }
        let date = Date()
        if firstWeather.dt < Int(date.timeIntervalSince1970){
            return true
        }
        return false
    }
    
}

