//
//  ViewControllerHelper.swift
//  WeatherSearchExample
//
//  Created by Karapats on 21/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showTextAlert(title:String,text:String, okaction: @escaping (UIAlertAction)->Void){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okaction))
        self.present(alert, animated: true)
    }
    
    
    func setupActivityIndicator()->UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        return indicator
    }
    
    func start(indicator: UIActivityIndicatorView){
        indicator.startAnimating()
    }
    
    func stop(indicator:UIActivityIndicatorView){
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
    
    func formatDate(dateMillis:Int) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd.MM  HH:mm a"
        let dateString = Date(timeIntervalSince1970: Double(dateMillis))
        return  dateFormatterGet.string(from: dateString)
    }
    
}
