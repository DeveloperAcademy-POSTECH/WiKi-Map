//
//  ImageView.swift
//  WikiMap
//
//  Created by 양원모 on 2022/04/08.
//

import SwiftUI
import UIKit

struct ImageView: View {
    
    @State var stairPhoto = ["계단1","계단2", "계단3", "계단4"]
    
    
    var body: some View {
        VStack{
            
            HStack{
                Text("사진")
                Spacer()
            }
            
            Spacer().frame( height: 10)
            
            ScrollView(.horizontal, showsIndicators: false){
                //stairPhoto.append("계단5")
                HStack(spacing: 10){
                    ForEach(0..<self.stairPhoto.count){ index in
                        Image(self.stairPhoto[index])
                            .resizable()
                            .frame(width: 85, height: 85)
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                    
                }
                Button(action: {
                    self.stairPhoto.append("계단5")
                }) {
                    Text("ADD")
                }
            }
        }
        .padding()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
