//
//  MovieView.swift
//  Palo (iOS)
//
//  Created by Hau Huynh on 09/01/2022.
//

import SwiftUI

struct MovieView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let idMovie: String
    @ObservedObject var viewmodel = MovieViewModel()
    
    @State var scrollViewOffset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    
    var body: some View {
        let screenW: CGFloat = UIScreen.main.bounds.width
        let screenH: CGFloat = UIScreen.main.bounds.height
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top
        let bottomPadding = window?.safeAreaInsets.bottom
        ZStack(alignment: .topLeading) {
            if (!(viewmodel.movie?.poster ?? "").isEmpty) {
                AsyncImage(url: URL(string: viewmodel.movie?.poster ?? "")!,
                           placeholder: {Color.black},
                           image: { image in
                    Image(uiImage: image).resizable()
                    
                })
                    .scaledToFill()
                    .frame(width: screenW, height: screenH + 32)
                Rectangle()
                    .frame(width: screenW, height: screenH + 32)
                    .background(.black)
                    .opacity(0.28)
            }
            ScrollView {
                VStack {
                    if (viewmodel.movie != nil) {
                        let movie = viewmodel.movie
                        if (movie?.trailer != nil) {
                            VideoView(idVideo: viewmodel.movie?.trailer ?? "")
                                .frame(width: screenW - 32, height: 200)
                                .cornerRadius(32)
                                .padding(.top, topPadding)
                        }
                        HStack {
                            Text("\(movie?.rating ?? "0")")
                                .padding()
                                .foregroundColor(.white)
                                .background(.orange)
                                .cornerRadius(64, corners: [.topRight, .bottomRight])
                            Spacer()
                            Text(movie?.title ?? "")
                                .padding()
                                .foregroundColor(.white)
                                .background(.orange)
                                .cornerRadius(32, corners: [.topLeft, .bottomLeft])
                        }
                        if (!(movie?.description ?? "").isEmpty) {
                            HStack {
                                Text("Description")
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)
                                    .font(.title3)
                                VStack {
                                    Divider()
                                        .background(.white)
                                }
                            }
                            .padding(.horizontal)
                            VStack {
                                Text((movie?.description)!!)
                                    .padding()
                            }
                            .background(.white.opacity(0.45))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                        let directors: [Artist] = viewmodel.directors
                        ArtistMovieView(title: "Directors", artists: directors)
                        let writers: [Artist] = viewmodel.writers
                        ArtistMovieView(title: "Writer", artists: writers)
                        let cast: [Artist] = viewmodel.cast
                        ArtistMovieView(title: "Cast", artists: cast)
//                            .padding(.bottom, 50)
                        Spacer()
                            .padding(.bottom, 50)
                        
                    }
                }
                .overlay {
                    GeometryReader { proxy -> Color in
                        DispatchQueue.main.async {
                            if startOffset == 0 {
                                self.startOffset = proxy.frame(in: .global).minY
                            }
                            let offset = proxy.frame(in: .global).minY
                            self.scrollViewOffset = offset - startOffset
                        }
                        return Color.clear
                    }
                    .frame(width: 0, height: 0)
                }
            }
            .onAppear {
                viewmodel.fetchMovieDetail(idMovie: self.idMovie, idUser: "1", language: "vi")
            }
            //            .navigationBarBackButtonHidden(true)
            //            .navigationBarItems(leading: btnBack)
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .statusBar(hidden: true)
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.orange)
                        .imageScale(.large)
                        .opacity(scrollViewOffset > 250 ? 1 : 0)
                        .animation(.easeInOut, value: scrollViewOffset)
                }
            }
            .padding(.leading)
            .padding(.top, topPadding)
        }
    }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
