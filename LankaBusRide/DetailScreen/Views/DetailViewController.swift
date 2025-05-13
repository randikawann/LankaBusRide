//
//  DetailViewController.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-13.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel = DetailViewModel()
    var selectedID: Int?
    
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var fromTime: UILabel!
    @IBOutlet weak var toTime: UILabel!
    @IBOutlet weak var route: UILabel!
    @IBOutlet weak var busType: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var fare: UILabel!
    @IBOutlet weak var stops: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    private func loadData() {
        viewModel.loadBusDetail(id: selectedID ?? 0) {
            self.title = self.viewModel.title
            self.from.text = self.viewModel.source
            self.to.text = self.viewModel.destination
            self.fromTime.text = self.viewModel.departure
            self.toTime.text = self.viewModel.arrival
            self.route.text = self.viewModel.routeNumber
            self.busType.text = self.viewModel.busType
            self.duration.text = self.viewModel.duration
            self.fare.text = self.viewModel.fareText
            self.stops.text = self.viewModel.popularStops
        }
    }
    
}
