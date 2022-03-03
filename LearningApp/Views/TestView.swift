//
//  TestView.swift
//  LearningApp
//
//  Created by Kris Karlsson on 2/3/2022.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex:Int?
    @State var submitted = false
    @State var numCorrect = 0
    

    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack(alignment: .leading) {
                // Question Number
                
                Text("Question \(model.currentQuestionIndex+1) of \(model.currentModule?.test.questions.count ?? 0) ")
                
                
                
                // Question
               CodeTextView()
                    .padding(.horizontal, 20)
                
         
                // Answer
                
                ScrollView {
                    
                    VStack {
                        
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) {index in
                            
                            Button {
                            
                            //track selected index
                         selectedAnswerIndex = index
                            
                            
                        }
                    label:{
                        
                        ZStack {
                            
                            if submitted == false
                            {RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                .frame(height:48)
                            
                            }
                            
                            else {
                                // Answer has been submitted
                                
                                if  index == selectedAnswerIndex &&
                                index == model.currentQuestion!.correctIndex {
                                    
                                    // user has selected correct answer
                                    // show green background
                                    RectangleCard(color: Color.green)
                                        .frame(height:48)
                  
                                }
                                
                                else if
                                    
                                    index == selectedAnswerIndex &&
                                    index != model.currentQuestion!.correctIndex
                                    {
                                       // show red background
                                        
                                    // users has selected wrong answer
                                    // show a red background
                                    
                                        RectangleCard(color: Color.red)
                                            .frame(height:48)
                                    }
                                else if index == model.currentQuestion!.correctIndex{
                                    
                                    // This button is the correct answer
                                    // show a green background
                                    
                                    RectangleCard(color: Color.green)
                                        .frame(height:48)
                                    
                                }
                                
                                else {
                                    
                                    RectangleCard(color: Color.white)
                                        .frame(height:48)
                                    
                                    
                                }
                                
                            }
                            Text(model.currentQuestion!.answers[index])
                        }
                        
                        }.disabled(submitted)
                            
                            
                        }
                         
                    }.padding()
                        .accentColor(.black)
                }

                //button
                
                Button {
                    
                    //Check if answer has been submitted
                    
                    if submitted == true {
                        
                        //Answer has already been submitted move to next question
                        model.nextQuestion()
                        
                        //Reset properties
                        
                        submitted = false
                        selectedAnswerIndex = nil
                    
                        
                    }
                    else {
                        
                        // submitt the answer
                        
                        // Change submitted state to true
                        submitted = true
                     
                        // Check if the answer is correct
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            
                            numCorrect += 1
                        }
                        
                    }
                    
               
                } label: {
                
                ZStack {
                    
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                
                    Text(buttonText)
                        .bold()
                        .padding()
                        .foregroundColor(Color.white)
                    
                }
                .padding()
                
                }
                .disabled(selectedAnswerIndex == nil)
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "")Test")
        }
         else {
            // Test hasn't loaded
            
            ProgressView()
        }

    }
    
    var buttonText: String {
        
        // check if answer has been submitted
         
        if submitted == true {
            
            if model.currentQuestionIndex+1 == model.currentModule!.test.questions.count {
                return "finish"
            }
                 
            
            return "Next"// or finish
        }
         
        else {
            
            return "submit"
            
        }
            
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

