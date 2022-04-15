//
//  MapAnnotationView.swift
//  WikiMap
//
//  Created by Hyung Seo Han on 2022/04/12.
//

import SwiftUI
import UIKit
import MapKit

struct MapAnnotationView: UIViewRepresentable {
    //Mock Data
    let landmarks = LandmarkAnnotation.requestMockData()
    
    func makeCoordinator() -> MapAnnotationViewCoordinator{
        MapAnnotationViewCoordinator(self)
    }
    
    //Replace body : some View -> makeUIView
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: .zero)
        map.delegate = context.coordinator
        let longPressed = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.test(_:)))
        longPressed.minimumPressDuration = 0.5
        map.addGestureRecognizer(longPressed)
        return map
    }
    
    //context: structure containing information about the current state of the system.
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.delegate = context.coordinator
        
        //Annotation Pin Setting
        for location in landmarks{
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.subtitle = location["subtitle"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            uiView.addAnnotation(annotation)
        }
    }
    
}

//closer
struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView()
    }
}
