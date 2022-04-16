//
//  MapAnnotationCoordinate.swift
//  WikiMap
//
//  Created by Hyung Seo Han on 2022/04/12.
//

import MapKit
import SwiftUI

//Coordinator: create or generate delegate
//NSObject 안에 UIGestureRecognizer 포함되어 있음
class MapAnnotationViewCoordinator: NSObject, MKMapViewDelegate{
    @Published var pins = [MKPointAnnotation]()
    var mapViewController: MapAnnotationView
    
    init(_ control: MapAnnotationView) {
        self.mapViewController = control
        self.pins = self.mapViewController.pins
    }
    
    
    @objc func test(_ mapView: MKMapView, viewFor annotation: MKAnnotation,_ gestureRecognizer: UIGestureRecognizer) -> MKAnnotationView?{
        
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
        //geastureRecognizer.view : The view the gesture recognizer is attached to.
        let touchPoint = gestureRecognizer.location(in: gestureRecognizer.view)
        //convert touchPoint information to coordinate information
        let newCoordinates = (gestureRecognizer.view as? MKMapView)?.convert(touchPoint, toCoordinateFrom: gestureRecognizer.view)
        //create annotationPin
        let annotationPin = MKPointAnnotation()
        guard let _newCoordinates = newCoordinates else{
            return annotationView
        }
        annotationPin.title = "HA"
        annotationPin.coordinate = _newCoordinates
        pins.append(annotationPin)
        print(pins)
        return annotationView
}
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
        //pin 눌렀을때 쀽 하고 뜨는 모듈
        annotationView.canShowCallout = true
        //pin의 모양을 수정가능할 수 있음.
        annotationView.image = UIImage(systemName: "bolt.heart.fill")
        return annotationView
    }
}
