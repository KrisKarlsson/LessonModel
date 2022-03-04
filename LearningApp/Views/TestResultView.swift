//
//  TestResultView.swift
//  LearningApp
//
//  Created by Kris Karlsson on 4/3/2022.
//

import SwiftUI

struct TestResultView: View {
   
    @EnvironmentObject var model:ContentModel
    var numCorrect:Int
    var resultHeading: String {
        
        guard model.currentModule != nil else {
            
            return ""
        }
        
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        
        
        if pct > 0.5 {
            return "You Passed"}
        
        else if pct > 0.2 {
            return "Doing Ok"
            
        }
        else {
            return "Keep Learning"
            
        }
         
    }
    
    var body: some View {
       
        VStack {
        
            Spacer()
            
        Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) Questions")
            
            
            Spacer()
            
            
            Button {
                
                //send user back to homeview
                
                model.currentTestSelected = nil
                
                
            } label: {
                
            ZStack {
                
                RectangleCard(color: .green)
                    .frame(height: 48)
                
                
                Text("Complete")
                    .bold()
                    .foregroundColor(.white)
                
            }
            }.padding()
            
            Spacer()
    }
}

//struct TestResultView_Previews: PreviewProvider {
  //  static var previews: some View {
    //    TestResultView()
    //}
}
