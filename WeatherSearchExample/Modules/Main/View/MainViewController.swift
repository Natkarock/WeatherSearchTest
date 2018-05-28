//
//  MainViewController.swift
//  WeatherSearchExample
//
//  Created by Karapats on 23/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import UIKit
import RealmSwift

protocol MainVProtocol {
    func setForecast(data: WeatherResponse)
    func showError(text:String)
}
class MainViewController: UIViewController, MainVProtocol {
    
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var btnToList: UIButton!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var imgBack: UIImageView!
    var mainPresenter: MainPProtocol!
    var weatherResponse: WeatherResponse? = nil
    var weatherList: List <WeatherEntity>? {
        get{
            guard let list = weatherResponse?.list else {
                return List<WeatherEntity>()
            }
            return list
        }
    }
    let searchController = UISearchController(searchResultsController: nil)
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        if weatherList?.count == 0 {
            hideViews()
        }
        if let cityName =  UserDefaults.standard.string(forKey: "currentCity"){
            getWeather(by: cityName)
        }
    }
    
    func initView(){
        mainPresenter = MainPresenter(view: self)
        btnToList.layer.cornerRadius = 10
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter the city"
        searchController.searchBar.text = UserDefaults.standard.string(forKey:"currentCity") ?? ""
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        activityIndicator = setupActivityIndicator()
    }
    
    func showViews(){
        btnToList.isHidden = false
        labelTemp.isHidden = false
        labelWeather.isHidden = false
        imgWeather.isHidden = false
    }
    
    
    func hideViews(){
        if labelTemp.alpha != 0{
            btnToList.center.y  += view.bounds.height
            imgWeather.center.y -= view.bounds.height
            btnToList.isHidden = true
            imgWeather.isHidden = true
            labelTemp.alpha = 0
            labelWeather.alpha = 0
        }
    }
    
    func animateViews(){
        UIView.animate(withDuration: 0.5, delay: 0.4,
                       animations: {
                        self.labelTemp.isHidden = false
                        self.labelWeather.isHidden = false
                        self.btnToList.isHidden = false
                        self.imgWeather.isHidden = false
                        self.labelTemp.alpha = 100
                        self.labelWeather.alpha = 100
                        self.btnToList.center.y  -= self.view.bounds.height
                        self.imgWeather.center.y += self.view.bounds.height
        },
                       completion: nil
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showError(text: String) {
        self.showTextAlert(title: "Error", text: text){
            action in         }
        stop(indicator: activityIndicator)
    }
    
    
    
    
    func setForecast(data: WeatherResponse) {
        weatherResponse = data        
        if let count =  weatherList?.count, count > 0, let cityName =  weatherResponse?.city?.name {
        if let weather = weatherList?[0]{
            labelWeather.text = formatDate(dateMillis: weather.dt)
            if  let temp = weather.main?.temp {
                labelTemp.text = String(Int(temp - 274))+" °"
            }
        }
            
        searchController.searchBar.text = cityName
        animateViews()
        self.stop(indicator: self.activityIndicator)
        UserDefaults.standard.set(cityName, forKey:"currentCity")
        UserDefaults.standard.synchronize()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "toWeatherList",
            let gamePickerViewController = segue.destination as? WeatherTableViewController {
            gamePickerViewController.weatherList = Array( weatherList ?? List<WeatherEntity>() )
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        guard let controller = segue.source as? MapViewController else {
           return
        }
        let marker = controller.marker
        let coordinate = marker.position
        searchController.searchBar.text = ""
        getWeather(by: coordinate.latitude, and: coordinate.longitude)
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


extension MainViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}


extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if  let text = searchController.searchBar.text {
            getWeather(by: text)
        }
    }
    
    func getWeather (by cityName: String){
        hideViews()
        start(indicator: activityIndicator)
        mainPresenter.getWeatherList(by: cityName)
    }
    
    func getWeather(by lat: Double,and lon: Double){
        hideViews()
        start(indicator: activityIndicator)
        mainPresenter.getWeatherList(by : lat, and: lon)
    }
    

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}
