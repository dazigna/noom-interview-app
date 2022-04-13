//
//  InterviewNoomApp.swift
//  Shared
//
//  Created by Yacine Alami on 17/03/2022.
//

import SwiftUI

@main
struct InterviewNoomApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    // Init whatever we need at spin up time and need to keep during the app lifecycle
    init(){
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NoomViewModel())
        }
        .onChange(of: scenePhase){ newScenePhase in
            switch newScenePhase{
            case .active:
                print("app active")
            case .background:
                print("app sent to background")
            case .inactive:
                print("app inactive")
            @unknown default:
                fatalError("Should never reach here")
            }
            
        }
    }
}
