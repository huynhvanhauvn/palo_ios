//
//  TrendViewModel.swift
//  Palo
//
//  Created by Hau Huynh on 24/12/2021.
//

import Foundation
import Combine

class TrendViewModel: ObservableObject {
    private let BASE_URL = "https://huynhvanhaua.000webhostapp.com/api/"
    private var tasks = Set<AnyCancellable>()
    
    @Published var trendMovies: [Movie] = []
    @Published var trendArtists: [Artist] = []
    @Published var dateViews: [[DateView]] = []
    
    
    func fetchTrendMovieList() {
        URLSession.shared.dataTaskPublisher(for: URL(string: BASE_URL+"trendmovie.php")!)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Movie].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { result in
                print(result)
                
            }) { result in
                if (result.count >= 3) {
                    self.fetchDateViewList(movies: Array(result[..<3]))
                }
                self.trendMovies = result
            }
            .store(in: &tasks)
    }
    
    func fetchTrendArtistList() {
        URLSession.shared.dataTaskPublisher(for: URL(string: BASE_URL+"artisttrendcast.php")!)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Artist].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { result in
                print(result)
                
            }) { result in
                self.trendArtists = result
            }
            .store(in: &tasks)
    }
    
    func fetchDateViewList(movies: [Movie]) {
//        self.dateViews = [
//            [DateView(date: "0", view: "0"), DateView(date: "1", view: "1")],
//            [DateView(date: "0", view: "0"), DateView(date: "1", view: "2")],
//            [DateView(date: "0", view: "0"), DateView(date: "1", view: "3")]
//        ]
        for (i, e) in movies.enumerated() {
            dateViews.append([DateView(date: "", view: "")])
            var request = URLRequest(url: URL(string: BASE_URL+"dateviewmovie.php")!)
            let body: [String: String] = ["idMovie": e.id!]
            let finalBody = try! JSONSerialization.data(withJSONObject: body)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTaskPublisher(for: request)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: [DateView].self, decoder: JSONDecoder())
                .replaceError(with: [])
                .eraseToAnyPublisher()
                .sink(receiveCompletion: { result in

                }) { result in
                    self.dateViews[i] = result
//                    self.dateViews.append(result)
//                    print("/////", self.dateViews)
                }
                .store(in: &tasks)
        }
    }
}
