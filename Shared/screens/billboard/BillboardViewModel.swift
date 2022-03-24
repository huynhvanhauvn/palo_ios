//
//  BillboardViewModel.swift
//  Palo
//
//  Created by Hau Huynh on 18/12/2021.
//

import Foundation
import Combine

class BillboardViewModel: ObservableObject {
    private let BASE_URL = "https://huynhvanhaua.000webhostapp.com/api/"
    private var tasks = Set<AnyCancellable>()
    @Published var promotions: [Promotion] = []
    @Published var bestMovies: [Movie] = []
    @Published var recentMovies: [Movie] = []
    
    func fetchPromotionList() {
        URLSession.shared.dataTaskPublisher(for: URL(string: BASE_URL+"promotion.php")!)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Promotion].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { result in
                print(result)
                
            }) { result in
                self.promotions = result
            }
            .store(in: &tasks)
    }
    
    func fetchBestMovieList() {
        URLSession.shared.dataTaskPublisher(for: URL(string: BASE_URL+"moviebest.php")!)
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
                self.bestMovies = result
            }
            .store(in: &tasks)
    }
    
    func fetchRecentMovieList() {
        URLSession.shared.dataTaskPublisher(for: URL(string: BASE_URL+"recentmovie.php")!)
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
                self.recentMovies = result
            }
            .store(in: &tasks)
    }
}
