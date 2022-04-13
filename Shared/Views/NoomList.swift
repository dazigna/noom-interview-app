//
//  NoomList.swift
//  InterviewNoom
//
//  Created by Yacine Alami on 07/04/2022.
//

import SwiftUI

struct NoomList: View {
    @Environment(\.isSearching) private var isSearching
    @EnvironmentObject var viewModel: NoomViewModel
    @State private var showDetail: Bool = false

    var body: some View {
        VStack{
            List(viewModel.items, id: \.id){ item in
                NoomCell(item: item).onTapGesture {
                    viewModel.navigateToDetails(item: item)
                    showDetail = true
                    print("TOUCH")
                }
            }
            .onChange(of: isSearching){ newValue in
                if !newValue{
                    viewModel.resetItems()
                }
            }
            NavigationLink("", destination: DetailsView(), isActive: $showDetail)
        }
    }
}

struct NoomList_Previews: PreviewProvider {
    static var previews: some View {
        NoomList().environmentObject(NoomViewModel())
    }
}
