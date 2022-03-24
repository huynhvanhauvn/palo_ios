//
//  MovieViewModel.swift
//  Palo (iOS)
//
//  Created by Hau Huynh on 09/01/2022.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    private var tasks = Set<AnyCancellable>()
    @Published var movie: Movie?
    @Published var directors: [Artist] = []
    @Published var writers: [Artist] = []
    @Published var cast: [Artist] = []
    
    func fetchMovieDetail(idMovie: String, idUser: String, language: String) {
        var request = URLRequest(url: URL(string: Constants.BASE_URL+"movie.php")!)
        let body: [String: String] = ["id": idMovie, "idUser": idUser, "language": language]
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
            .decode(type: Movie.self, decoder: JSONDecoder())
        //            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { result in
                print(result)
                
            }) { result in
                print(result)
                self.fetchArtistList(idMovie: result.id!, role: "1")
                self.fetchArtistList(idMovie: result.id!, role: "2")
                self.fetchArtistList(idMovie: result.id!, role: "3")
                self.movie = result
            }
            .store(in: &tasks)
    }
    
    func fetchArtistList(idMovie: String, role: String) {
        var request = URLRequest(url: URL(string: Constants.BASE_URL+"artist.php")!)
        let body: [String: String] = ["id": idMovie, "role": role]
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
            .decode(type: [Artist].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { result in
                print(result)
                
            }) { result in
                print(result)
                switch role {
                case "1":
                    self.directors = result
                case "2":
                    self.writers = result
                case "3":
                    self.cast = result
                default:
                    break
                }
            }
            .store(in: &tasks)
    }
}
