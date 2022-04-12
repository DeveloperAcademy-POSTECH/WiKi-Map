//
//  BottomContent.swift
//  WikiMap
//
//  Created by Jinsan Kim on 2022/04/11.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    
    var body: some View {
        TextField("Search", text: $searchText)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(BlurView(style: .dark))
            .cornerRadius(10)
            .colorScheme(.dark)
            .padding(.top, 10)
    }
}

struct BottomContent: View {
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Recently Add")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("See All")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                })
            }
            .padding(.top, 20)
            
            Divider()
                .background(Color.white)
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 15){
                    VStack{
                        Button(action: {}, label: {
                            Image("stairs")
                                .resizable()
                                .padding(15)
                                .frame(width: 70, height: 70)
                                .background(Color(red: 52 / 255, green: 152 / 255, blue: 219 / 255))
                                .clipShape(Circle())
                        })
                        
                        Text("Stair")
                            .foregroundColor(.white)
                    }
                    
                    VStack{
                        Button(action: {}, label: {
                            Image("lift")
                                .resizable()
                                .padding(15)
                                .frame(width: 70, height: 70)
                                .background(Color(red: 52 / 255, green: 152 / 255, blue: 219 / 255))
                                .clipShape(Circle())
                        })
                        
                        Text("Elevator")
                            .foregroundColor(.white)
                    }
                    
                    VStack{
                        Button(action: {}, label: {
                            Image(systemName: "bolt.heart.fill")
                                .resizable()
                                .padding(15)
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)
                                .background(.red)
                                .clipShape(Circle())
                        })
                        
                        Text("AED")
                            .foregroundColor(.white)
                    }
                }
            })
            
        }
    }
}

struct BottomContent_Preview: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
