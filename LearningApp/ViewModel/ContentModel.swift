//
//  ContentModel.swift
//  LearningApp
//
//  Created by Kris Karlsson on 25/2/2022.
//

import Foundation

class ContentModel: ObservableObject{
    
    //List of modules
    @Published var modules = [Module]()
    
    //Current module
    
    @Published var currentModule:Module?
    var currentModuleIndex = 0
    
    // Current Lesson
    
    @Published var currentLesson:Lesson?
    var currentLessonIndex = 0
    
    
    var styleData: Data?
    
    init() {
        
        getLocalData()
        
    }
    
    //MARK: DATA METHOD
    
    func getLocalData() {
        
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            self.modules = modules
             
            
            
        }
        catch{
            // log error
            
            print("couldn't parse local data!!!!")
            
        }
         //parse style data
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
          let  styleData = try Data(contentsOf: styleUrl!)
         
            self.styleData = styleData

            
        }
        catch{
            
            // log error
            
            print("coudln't parse style data")
            
            
        }
    }
    
    //MARK: Module Navigation Method
    
    
    func beginModule(_ moduleid:Int) {
        
        
        // Find the index for the module id
        
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
                
                currentModuleIndex = index
                break
            
                
            }
        }
        
        // Set the current Module
        
        currentModule = modules[currentModuleIndex]
         
        
    }
    
    func beginLesson(_ lessonIndex: Int) {
        
        // Check that lesson index is within the range of  module lesson
        
        if lessonIndex < currentModule!.content.lessons.count {
            
             currentLessonIndex = lessonIndex
        }
        else { currentLessonIndex = 0}
        
        
        // Set current lesson
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        
    }
    
}
