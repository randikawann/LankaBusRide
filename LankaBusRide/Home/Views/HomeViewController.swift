//
//  HomeViewController.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var salutation: UILabel!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        bindViewModel()
        viewModel.loadUser()
        viewModel.loadRoutes()
    }
    
    private func bindViewModel() {
        viewModel.onUserDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                guard let user = self?.viewModel.user else { return }
                self?.salutation.text = "Hi "+user.name
                //                self?.emailLabel.text = user.email
            }
        }
        
        viewModel.onRoutesDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1",for: indexPath) as! BusCardTableViewCell
        
        let route = viewModel.routes[indexPath.row]
        cell.titleHeader.text = route.title
        return cell
    }
}
