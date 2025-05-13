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
        setupTableView()
        bindViewModel()
        viewModel.loadUser()
        viewModel.loadRoutes()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "AvailableBusesCardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AvailableBusesCardTableViewCell")
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func bindViewModel() {
        viewModel.onUserDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                guard let user = self?.viewModel.user else { return }
                self?.salutation.text = "Hi "+user.name
            }
        }
        
        viewModel.onRoutesDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableBusesCardTableViewCell", for: indexPath) as? AvailableBusesCardTableViewCell else {
            return UITableViewCell()
        }
        let route = viewModel.routes[indexPath.row]
        cell.fromCity.text = route.source
        cell.toCity.text = route.destination
        cell.companyName.text = route.companyName
        cell.fromTime.text = "From: "+route.departure
        cell.toTime.text = "To: "+route.arrival
        cell.routeNumber.text = route.routeNumber
        cell.duration.text = route.duration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.selectedID = viewModel.routes[indexPath.row].id
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
}
