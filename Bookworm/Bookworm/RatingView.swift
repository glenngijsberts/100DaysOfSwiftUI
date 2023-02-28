//
//  RatingView.swift
//  Bookworm
//
//  Created by Glenn Gijsberts on 21/01/2023.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var star = Image(systemName: "star.fill")
    var maxRating = 5
    
    var body: some View {
        HStack {
            ForEach(1..<6) { number in
                star
                    .foregroundColor(number > rating ? .gray : .yellow)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
