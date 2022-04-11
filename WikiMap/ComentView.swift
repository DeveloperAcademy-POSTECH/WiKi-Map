//
//  ComentView.swift
//  WikiMap
//
//  Created by 기윤수 on 2022/04/10.
//

import SwiftUI

struct ComentView: View {
    
    struct CommentWrite: Identifiable {
        let id = UUID()
        var content: String
        var checked: Bool
    }
    
    @State var commentString = ""
    @State private var commentWrite = [CommentWrite]()
    
    var body: some View {
        VStack(alignment: .leading)
        {
            Text("덧글")
            
            List {
                ForEach(0..<commentWrite.count, id: \.self) { i in
                    VStack{
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 33, height: 33)
                            .foregroundColor(.gray)
                        Text("Nickname")
                            .fontWeight(.bold)
                        
                    }
                    Text(commentWrite[i].content)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }

            
            HStack{
                Image(systemName: "camera.fill")
                    .foregroundColor(.gray)
                    .padding()
                TextField(
                    "댓글을 입력하세요",
                    text: $commentString,
                    onCommit: {
                        appendList()
                    }
                )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(0.0)
                Button("입력") {
                    print(self.$commentString)
                }
                .padding()
                //버튼입력안됨...
            }
            
        }
    }
    
    func appendList() {
         let inputList = CommentWrite(content: commentString, checked: false)
         commentWrite.append(inputList)
         commentString = ""
     }
}


struct ComentView_Previews: PreviewProvider {
    static var previews: some View {
        ComentView()
    }
}
