//
//  ModalView.swift
//  WikiMap
//
//  Created by Jinsan Kim on 2022/04/07.
//

import SwiftUI

struct ModalView: View {
    
    // Gesture
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        
        ZStack{
            
           
            
            //bottom sheet
            GeometryReader{proxy -> AnyView in
                
                let height = proxy.frame(in:
                        .global).height
                
                return AnyView(
                    ZStack{
                        BlurView(style: .systemThinMaterialLight)
                            .cornerRadius(30)
                        
                        VStack{
                            Capsule()
                                .fill(Color.secondary)
                                .frame(width: 60, height: 4)
                                .padding(.top)
                            
                            // Search Bar
                            SearchView()
                            
                            // Modal Content
                            BottomContent()
                            
                            
                        }
                        .padding(.horizontal)
                        .frame(maxHeight: .infinity, alignment: .top)
                        
                    }
                    .offset(y: height - 100)
                    .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                    .gesture(DragGesture().updating($gestureOffset, body: {
                        value, out, _ in
                        
                        out = value.translation.height
                        onChange()
                    }).onEnded({ value in
                        
                        let maxHeight = height - 100
                        withAnimation {
                            // Up Down or Mid
                            if -offset > 100 && -offset < maxHeight / 2 {
                                
                                // Mid
                                offset = -(maxHeight / 3)
                            }
                            else if -offset > maxHeight / 2 {
                                offset = -maxHeight
                            }
                            else {
                                offset = 0
                            }
                        }
                        
                        // Store last offset
                        lastOffset = offset
                    }))
                    
                )
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    func onChange(){
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
}

struct ModalView_Preview: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}

