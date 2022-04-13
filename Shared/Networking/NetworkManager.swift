//
//  NetworkManager.swift
//  InterviewNoom
//
//  Created by Yacine Alami on 07/04/2022.
//

import Foundation


protocol NetworkInterface{
    var networkController: NetworkControllerInterface { get }
    func getAll() async -> Result<[Fruit], Error>
    func getSingle(id: Int) async -> Result<Fruit, Error>
}

class NetworkManager: NetworkInterface{
    let networkController: NetworkControllerInterface
    
    init(controller: NetworkControllerInterface = NetworkController()){
        networkController = controller
    }
    
    func getAll() async -> Result<[Fruit], Error> {
        return await networkController.request(URLSession.shared, request: NetworkRequest.getFruits(host: ServerConfiguration.baseUrl.rawValue))
    }
    
    func getSingle(id: Int) async -> Result<Fruit, Error>{
        return await networkController.request(URLSession.shared, request: NetworkRequest.getSingleFruit(host: ServerConfiguration.baseUrl.rawValue, parameters: ["id": id]))
    }
}
