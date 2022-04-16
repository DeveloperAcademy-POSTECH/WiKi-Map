//
//  MapView.swift
//  WikiMap
//
//  Created by Hyung Seo Han on 2022/04/05.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct Location: Identifiable{
    var id = UUID()
    var title: String
    var latitude: Double
    var longitude: Double
}

extension Location{
    static var pinLocations = [
        Location(title: "Test 0", latitude: 35.500000, longitude: 40.000000)
    ]
}

struct MapView: View {
    @State private var showModal = false
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .topLeading){
            
            AnnotationMapView(annotations: [])
                
                .ignoresSafeArea()
                .tint(.pink)
            /*
            //Map을 사용해서 위에서 설정한 region 바인딩 진행
            Map(coordinateRegion: $viewModel.region,
                interactionModes: .all,
                showsUserLocation: true,
                annotationItems: Location.pinLocations){
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), tint: .blue)
            }
                .ignoresSafeArea()
                .tint(.pink)
            */
            
            
            //Text와 Button은 동등한 선상에 있기 때문에 VStack으로 설정함
            /*Text("위도 : \(viewModel.region.center.latitude) ,경도: \(viewModel.region.center.longitude),  Zoom:\(viewModel.region.span.latitudeDelta) ")
                .font(.caption)
                .padding(100)
            */
            
            VStack{
                LocationButton(.currentLocation){
                    viewModel.requestAllowOnceLocationPermission()
                }
                .foregroundColor(.white)
                .cornerRadius(10)
                .symbolVariant(.fill)
                .labelStyle(.iconOnly)
                .tint(.blue)
                .padding(EdgeInsets(top: 0, leading: 10 , bottom: 0, trailing: 0))
                
                
                
                
                Button("Pin",action: viewModel.addAnnotationPin)
                    .frame(width: 41, height: 41)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(EdgeInsets(top: 0, leading: 10 , bottom: 0, trailing: 0))
                
                Button("Whole",action: viewModel.wholeMap)
                    .font(.system(size:10, weight: .bold))
                    .frame(width: 41, height: 41)
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(EdgeInsets(top: 0, leading: 10 , bottom: 0, trailing: 0))

            }.statusBar(hidden: true)//위의 상단바(시간이랑 배터리 삭제)
             .padding(EdgeInsets(top: 60, leading: 0 , bottom: 0, trailing: 0))
            //공돌이 만든 ModalView
            ModalView()
        }
    }



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    //region : 지도에서 어디 부분을 보여줄 것인지 설정
    //center : 위도와 경도 설정
    //span : 배율 설정 -> zoom의 크기가 작으면 작을수록 더 확대되는 형태임
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude) ,
        span: MKCoordinateSpan(latitudeDelta: MapDefaults.zoom, longitudeDelta: MapDefaults.zoom))
    
    @Published var pinsLocations: [Location] = Location.pinLocations
    
    private var test = 0
    
    private enum MapDefaults{
        static let latitude =  40.00011
        static let longitude = 131.52104
        static let zoom = 10.00
    }
    
    let locationManager = CLLocationManager()
    
    override init(){
        super.init()
        locationManager.delegate = self
    }
    
    //유저로부터 한번만 위치 정보를 요청할 수 있게끔하는 메소드임
    //반환값은 바로 반환됨
    func requestAllowOnceLocationPermission(){
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else{
            //show an error
            return
        }
        DispatchQueue.main.async{[weak self] in
            self?.region = MKCoordinateRegion(
                center: latestLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
                                                
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func addAnnotationPin(){
        test = test + 1
        let testTitle = "Test "+String(test)
        let testLatitude = round(Double.random(in: 1...90)*100000)/100000
        let testLongitude = round(Double.random(in: 1...135)*100000/100000)
        
        Location.pinLocations.append(Location(title: testTitle, latitude: testLatitude, longitude: testLongitude))
        
        DispatchQueue.main.async {[weak self] in
            self?.pinsLocations = Location.pinLocations
            
        }
    }
    
    func wholeMap(){
        DispatchQueue.main.async{[weak self] in
            self?.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 27.83, longitude: 84.69),
                span: MKCoordinateSpan(latitudeDelta: 155.0, longitudeDelta: 155.0))
        }
    }
}

}
