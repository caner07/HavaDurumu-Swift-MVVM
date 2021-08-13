//
//  HomeViewController.swift
//  HavaDurumu
//
//  Created by Caner on 13.08.2021.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
    }
    @IBAction func addCityButtonTapped(_ sender: UIButton) {
    }
    

}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNames", for: indexPath) as! CityNamesTableViewCell
        cell.cityNameLabel.text = "Çanakkale"
        return cell
    }
    
    
}

