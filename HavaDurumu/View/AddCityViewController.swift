//
//  AddCityViewController.swift
//  HavaDurumu
//
//  Created by Caner on 13.08.2021.
//

import UIKit

class AddCityViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func searchLocationButtonTapped(_ sender: UIButton) {
        
    }
    
}
