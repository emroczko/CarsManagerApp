//
//  ContentView.swift
//  CarsManager
//
//  Created by Eryk Mroczko on 16/04/2022.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    
    @State private var ownedCarsList: CarsList = CarsList(listType: .OWNED)
    @State private var soldCarsList: CarsList = CarsList(listType: .SOLD)
    
    var body: some View {
        TabView {
            ListView()
            FinanceSummaryView()
        }
        .environmentObject(ownedCarsList)
    }
}
    
struct ListView: View {

    @EnvironmentObject private var ownedCarsList: CarsList
    @State private var confirmationShown = false

    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color("LightSea")) 
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ownedCarsList.cars) {
                    car in
                    ListItemView(car: car)
                    .swipeActions(edge: .leading) {
                          Button (action: {  }) {
                              Text("Sell")
                          }
                          
                    }
                    .tint(.green)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive, action: {
                            confirmationShown = true
                        }) {
                        Text("Delete")
                      }
                        
                    }
                    .tint(.red)
                    .confirmationDialog("Are you sure?", isPresented: $confirmationShown, titleVisibility: .visible) {
                        Button("Yes") {
                            DispatchQueue.main.async{
                                withAnimation {
                                    onDelete(car: car)
                                }
                            }
                        }
                        Button("No", role: .cancel) {}
                    }
                }
                .onMove(perform: onMove)
            }
            
            .listStyle(InsetListStyle())
            .navigationBarItems(leading: Button(action: {}, label: {
                NavigationLink(destination: AddNewCarView()) { Image(systemName: "plus") }
            }))
            .navigationBarTitle("Owned cars")
        }
        .tabItem {
            Label("Cars list", systemImage: "list.dash")
        }
    }

    private func onDelete(car: Car) {
        ownedCarsList.cars.remove(at: ownedCarsList.cars.firstIndex(of: car)!)
    }

    private func onMove(source: IndexSet, destination: Int) {
        ownedCarsList.cars.move(fromOffsets: source, toOffset: destination)
    }
    
}


struct AddNewCarView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject private var ownedCarsList: CarsList
    @State var brand: String = ""
    @State var model: String = ""
    
    
    var body: some View {
        Form {
            TextField("Brand", text: $brand)
                .padding()
            TextField("Model", text: $model)
                .padding()
            Button("Add") {
                ownedCarsList.cars.append(Car(vin: "WBADHWUA9283\(Int.random(in: 1...100))", brand: brand, model: model))
                mode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

struct ListItemView: View {
    
    @State var car: Car
    
    var body: some View {
        HStack{
            Image("bmw5")
                .resizable()
                .scaledToFill()
                .cornerRadius(10)
                .frame(width: 100.0, height: 100.0, alignment: .leading)
            VStack{
                Text("\(car.brand) \(car.model)")
                    .foregroundColor(Color("Sea"))
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                SmallCarRowText(text: "Year: \(car.year)")
                SmallCarRowText(text: "VIN: \(car.vin)")
                SmallCarRowText(text: "Plate: BL 45141")
            }
        }
        .padding()
        .background(Color("MainBeige"))
        .cornerRadius(10)
            
    }
}

struct SmallCarRowText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 13))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    }
}

struct FinanceSummaryView: View {
    
    var body: some View {
        VStack{
            Picker(selection: .constant(1), label: Text("Picker")) {
                Text("W").tag(1)
                Text("M").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Spacer()
            Text("summary")
        }
        .tabItem {
            Label("Finance summary", systemImage: "dollarsign.square.fill")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
