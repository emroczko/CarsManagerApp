//
//  AddNewCarView.swift
//  CarsManager
//
//  Created by Eryk Mroczko on 24/04/2022.
//

import SwiftUI
import PhotosUI

struct AddNewCarView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject private var ownedCarsList: CarsList
    @State var brand: String = ""
    @State var model: String = ""
    @State private var image = UIImage()
    @State private var isPresented = false
    
    var pickerConfiguration: PHPickerConfiguration {
      var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
      config.filter = .images
      return config
    }
    
    var body: some View {
        Form {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .popover(isPresented: $isPresented) {
                    ImagePicker(configuration: pickerConfiguration) { selectedImage in
                        image = selectedImage
                    }
                    .progressViewStyle(CircularProgressViewStyle())
                    .ignoresSafeArea(.keyboard)
                }
                .onTapGesture(perform: {
                    isPresented.toggle()
                })
                            
            
            TextField("Brand", text: $brand)
                .padding()
            TextField("Model", text: $model)
                .padding()
        }
        
        Button("Add") {
            ownedCarsList.cars.append(Car(vin: "WBADHWUA9283\(Int.random(in: 1...100))", brand: brand, model: model, image: image))
            mode.wrappedValue.dismiss()
        }
        .padding()
    }
}

struct AddNewCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCarView()
    }
}
