//
//  CommentView.swift
//  WikiMap
//
//  Created by 기윤수 on 2022/04/10.
//

import SwiftUI

struct CommentView: View {
    
    
    //Textfield를 통해 입력받은 댓글을 배열에 저장하고 그 요소를 리스트에 보여줌
    
    struct CommentList: Identifiable {
        let id = UUID()
        var content: String
        var checked: Bool
    }
    //각각의 코멘트를 구분하기 위해 Identifiable 프로토콜로 id부여 (UUID 애플이 제공하는 고유 아이디 부여받음)
    
    
    @State var commentString = ""
    @State private var commentWrite = [CommentList]()
    
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
            //ForEach 를 사용해 i에 0 부터 commentWrite 배열의 개수만큼의 수를 차례로 넣어 주고, i를 인덱스로 삼아 commentWrite[i] 의 요소를 텍스트 뷰에 올리는 것. 첫 번째 인자로 들어간 것은 범위이고, 두 번째 인자로 들어간 것은 각각을 식별할 수 있는 id
            
            
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
                    appendList()
                }
                .padding()
            }
            
        }
    }
    
    func appendList() {
        let inputList = CommentList(content: commentString, checked: false)
        commentWrite.append(inputList)
        commentString = ""
    }
}


struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
