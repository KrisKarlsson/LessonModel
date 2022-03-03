//
//  ContentView.swift
//  LearningApp
//
//  Created by Kris Karlsson on 28/2/2022.
//

import SwiftUI



struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView{
            
            LazyVStack {
                
                // confirm if curren module is set
                
                if model.currentModule != nil {
                     
                
                
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                  
                        
                      NavigationLink(
                        destination: ContentDetailView()
                                .onAppear(perform: {
                                    model.beginLesson(index)
                                     }),
                                     
                                     label: {ContentViewRow(index: index)}
                          )
                                     
                        
                          
                  // LessonCard
                        
                 
                        
             
                    
                }
                
                }
            }
            .accentColor(.black)
            .padding()
            .navigationBarTitle("\(model.currentModule?.category ?? "")Test")
            
    
            
        }
    }
    
        
        
        
        
}


