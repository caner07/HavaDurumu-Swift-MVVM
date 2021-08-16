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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        
    }
    @IBAction func addCityButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "addCity", sender: self)
    }
    

}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNames", for: indexPath) as! CityNamesTableViewCell
        cell.cityNameLabel.text = "Çanakkale"
        cell.backgroundColor = UIColor(named: "DayBlue")
        let image = UIImage(named: "DayBackground")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        cell.backgroundView = imageView
        return cell
    }
    
    
}

