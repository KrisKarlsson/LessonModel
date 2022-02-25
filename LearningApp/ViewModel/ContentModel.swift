//
//  ContentModel.swift
//  LearningApp
//
//  Created by Kris Karlsson on 25/2/2022.
//

import Foundation


class ContentModel: ObservableObject{
    
    @Published var modules = [Module]()
    var styleData: Data?
    
    
    init() {
        
        getLocalData()
        
    }
    
    func getLocalData() {
        
        // get a url
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        
        // read the file into a data object
        
        do {
        
        let jsonData = try Data(contentsOf: jsonUrl!)
        let jsonDecoder = JSONDecoder()
        
            
            // try to decode json into array of module
        try modules = jsonDecoder.decode([Module].self, from: jsonData)
            
         // assing parsed modules to an array of module
            
            self.modules = modules
             
            
            
        }
        catch{
            // log error
            
            print("couldn't parse local data")
            
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
}
