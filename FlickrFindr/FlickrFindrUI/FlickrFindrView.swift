//
//  FlickrFindrView.swift
//  FlickrFindr
//
//  Created by Nandish Bellad on 02/02/2023.
//

import SwiftUI
import Combine

struct FlickrFindrView: View {
    
    @State private var searchTerm = ""
    
    @ObservedObject var viewModel = FlickrFindrViewModel()
    @State var selectedPhoto:Photo?
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.gray)
                        TextField("Search", text: $searchTerm)
                            .frame(height: 40.0)
                    }
                    Spacer()
                    Button {
                        self.viewModel.fetchError = nil
                        self.viewModel.photos.removeAll()
                        self.viewModel.fetchPhotos(searchTerm: searchTerm)
                    } label: {
                        Text("Search")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .font(.body)
                    }
                    .frame(width: 70 , height: 30)
                    .background(searchTerm.isEmpty ? .gray : .indigo)
                    .cornerRadius(15.0)
                    .shadow(color: .gray, radius: 3 , x: 0.0 , y: 0.0)
                    .disabled(searchTerm.isEmpty)
                    Spacer()
                    if !searchTerm.isEmpty {
                        Button {
                            self.viewModel.fetchError = nil
                            self.viewModel.photos.removeAll()
                            self.searchTerm = ""
                        } label: {
                            Text("Clear").foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.body)
                        }
                        .frame(width: 70 , height: 30)
                        .background(searchTerm.isEmpty ? .gray : .indigo)
                        .cornerRadius(15.0)
                        .shadow(color: .gray, radius: 3 , x: 0.0 , y: 0.0)
                        .disabled(searchTerm.isEmpty)
                        Spacer()
                    }
                }
                .padding(.all)
                
                if let error = viewModel.fetchError {
                    VStack (spacing: 10) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .foregroundColor(.red)
                            Text("Error fetching the photos!")
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.red)
                        }
                        Text(error.domain)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.all)
                    .border(.red)
                    .shadow(radius: 3)
                }
                
                List(viewModel.photos) { photo in
                    NavigationLink {
                        SelectedPhotoView(photo: photo)
                    } label: {
                        photoRow(photo: photo)
                    }
                }
                .scrollDisabled(false)
            }
            .navigationBarTitle(Text("Flickr Findr"))
            .frame(alignment: .center)
        }
    }
}

struct FlickrFindrView_Previews: PreviewProvider {
    static var previews: some View {
        FlickrFindrView()
    }
}
