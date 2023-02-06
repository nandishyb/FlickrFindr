//
//  photoRow.swift
//  FlickrFindr
//
//  Created by Nandish Bellad on 02/02/2023.
//

import SwiftUI

struct photoRow: View {
    var photo: Photo
    var body: some View {
        HStack(spacing: 17) {
            AsyncImage(url: photo.photoUrl) { phase in
                if let image = phase.image {
                    image.resizable() // Displays the loaded image.
                } else if phase.error != nil {
                    // Indicates an error.
                    Image(systemName: "photo.on.rectangle.angled")
                        .foregroundColor(.red)
                } else {
                    ProgressView() // Acts as a placeholder.
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)
            Text(photo.title)
        }
    }
}

struct photoRow_Previews: PreviewProvider {
    static var previews: some View {
        photoRow(photo: Photo(id: "52662601223", secret: "c6ca3d4c5f", server: "65535", farm: 66, title: "Just leave me"))
    }
}
