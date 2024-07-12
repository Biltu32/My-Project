//
//  ViewController.swift
//  Weather
//
//  Created by DAPL-Asset-210 on 12/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelWeathercondition: UILabel!
    @IBOutlet weak var labelMaxtempVC: UILabel!
    @IBOutlet weak var labelMintempVC: UILabel!
    @IBOutlet weak var tblvwdaytemp: UITableView!
    
    var todayWeather : Weather?
    var baseURL = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/22.595449,88.373993?key=4G3UG4GL3MRU57CUB9RGUQ59G"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentweathergetting(baseUrl: baseURL)
    }
    

    func dateFormatConvert(dateString: String) -> String?{
            let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let datetaken  = formatter.date(from: dateString)
                formatter.dateFormat = "dd-MM-yyyy"
                let resultDate = formatter.string(from: datetaken!)
                return resultDate
        }
    
    
    func currentweathergetting (baseUrl:String) {
     API_Manager.sharedInstance.weatherDetails(baseURL: baseUrl) { result, status, message in
     guard let response = result else { return }
     self.todayWeather = response
     DispatchQueue.main.async {
         self.labelPlace.text = self.todayWeather?.timezone
         
         let a = self.todayWeather?.currentConditions?.temp
         let x  = ((a ?? 0.0) - 32.0) * 5.0 / 9.0
         self.labelTemp.text = String(format: "%.1f", x) + "° C"
         
         let b = self.todayWeather?.currentConditions?.tempmax
         let y  = ((b ?? 0.0) - 32.0) * 5.0 / 9.0
         self.labelMaxtempVC.text = "H:" + String(format: "%.1f", y)
        
         let c = self.todayWeather?.currentConditions?.tempmin
         let z  = ((c ?? 0.0) - 32.0) * 5.0 / 9.0
         self.labelMintempVC.text = "L: " + String(format: "%.1f", z)
         
         self.tblvwdaytemp.register(UINib(nibName: "Weatherdetails", bundle: nil), forCellReuseIdentifier: "celldaytemp")
         self.tblvwdaytemp.delegate = self
         self.tblvwdaytemp.dataSource = self
         self.tblvwdaytemp.reloadData()
            }
        }
    }
    

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayWeather?.days?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellValue = tblvwdaytemp.dequeueReusableCell(withIdentifier: "celldaytemp", for: indexPath) as! Weatherdetails
        cellValue.labelDay.text = dateFormatConvert(dateString: todayWeather?.days?[indexPath.row].datetime ?? "Nil")
        let d = todayWeather?.days?[indexPath.row].tempmax
        let max  = ((d ?? 0.0) - 32.0) * 5.0 / 9.0
        print(max)
        let e = todayWeather?.days?[indexPath.row].tempmin
        let min  = ((e ?? 0.0) - 32.0) * 5.0 / 9.0
        print(min)
        cellValue.labelMaxtemp.text = "Max " + String(format: "%.1f", max)
        cellValue.labelMintemp.text =  "Min " + String(format: "%.1f", min)
        
        return cellValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

}
