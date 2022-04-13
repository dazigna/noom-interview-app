//
//  NoomViewModel.swift
//  InterviewNoom
//
//  Created by Yacine Alami on 07/04/2022.
//

import Foundation


class NoomViewModel: ObservableObject{
    
    @Published var searchText: String = ""
    @Published var items: [Fruit] = []
    
    var selectedItem: Fruit?
    
    private var networkManager: NetworkInterface
    
    init(netManager: NetworkInterface = NetworkManager()){
        self.networkManager = netManager
    }
    
    @MainActor
    func triggerSearch(){
        Task{
            let resultFruits = await networkManager.getAll()
            switch resultFruits{
            case .success(let fruits):
                self.items = fruits.filter{$0.name.contains(searchText)}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @MainActor
    func loadItems(){
        Task{
            let resultFruits = await networkManager.getAll()
            switch resultFruits{
            case .success(let fruits):
                self.items = fruits
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @MainActor
    func getItems(){
        Task{
            let resultFruits = await networkManager.getAll()
            switch resultFruits{
            case .success(let fruits):
                self.items = fruits.filter{$0.name.contains(searchText)}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @MainActor
    func resetItems(){
        self.loadItems()
    }
    
    
    func navigateToDetails(item: Fruit){
        self.selectedItem = item
    }
    
}
