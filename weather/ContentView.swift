//
//  ContentView.swift
//  todaktodak
//
//  Created by Jiyoung on 2023/10/09.
//

import SwiftUI

struct ContentView: View {
    @State private var lat: Double = 0.0
    @State private var lon: Double = 0.0
    @State private var locationError: Error?
    @State private var city: String = ""
    @State private var weather: String = ""
    @State private var temp: Double = 0.0
        
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            HStack{
                Text("위도: \(lat)")
                Text("경도: \(lon)")
            }
            Text("지역: \(city)")
            Text("날씨: \(weather)")
            Text("온도: \(temp)")
        }
        .onAppear{
            updateLocation()
        }
        .onChange(of: [locationManager.latitude, locationManager.longitude], {updateLocation()})
        .padding()
    }
    
    func updateLocation() {
        lat = locationManager.latitude
        lon = locationManager.longitude
        locationError = locationManager.locationError
        
        let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&apiKey=cf0eb18fae0d8b0f9062debf430cacbc")!
        
        let task = URLSession.shared.dataTask(with: weatherUrl) { (data, response, error) in
            if let unwrappedData = data {
                do {
                    let responseData = try JSONDecoder().decode(WeatherResponse.self, from: unwrappedData)
                    weather = responseData.weather[0].main
                    city = responseData.city
                    temp = UnitTemperature.celsius.converter.value(fromBaseUnitValue: responseData.main.temp)
                } catch {
                    return
                }
            }
        }
        task.resume()
    }
}
