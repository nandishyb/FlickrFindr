//
//  SelectedPhotoView.swift
//  FlickrFindr
//
//  Created by Nandish Bellad on 02/02/2023.
//

import SwiftUI

struct SelectedPhotoView: View {
    var photo: Photo
    var body: some View {
        VStack(spacing: 17) {
            AsyncImage(url: photo.photoUrl) { phase in
                if let image = phase.image {
                    image.resizable() // Displays the loaded image.
                } else if phase.error != nil {
                    // Indicates an error.
                    VStack (spacing: 10) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .foregroundColor(.red)
                        Text("Error fetching the photo!")
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                        Text(phase.error!.localizedDescription)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.all)
                    .border(.red)
                    .shadow(radius: 3)
                } else {
                    ProgressView() // Acts as a placeholder.
                }
            }
            .frame(width: UIScreen.main.bounds.size.width - 2, height: UIScreen.main.bounds.size.width, alignment: .center)
            .cornerRadius(8)
            .aspectRatio(contentMode: .fit)
            Text(photo.title).padding(.horizontal)
        }
    }
}

struct SelectedPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedPhotoView(photo: Photo(id: "52662601223", secret: "c6ca3d4c5f", server: "65535", farm: 66, title: "Just leave me"))
    }
}
