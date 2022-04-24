//
//  Car.swift
//  CarsManager
//
//  Created by Eryk Mroczko on 18/04/2022.
//

import Foundation
import SwiftUI

struct Car: Identifiable, Equatable {
    let id = UUID()
    let vin: String
    let brand: String
    let model: String
    let year: String = "2010"
}
