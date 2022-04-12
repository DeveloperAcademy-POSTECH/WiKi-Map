//
//  Landmark.swift
//  WikiMap
//
//  Created by Hyung Seo Han on 2022/04/12.
//

import SwiftUI
import MapKit

class LandmarkAnnotation: NSObject, MKAnnotation{
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    
    init(title: String?,
         subtitle: String?,
         coordinate: CLLocationCoordinate2D
         ){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    static func requestMockData() -> [[String:Any]]{
        let locations = [
            ["title": "heuononono", "subtitle": "mapannotation geukhyeom", "latitude": 36.000, "longitude" : 40.001],
            ["title": "testtest", "subtitle": "mapAnnotations unkind", "latitude": 30.000, "longitude" : 40.002]
            ]
        return locations
    }
}
