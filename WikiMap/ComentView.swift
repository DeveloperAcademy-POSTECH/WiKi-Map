//
//  ComentView.swift
//  WikiMap
//
//  Created by 기윤수 on 2022/04/10.
//

import SwiftUI

struct ComentView: View {
    
    
    
    @State var comment: String = ""
    //입력된 값을 저장하기 위한 name 변수 선언
    //변수에 빈 값 ""을 넣으면 textfield에 아무런 값도 들어있지 않은 상태로 실행되고, 특정 값을 넣게 되면 해당 값이 textfield에 입력된 상태로 실행됨
    //@state를 붙이면, name변수에 값 변동이 생기는 경우 이를 감지하여 view를 다시 만들어 name변수가 사용된 모든 부분이 변경된 값이 적용될 수 있도록 한다
    
    
    var body: some View {
        
        
        VStack(alignment: .leading)
        {
            
            //지울거
            Rectangle()
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
            
            //양옆으로 마진 16px주기
            
            Text("댓글")
            
            //덧글보이는창
            List {
                //덧글예시
                VStack(alignment: .leading){
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 33, height: 33)
                        .foregroundColor(.gray)
                    Text("Nickname")
                }
                Text("덧글예시덧글예시덧글예시덧글예시덧글예시덧글예시덧글예시덧글예시덧글예시")
                }
                VStack(alignment: .leading){
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 33, height: 33)
                        .foregroundColor(.gray)
                    Text("Nickname2")
                }
                Text("덧글예시덧글예시덧글예시덧글예시")
                }
            }
            
                    
            HStack{
                Image(systemName: "camera.fill")
                    .foregroundColor(.gray)
                    .padding()
                TextField("댓글을 입력하세요", text: $comment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(0.0)
                Button("입력") {
                    print(self.$comment)
                }
                .padding()
            }
        }
    }
}

struct ComentView_Previews: PreviewProvider {
    static var previews: some View {
        ComentView()
    }
}
