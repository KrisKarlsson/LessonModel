//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Kris Karlsson on 25/2/2022.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
            
            
        
        }
    }
}
