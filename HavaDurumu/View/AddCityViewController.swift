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
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        searchBar.delegate = self
        
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func searchLocationButtonTapped(_ sender: UIButton) {
        showIndicator()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
}
extension AddCityViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        çağrı
        
        self.searchBar.text = ""
        self.searchBar.placeholder = "Şehir Arayın..."
        
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        }else{
            return false
        }
    }
    
}
//MARK: - Location
extension AddCityViewController : CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            lookUpCurrentLocation { place in
                self.searchBar.text = place?.administrativeArea
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
