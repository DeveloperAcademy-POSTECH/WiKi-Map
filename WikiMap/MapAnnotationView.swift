//
//  MapAnnotationView.swift
//  WikiMap
//
//  Created by Hyung Seo Han on 2022/04/12.
//

import SwiftUI
import UIKit
import MapKit


extension MKPointAnnotation{
    convenience init(title: String, coordinate : CLLocationCoordinate2D){
        self.init()
        self.title = title
        self.coordinate = coordinate
    }
}

struct MapAnnotationView: UIViewRepresentable {
    @Binding var pins : [MKPointAnnotation]
    
    //Make Coordinator
    func makeCoordinator() -> MapAnnotationViewCoordinator{
        MapAnnotationViewCoordinator(self)
    }
    
    //Replace body : some View -> makeUIView
    func makeUIView(context: Context) -> MKMapView {
        //지도 설정
        let map = MKMapView(frame: .zero)
        map.delegate = context.coordinator
        //제스처 인식
        let longPressed = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.test(_:viewFor:_:)))
        longPressed.minimumPressDuration = 2.0
        map.addGestureRecognizer(longPressed)
        return map
    }
    
    //context: structure containing information about the current state of the system.
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //uiView.delegate = context.coordinator
        let count = uiView.annotations
        if count != nil{
            uiView.removeAnnotations(uiView.annotations)
        }
        uiView.addAnnotations(pins)
        
        //View Update에 대한 방아쇠를 당겨야한다고 함. -> 직접적으로 업데이트를 해줘야한다.
    }
}



class AnnotationViewModel: ObservableObject{
    @Published var pins = [MKPointAnnotation]()
    init() {
        var annotation = MKPointAnnotation()
        annotation.title = "Apple Store"
        annotation.subtitle = "shibural"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.77, longitude: -73.98)
        pins.append(annotation)

        annotation = MKPointAnnotation()
        annotation.title = "Shoe Store"
        annotation.subtitle = "shibural"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.78, longitude: -73.98)
        pins.append(annotation)
    }
}

