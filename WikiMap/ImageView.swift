//
//  ImageView.swift
//  WikiMap
//
//  Created by 양원모 on 2022/04/08.
//

import SwiftUI
import UIKit

class ImageStack: ObservableObject {
    @Published var count: Int = 0
}


struct StackCount {
    var id = UUID()
    var number: String
}


struct ImageView: View {
    
    @ObservedObject var imageStack = ImageStack()
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage = [UIImage?](repeating: nil, count: 4)
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        
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
                    
                    HStack(spacing: 10){
                        
                        ForEach(0 ..< selectedImage.count, id: \.self){i in
                            
                            if selectedImage[i] != nil {
                                Image(uiImage: self.selectedImage[i]!)
                                    .resizable()
                                    .frame(width: 85, height: 85)
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Image(systemName: "plus.square")
                                    .resizable()
                                    .frame(width: 85, height: 85)
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                }
            }
            
            Button("Camera") {
                self.imageStack.count += 1
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
            }
            .padding(3)
            
            Button("Photo") {
                self.imageStack.count += 1
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            }
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage[0], sourceType: self.sourceType)
        }
    }
}


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
