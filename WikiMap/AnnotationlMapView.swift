//
//  FinalMapView.swift
//  WikiMap
//
//  Created by Hyung Seo Han on 2022/04/15.
//

import SwiftUI
import UIKit
import MapKit

struct AnnotationMapView: UIViewRepresentable {
    @State
    var annotations : [MKAnnotation]
    
    
    func makeCoordinator() -> FinalMapViewCoordinator {
        FinalMapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
      let map = MKMapView()
      map.delegate = context.coordinator
      //제스처 설정
      let longPressed = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.addPinWithLongPress(_:)))
      map.addGestureRecognizer(longPressed)
      return map
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        for location in annotations{
            uiView.addAnnotation(location)
        }
    }
}

class FinalMapViewCoordinator: NSObject, MKMapViewDelegate{
    var mapViewController: AnnotationMapView
    
    init(_ control: AnnotationMapView){
        self.mapViewController = control
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation
        guard (annotation as? MKPointAnnotation) != nil else { return }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        //Custom View for Annotation
        let identifier = "Placemark"
        //Identifier를 설정하고 만약에 맵뷰가 생성이 안되어 있다면 Identifier를 부여하여 만들어진 맵에 부여함
        if  let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView.annotation = annotation
            //annotationView.image = UIImage(systemName: "bolt.heart.fill")
            return annotationView
        }
        else {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            //annotationView.image = UIImage(systemName: "bolt.heart.fill")
            return annotationView
        }
    }
    @objc func addPinWithLongPress(_ gestureRecognizer:UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: gestureRecognizer.view)
        let newCoordinates = (gestureRecognizer.view as? MKMapView)?.convert(touchPoint, toCoordinateFrom: gestureRecognizer.view)
        let annotation = MKPointAnnotation()
        guard let _newCoordinates = newCoordinates else { return }
        annotation.coordinate = _newCoordinates
        annotation.title = "AED"
        annotation.subtitle = "주소 : 혹서네 화장실"
        mapViewController.annotations.append(annotation)
    }
}

/*
struct FinalMapView_Previews: PreviewProvider {
    static var previews: some View {
        FinalMapView()
    }
}
 */
