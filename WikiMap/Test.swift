//
//  Test.swift
//  WikiMap
//
//  Created by 양원모 on 2022/04/11.
//

import SwiftUI
import UIKit

struct TestView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 10){
                HStack{
                    Spacer().frame(width: 10)
                    Text("사진")
                        .font(.system(size: 20))
                    Spacer()
                }
                Spacer().frame(height: 10)
                
                HStack{
                    Spacer().frame(width: 10)
                    ScrollView(.horizontal, showsIndicators: false){
                      if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .frame(width: 85, height: 85)
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                      } else {
                        Image(systemName: "plus.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 85, height: 85)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                      }
                    }
                }
                
                
                
                
                Button("Camera") {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                }
                .padding(3)
                
                Button("Photo") {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }
            }
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

