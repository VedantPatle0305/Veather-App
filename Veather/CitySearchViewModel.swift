//
//  CitySearchViewModel.swift
//  Veather
//
//  Created by Vedant Patle on 19/08/25.
//

import Foundation
import Combine

class CitySearchViewModel: ObservableObject {
    @Published var apiResponse: APIResponse?
    @Published var errorMessage: String?

    func fetchCitySearchData(cityname: String) async{
        let apiKey = "efcc0fe458f744ce751f15bd9ed60e00"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityname)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        do {
            let (data, reponse) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = reponse as? HTTPURLResponse else {
                errorMessage = "Invalid HTTP Response"
                return
            }
            
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                self.apiResponse = apiResponse
                print(apiResponse)
            }
            else {
                errorMessage = "Server Returned StatusCode \(httpResponse.statusCode)"
            }
        }
        catch {
            errorMessage = "Failed to fetch response: \(error.localizedDescription)"
            apiResponse = nil
        }
        
        
    }


}
