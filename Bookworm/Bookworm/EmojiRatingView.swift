//
//  EmojiReviewView.swift
//  Bookworm
//
//  Created by Glenn Gijsberts on 21/01/2023.
//

import SwiftUI

struct EmojiReviewView: View {
    let rating: Int16
    
    
    var body: some View {
        switch rating {
        case 1:
            return Text("😔")
        case 2:
            return Text("🫣")
        case 3:
            return Text("😯")
        case 4:
            return Text("🙂")
        default:
            return Text("🤩")
        
        }
    }
}

struct EmojiReviewView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiReviewView(rating: 4)
    }
}
