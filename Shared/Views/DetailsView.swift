//
//  DetailsView.swift
//  InterviewNoom
//
//  Created by Yacine Alami on 07/04/2022.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var viewModel: NoomViewModel
    
    var body: some View {
        VStack{
            Text("Fruit name")
            Text(viewModel.selectedItem?.name ?? "Missing item")
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView().environmentObject(NoomViewModel())
    }
}
