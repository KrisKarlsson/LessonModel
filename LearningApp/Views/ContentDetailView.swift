//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Kris Karlsson on 1/3/2022.
//

import SwiftUI
import AVKit


struct ContentDetailView: View {
    
    @EnvironmentObject var model:ContentModel
    
    
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = 
        
        
        VideoPlayer(player: AVPlayer(url: ))
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
