//
//  ContentView.swift
//  WikiMap
//
//  Created by Hyung Seo Han on 2022/04/05.
//

import SwiftUI
import MapKit
import CoreLocationUI


struct MapView: View {
    @State private var showModal = false
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom){
                
            //Map을 사용해서 위에서 설정한 region 바인딩 진행
            Map(coordinateRegion: $viewModel.region,
                interactionModes: .all,
                showsUserLocation: true)
                .ignoresSafeArea()
                .tint(.pink)
                
            //Text와 Button은 동등한 선상에 있기 때문에 VStack으로 설정함
            VStack{
                Text("위도 : \(viewModel.region.center.latitude) ,경도: \(viewModel.region.center.longitude),  Zoom:\(viewModel.region.span.latitudeDelta) ")
                    .font(.caption)
                    .padding()
                        
                    
                LocationButton(.currentLocation){
                    viewModel.requestAllowOnceLocationPermission()
                }
                .foregroundColor(.white)
                .cornerRadius(10)
                .symbolVariant(.fill)
                .tint(.blue)
                
            }.statusBar(hidden: true)//위의 상단바(시간이랑 배터리 삭제)

        }
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
        DispatchQueue.main.async{
            self.region = MKCoordinateRegion(
                center: latestLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
                                                
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
