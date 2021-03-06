//
//  ContentModel.swift
//  LearningApp
//
//  Created by Kris Karlsson on 25/2/2022.
//

import Foundation
import AVFoundation

class ContentModel: ObservableObject{
    
    //List of modules
    @Published var modules = [Module]()
    
    //Current module
    
    @Published var currentModule:Module?
    var currentModuleIndex = 0
    
    // Current Lesson
    
    @Published var currentLesson:Lesson?
    var currentLessonIndex = 0
    
    // Current Question
    
    @Published var currentQuestion:Question?
    var currentQuestionIndex = 0
    
    
    //Creat content expliantion
    
    @Published var codeText = NSAttributedString()
    
    // Current selected content and text
    
    @Published var currentConentedSelected:Int?
    @Published var currentTestSelected:Int?
    
    
    
    
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
        codeText = addStyling(currentLesson!.explanation)
        
        
    }
    
        func nextLesson() {
            
            // Advance the lesson index
            
            currentLessonIndex += 1
            
            // check in range
            
            if currentLessonIndex < currentModule!.content.lessons.count {
                
                currentLesson = currentModule?.content.lessons[currentLessonIndex]
                codeText = addStyling(currentLesson!.explanation)
                
        
            } else {
                
                currentLessonIndex = 0
                currentLesson = nil
                
            }
        
             
        
    }
    
    func hasNextLesson ()-> Bool {
        
      return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
        
    }
    
    
    func beginTest(_ moduleId:Int) {
        
        // set the current module
        beginModule(moduleId)
        
        // set the current question
        currentQuestionIndex = 0
        
        // If there are questions set the current question to the first 1
        
        if currentModule?.test.questions.count ?? 0 > 0  {
            
            
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
            

            
        }
        
    }
    

    func nextQuestion() {
        
        // Advance question index
        
        currentQuestionIndex += 1
        
        
        // Check still within the range of question
        
        if currentQuestionIndex < currentModule!.test.questions.count {
            
            // Set the current question
            
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            codeText = addStyling(currentQuestion!.content)
        }
        
        else {
        
            //if not, then rest the properties
             currentQuestionIndex = 0
            currentQuestion = nil
            
            
            
        }
    }
    
    
// MARK: Code Styling

private func addStyling (_ htmlString: String) -> NSAttributedString {
    
    
    
    var resultString = NSAttributedString()
    var data = Data()
    
    // add styling data
    
    if styleData != nil {
    data.append(styleData!)
        
    }

    // add html data
    
    data.append(Data(htmlString.utf8))
    
    // convert to attributed string
    
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
    }
    
    return resultString

}
}




