//
//  HomeViewController.swift
//  HavaDurumu
//
//  Created by Caner on 13.08.2021.
//

import UIKit
import ANActivityIndicator
class HomeViewController: UIViewController {
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var footer: UIView!
    let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        viewModel.delegate = self
        isItNight()
    }
    @IBAction func addCityButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "addCity", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getCities()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToCity" {
            let vc = segue.destination as! WeatherViewController
            vc.weather = viewModel.selectedCity
        }
    }
    func isItNight(){
        let hour = Calendar.current.component(.hour, from: Date())
//        GÜNDÜZ
        if hour > 6 && hour < 18 {
            
            setDayUI()
        }
//        GECE
        else{
            setNightUI()
        }
    }
    func setNightUI(){
        self.view.backgroundColor = UIColor(named: "NightBlue")
        footer.backgroundColor = UIColor(named: "NightBlue")
        citiesTableView.backgroundColor = UIColor(named: "NightBlue")
        
    }
    func setDayUI(){
        self.view.backgroundColor = UIColor(named: "DayBlue")
        footer.backgroundColor = UIColor(named: "DayBlue")
        citiesTableView.backgroundColor = UIColor(named: "DayBlue")
        
    }
    

}
//MARK: - ViewModel Delegate
extension HomeViewController:HomeViewModelDelegate{
    
    func success(_ i: Int) {
        hideIndicator()
        if i != 0 {
            let indexPath = IndexPath(row: i, section: 0)
            citiesTableView.insertRows(at: [indexPath], with: .automatic)
        }else{
            citiesTableView.reloadData()
        }
        
    }
    
    func loading() {
        showIndicator()
    }
    
    
    func error() {
        hideIndicator()
        print("error")
    }
    
    
}
//MARK: - UITableView
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            viewModel.deleteCity(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weathersList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedCity = viewModel.weathersList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "homeToCity", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNames", for: indexPath) as! CityNamesTableViewCell
        let weather = viewModel.weathersList[indexPath.row]
        cell.setUI(cityName: weather.city, degree: "\(weather.result[0].degree!.prefix(2))",description: weather.result[0].description!)
        return cell
    }
    
    
}

