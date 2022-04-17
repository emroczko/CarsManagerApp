//
//  ContentView.swift
//  CarsManager
//
//  Created by Eryk Mroczko on 16/04/2022.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        
        TabView {
            ListView()
            FinanceSummaryView()
        }
        
    }
}
    
struct ListView: View {

    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color("LightSea")) // Uses UIColor
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(1...8, id: \.self) {
                    _ in
                    ListItemView()
                }
            }
            .listStyle(InsetListStyle())
            .navigationBarItems(leading: EditButton())
            .navigationBarTitle("Owned cars")
            
        }

        .tabItem {
            Label("Cars list", systemImage: "list.dash")
        }
    }
    
}

struct ListItemView: View {
    var body: some View {
        HStack{
            Image("bmw5")
                .resizable()
                .scaledToFill()
                .cornerRadius(10)
                .frame(width: 100.0, height: 100.0, alignment: .leading)
                
            Spacer()
            VStack{
                Text("BMW 530D")
                    .foregroundColor(Color("Sea"))
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                
                Spacer()
                Text("Year: 2010")
                    .font(.system(size: 13))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                Spacer()
                Text("VIN: WBABZG9273627812")
                    .font(.system(size: 13))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                Spacer()
                Text("Plate: BL 45141")
                    .font(.system(size: 13))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                
            }
            
            
            
        }
        .padding()
        .background(Color("MainBeige"))
        .cornerRadius(10)
            
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