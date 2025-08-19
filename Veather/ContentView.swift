//
//  ContentView.swift
//  Veather
//
//  Created by Vedant Patle on 16/08/25.
//

import SwiftUI
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherVM = WeatherDataViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    
                    if let name = weatherVM.apiResponse?.name,
                       let country = weatherVM.apiResponse?.sys.country {
                        Text("\(name), \(country)")
                            .font(.title)
                            .bold()
                            .lineLimit(1)
                            .foregroundStyle(Color.white)
                            .padding()
                    } else {
                        Text("New Delhi")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    Spacer()
                    
                    if let image = weatherVM.apiResponse?.weather.first?.icon {
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(image)@2x.png")) { image in
                            image.image?.resizable()
                                .frame(width: 200, height: 200)
                        }
                    } else {
                        Image(systemName: "sun.max.trianglebadge.exclamationmark.fill")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .foregroundStyle(.white)
                    }
                    
                    
                    VStack{
                        if let tempKelvin = weatherVM.apiResponse?.main.temp {
                            let temp = String(format: "%.2f", tempKelvin - 273.15)
                            Text("\(temp) ºC")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.white)
                        } else {
                            Text("Loading...")
                        }
                        
                        if let desc = weatherVM.apiResponse?.weather.first?.description {
                            Text("\(desc)")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        
                    }
                    
                    HStack(spacing: UIScreen.main.bounds.width / 3){
                        if let minTemp = weatherVM.apiResponse?.main.tempMin, let maxTemp = weatherVM.apiResponse?.main.tempMax {
                            Text("Min: \(minTemp)")
                            Text("Max: \(maxTemp)")
                        }
                        //                    else{
                        //                        Text("Min")
                        //                            .font(.caption)
                        //                            .foregroundStyle(Color.white)
                        //
                        //                        Text("Max")
                        //                            .font(.caption)
                        //                            .foregroundStyle(Color.white)
                        //                    }
                    }
                    .padding(.all)
                    
                    Spacer()
                    Spacer()
                    
                    NavigationLink(destination: CityWeatherView()) {
                        Text("Get Weather Update for other Location")
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.all)
                    
                    
                    Spacer()
                    
                    
                    
                    
                }
            }
        }
        .onChange(of: locationManager.userLocation) { coordinate in
            guard let coordinate = coordinate else { return }
            Task {
                await weatherVM.fetchWeatherData(lat: coordinate.latitude, lon: coordinate.longitude)
            }
        }
    }
}


#Preview {
    ContentView()
}
