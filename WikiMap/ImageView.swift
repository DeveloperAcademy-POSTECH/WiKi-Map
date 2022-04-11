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
                    .font(.system(size: 20))
                Spacer()
                Button(action: {
                    //버튼을 클릭했을 때 실행되는 코드
                    
                }){
                    Image(systemName: "plus")
                }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(3)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.blue, lineWidth: 3))
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
            }
        }
        .padding()
    }
    
}


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}


