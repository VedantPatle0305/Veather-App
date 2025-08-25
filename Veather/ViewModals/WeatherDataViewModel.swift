//
//  WeatherDataViewModel.swift
//  Veather
//
//  Created by Vedant Patle on 16/08/25.
//

import Foundation

@MainActor
class WeatherDataViewModel: ObservableObject {
    @Published var apiResponse: APIResponse?
    @Published var errorMessage: String?

    func fetchWeatherData(lat: Double, lon: Double) async {
        let apiKey = "efcc0fe458f744ce751f15bd9ed60e00"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        
        print(urlString)

        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                errorMessage = "Invalid HTTP Response"
                return
            }

            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(APIResponse.self, from: data)
                apiResponse = decodedResponse
                errorMessage = nil
            } else {
                errorMessage = "Server returned status code: \(httpResponse.statusCode)"
            }
        } catch {
            errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
            apiResponse = nil
        }
    }
}
