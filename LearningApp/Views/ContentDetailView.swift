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
        let url =  URL(string: Constants.videohosturl + (lesson?.video ?? ""))
    
        
        
        // only show a video if we get a vaild url
        
        VStack{
        
        if url != nil {
        
            VideoPlayer(player: AVPlayer(url: url!))      .cornerRadius(10)
            
        }
        // Decription
        
            CodeTextView()
            
            
            
        // Show Next Lesson Button if there is One
            
            if model.hasNextLesson() {
            
                Button(action: {
            //Advance the lesson
                    
                model.nextLesson()
                    
                    
                }, label: {
                        
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                                            
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1 ].title)")
                            .foregroundColor(Color.white)
                            .bold()
                        
                        
                    }
                    })
                       }
            
            else {
                // Show complete button instead
                
                Button(action: {
            //Take the user back home screen
                    
                model.currentConentedSelected = nil
                    
                    
                    
                }, label: {
                        
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                         
                        
                        Text("Complete")
                            .foregroundColor(Color.white)
                            .bold()
                        
                        
                    }
                    })
                
            }
    
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
         
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
