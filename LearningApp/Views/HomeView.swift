//
//  ContentView.swift
//  LearningApp
//
//  Created by Kris Karlsson on 25/2/2022.
//

import SwiftUI

struct HomeView: View {
    
 @EnvironmentObject  var model: ContentModel
    
    
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
