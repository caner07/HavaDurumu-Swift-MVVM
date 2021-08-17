//
//  AddCityViewController.swift
//  HavaDurumu
//
//  Created by Caner on 13.08.2021.
//

import UIKit
import CoreLocation
import ANActivityIndicator
class AddCityViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var citiesTableView: UITableView!
    let viewModel = AddCityViewModel()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.title = "Vazgeç"
        navigationItem.backButtonTitle = "Vazgeç"
        locationManager.delegate = self
        searchBar.delegate = self
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        viewModel.delegate = self
        viewModel.getCities()
        
        
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        showIndicator()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
}
extension AddCityViewController:AddCityViewModelDelegate{
    func done() {
        navigationController?.popViewController(animated: true)
    }
    
    func loading() {
        showIndicator()
    }
    
    func locationSuccess() {
        hideIndicator()
    }
    
    func error() {
        hideIndicator()
    }
    
    func updateCities() {
        hideIndicator()
        citiesTableView.reloadData()
    }
    
    
}
extension AddCityViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.filteredData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCity = viewModel.filteredData[indexPath.row]
        viewModel.saveCity(cityName: selectedCity)
    }
    
    
}
extension AddCityViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCity(searchText)
    }
    
}
//MARK: - Location
extension AddCityViewController : CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil{
            locationManager.stopUpdatingLocation()
            lookUpCurrentLocation { place in
                self.viewModel.saveCity(cityName: (place?.administrativeArea!)!)
                self.hideIndicator()
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
}
