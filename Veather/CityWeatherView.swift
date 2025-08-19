//
//  CitySerachView.swift
//  Veather
//
//  Created by Vedant Patle on 19/08/25.
//

import SwiftUI

struct CityWeatherView: View {
    @StateObject private var viewModel = CitySearchViewModel()
    @State var enteredCity = ""
        
        var body: some View {
            NavigationStack {
                ZStack{
                    Image("background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    VStack(){
                        HStack{
                            TextField("Enter the name or City", text: $enteredCity)
                                .padding()
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(10)
                            
                            Button("Check") {
                                Task{
                                    await viewModel.fetchCitySearchData(cityname: enteredCity)
                                }
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            
                        }
                        .padding(.bottom, 50)
                        .padding(.top, 30)
                        
                        if let response = viewModel.apiResponse{
                            VStack{
                                Text("\(response.name ?? "Delhi"), \(response.sys.country ?? "IN")")
                                    .font(.title)
                                    .foregroundStyle(Color.white)
                                    .padding()
                                
                                if let image = response.weather.first?.icon {
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
                                
                                let temp = (response.main.temp ?? 273.15) - 273.15
                                Text("\(temp) ºC")
                                    .font(.title)
                                    .foregroundStyle(Color.white)
                                
                                Text("\(response.weather.first?.description ?? "")")
                                    .font(.headline)
                                    .foregroundStyle(Color.white)
                                
                            }
                        } else {
                            VStack{
                                Text("Enter the name of the city to get the weather update. Make sure to enter the correct city name.")
                                    .font(.headline)
                                    .foregroundStyle(Color.red.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        }
                            
                        Spacer()
                    }
                    .padding()
                    
                }
//                .navigationTitle("Weather Check")
//                .toolbarTitleDisplayMode(.inline)
            }
        }
}

#Preview {
    CityWeatherView(enteredCity: "Nagpur")
}
