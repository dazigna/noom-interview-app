//
//  ContentView.swift
//  Shared
//
//  Created by Yacine Alami on 17/03/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: NoomViewModel

    var body: some View {
        NavigationView{
            NoomList()
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt:"Search"){
                }
                .onReceive(viewModel.$searchText.debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
                ){
                    if $0.isEmpty {
                        viewModel.resetItems()
                    } else{
                        viewModel.triggerSearch()
                    }   
                }
                .onSubmit(of: .search) {
                    viewModel.getItems()
                }
                .navigationTitle("Fruits")
        }
        .navigationViewStyle(.stack)
        .onAppear{
            viewModel.loadItems()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(NoomViewModel())
    }
}
