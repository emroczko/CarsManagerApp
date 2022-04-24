//
//  CarsList.swift
//  CarsManager
//
//  Created by Eryk Mroczko on 18/04/2022.
//

import Foundation


class CarsList: ObservableObject {
    var listType: CarsListTypeEnum
    @Published var cars: [Car] = []
    
    init(listType: CarsListTypeEnum){
        self.listType = listType
    }
}
