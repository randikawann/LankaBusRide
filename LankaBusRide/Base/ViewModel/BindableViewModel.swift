//
//  BindableViewModel.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-13.
//

import Foundation

protocol BindableViewModel {
    var isLoading: ((Bool) -> Void)? { get set }
    var didEncounterError: ((Error?) -> Void)? { get set }
}
