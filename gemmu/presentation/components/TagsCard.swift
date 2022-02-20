//
//  TagsCard.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//

import SwiftUI

struct TagsCard: View {
    var text: String
    var fontSize: CGFloat = 12.0
    var bgColor: Color = Color.green
    var body: some View {
        ZStack {
            Text(text)
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(2)
                .frame(minWidth: 20, maxWidth: 64, alignment: .center)
                .foregroundColor(.white)
                .padding(5)
                .background(bgColor)
                .cornerRadius(5)
        }

    }
}

struct TagsCard_Previews: PreviewProvider {
    static var previews: some View {
        TagsCard(text: "tags")
    }
}
