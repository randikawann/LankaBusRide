//
//  HomeViewController.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        bindViewModel()
        viewModel.fetchRoutes()
    }

    private func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource
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

