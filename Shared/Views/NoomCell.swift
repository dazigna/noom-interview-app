//
//  NoomCell.swift
//  InterviewNoom
//
//  Created by Yacine Alami on 07/04/2022.
//

import SwiftUI

struct NoomCell: View {
    @State var item: Fruit
    var body: some View {
        Text(item.name)
    }
}

struct NoomCell_Previews: PreviewProvider {
    static var previews: some View {
        NoomCell(item: Fruit(id: 0, name: "banana"))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
