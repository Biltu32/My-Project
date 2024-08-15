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
    
    func dateTitle(dateToConvert : String)-> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateTaken = dateFormatter.date(from: dateToConvert)
        dateFormatter.dateFormat = "EEEE"
        let resultDate = dateFormatter.string(from: dateTaken!)
        return resultDate
    }
    
    func currentweathergetting (baseUrl:String) {
        print("API calling")
        API_Manager.sharedInstance.weatherDetails(baseURL: baseUrl) { result, status, message in
            guard let response = result else { return }
            self.todayWeather = response
            DispatchQueue.main.async {
                self.labelPlace.text = self.todayWeather?.timezone
                let weatherTemp = self.todayWeather?.currentConditions?.temp
                let temperature  = ((weatherTemp ?? 0.0) - 32.0) * 5.0 / 9.0
                self.labelTemp.text = String(format: "%.1f", temperature) + "° C"
                let valueMaxtemp = self.todayWeather?.days?[0].tempmax
                let temperatureMax  = ((valueMaxtemp ?? 0.0) - 32.0) * 5.0 / 9.0
                self.labelMaxtempVC.text = "H: " + String(format: "%.1f", temperatureMax)
                let valueMintemp = self.todayWeather?.days?[0].tempmin
                let temperatureMin  = ((valueMintemp ?? 0.0) - 32.0) * 5.0 / 9.0
                self.labelMintempVC.text = "L: " + String(format: "%.1f", temperatureMin)
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
        cellValue.labelDay.text = dateTitle(dateToConvert: todayWeather?.days?[indexPath.row].datetime ?? "Nil")
        let temparatureMax = todayWeather?.days?[indexPath.row].tempmax
        let max  = ((temparatureMax ?? 0.0) - 32.0) * 5.0 / 9.0
        let temparatureMin = todayWeather?.days?[indexPath.row].tempmin
        let min  = ((temparatureMin ?? 0.0) - 32.0) * 5.0 / 9.0
        cellValue.labelMaxtemp.text = "Max " + String(format: "%.1f", max)
        cellValue.labelMintemp.text =  "Min " + String(format: "%.1f", min)
        return cellValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
