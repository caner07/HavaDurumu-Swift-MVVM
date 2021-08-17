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
    let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        viewModel.delegate = self
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
    

}
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
    }
    
    
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weathersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNames", for: indexPath) as! CityNamesTableViewCell
        let weather = viewModel.weathersList[indexPath.row]
        cell.cityNameLabel.text = weather.city
        cell.degreeLabel.text = "\(weather.result[0].degree!.prefix(2))"
        let image = UIImage(named: "DayBackground")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        cell.backgroundView = imageView
        return cell
    }
    
    
}

