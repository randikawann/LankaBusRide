//
//  SearchViewController.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-12.
//

import UIKit

class SearchViewController: BaseViewController {
    @IBOutlet weak var recentsRouteTableView: UITableView!
    @IBOutlet weak var filteredBusRouteTableView: UITableView!
    @IBOutlet weak var routeNumberTextField: UITextField!
    
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupTableView()
        loadData()
        
    }
    
    private func setupBindings() {
        viewModel.isLoading = { [weak self] loading in
            self?.showLoading(loading)
        }
        viewModel.didEncounterError = { [weak self] error in
            self?.showError(error)
        }
    }
    
    private func setupTableView() {
        viewModel.routeNumberDidChange = { [weak self] routeNumber in
            self?.routeNumberTextField.text = routeNumber
        }
        
        viewModel.filteredRoutesDidChange = { [weak self] in
            self?.filteredBusRouteTableView.reloadData()
        }
        
        let nib1 = UINib(nibName: "RouteTableViewCell", bundle: nil)
        recentsRouteTableView.register(nib1, forCellReuseIdentifier: "RouteTableViewCell")
        recentsRouteTableView.dataSource = self
        recentsRouteTableView.delegate = self
        let nib2 = UINib(nibName: "AvailableBusesCardTableViewCell", bundle: nil)
        filteredBusRouteTableView.register(nib2, forCellReuseIdentifier: "AvailableBusesCardTableViewCell")
        filteredBusRouteTableView.dataSource = self
        filteredBusRouteTableView.rowHeight = 100
        filteredBusRouteTableView.delegate = self
    }
    
    private func loadData() {
        viewModel.loadTopRoutes(limit: 5) {
            self.recentsRouteTableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recentsRouteTableView {
            return viewModel.allRouteInfos.count
        } else {
            if self.routeNumberTextField.text == "" {
                return 1
            } else {
                return viewModel.filteredBusRoutes.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == recentsRouteTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RouteTableViewCell", for: indexPath) as? RouteTableViewCell else {
                return UITableViewCell()
            }
            let route = viewModel.allRouteInfos[indexPath.row]
            cell.routeNumber.text = route.routeNumber
            return cell
            
        } else {
            if self.routeNumberTextField.text == "" {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 2
                cell.textLabel?.text = "No searched values. Please selected a Recent route"
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableBusesCardTableViewCell", for: indexPath) as? AvailableBusesCardTableViewCell else {
                    return UITableViewCell()
                }
                let route = viewModel.filteredBusRoutes[indexPath.row]
                cell.fromCity.text = route.source
                cell.toCity.text = route.destination
                cell.companyName.text = route.companyName
                cell.fromTime.text = "From: "+route.departure
                cell.toTime.text = "To: "+route.arrival
                cell.routeNumber.text = route.routeNumber
                cell.duration.text = route.duration
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == recentsRouteTableView {
            viewModel.selectedRoute = viewModel.allRouteInfos[indexPath.row]
        } else {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
                detailVC.selectedID = viewModel.allBusRoutes[indexPath.row].id
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}
