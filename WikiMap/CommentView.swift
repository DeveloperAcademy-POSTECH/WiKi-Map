//
//  CommentView.swift
//  WikiMap
//
//  Created by 기윤수 on 2022/04/10.
//

import SwiftUI

struct CommentView: View {
    
    // Clear List Background
    init(){
            UITableView.appearance().backgroundColor = .clear
    }
    
    
    //Textfield를 통해 입력받은 댓글을 배열에 저장하고 그 요소를 리스트에 보여줌
    
    struct CommentList: Identifiable {
        let id = UUID()
        var nickName: String
        var content: String
    }
    //각각의 코멘트를 구분하기 위해 Identifiable 프로토콜로 id부여 (UUID 애플이 제공하는 고유 아이디 부여받음)
    
    
    @State var commentString = ""
    @State private var commentWrite = [CommentList]()
    
    var body: some View {
        VStack
        {
            List {
                ForEach(0..<commentWrite.count, id: \.self) { i in
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 33, height: 33)
                                .foregroundColor(.gray)
                            Text(commentWrite[i].nickName)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                        }
                        Text(commentWrite[i].content)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .listRowBackground(Color.white)
            }
            
            HStack{
                TextField(
                    "댓글을 입력하세요",
                    text: $commentString,
                    onCommit: {
                        appendList()
                    }
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                Button("입력") {
                    appendList()
                }
                .padding()
            }
            
        }
        .background(.clear)
    }
    
    func appendList() {
        let inputList = CommentList(nickName: "ME", content: commentString)
        commentWrite.append(inputList)
        commentString = ""
    }
}


struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
