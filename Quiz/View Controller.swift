//
//  ViewController.swift
//  Quiz
//
//  Created by Crispin Lloyd on 02/10/2017.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Create variable for UILayoutGuide object
    var QuestionSpace: UILayoutGuide!
    var QuestionSpaceTwo: UILayoutGuide!
    
    func animateLabelTransitions () {
        //Force any outstanding layout changes to occur
        view.layoutIfNeeded()
        
        //Animate the alpha
        //and the center X constraints
        //let screenWidth = view.frame.width
        //self.nextQuestionLabelCenterXConstraint.constant = 0
        //self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        nextQuestionLabel.centerXAnchor.constraint(equalTo: QuestionSpace.leadingAnchor).isActive = false
        currentQuestionLabel.centerXAnchor.constraint(equalTo: QuestionSpaceTwo.leadingAnchor).isActive = false
        nextQuestionLabel.centerXAnchor.constraint(equalTo: QuestionSpaceTwo.leadingAnchor).isActive = true
        currentQuestionLabel.centerXAnchor.constraint(equalTo: QuestionSpaceTwo.trailingAnchor).isActive = true

        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       //usingSpringWithDamping: 0.2,
                       //initialSpringVelocity: 1,
            
                       options: [.curveLinear],
                       animations: {
                        self.currentQuestionLabel.alpha = 0
                        self.nextQuestionLabel.alpha = 1
                        
                        self.view.layoutIfNeeded()
        },
                       completion: {_ in
                        swap(&self.currentQuestionLabel,
                             &self.nextQuestionLabel)
                        swap(&self.currentQuestionLabelCenterXConstraint,
                             &self.nextQuestionLabelCenterXConstraint)
                        
                        
                        
                        
                        
                       self.updateOffScreenLabel()
            
        }
        
           
        )
        //self.currentQuestionLabelCenterXConstraint.identifier = "Current Question Label"
        //self.nextQuestionLabelCenterXConstraint.identifier = "Next Question Label"
        
        self.currentQuestionLabel.constraintsAffectingLayout(for: NSLayoutConstraint.Axis.horizontal)
        self.nextQuestionLabel.constraintsAffectingLayout(for: NSLayoutConstraint.Axis.horizontal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create UILayoutObject object
        QuestionSpace = UILayoutGuide()
        QuestionSpaceTwo = UILayoutGuide()
        
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        //updateOffScreenLabel()
        
        UILayoutGuideBetweenQuestionLabels()
        
        //Check if UILayoutGuide is being affected by a constraint
        if view.layoutGuides[0].hasAmbiguousLayout == true {
            print("QuestionSpace has ambiguous layout")
        }
        
        //See which constraints are impacting on QuestionSpace
        print(QuestionSpace.constraintsAffectingLayout(for: NSLayoutConstraint.Axis .horizontal))
        print(QuestionSpace.constraintsAffectingLayout(for: NSLayoutConstraint.Axis .vertical))

    }
    
    
    func UILayoutGuideBetweenQuestionLabels() {
        //Add the UILayoutGuide to the main view
        view.addLayoutGuide(QuestionSpace)
        view.addLayoutGuide(QuestionSpaceTwo)

        
        //Create object to represent the safe area of the view controller UIView
        let viewGuide = view.safeAreaLayoutGuide
       
        
        //Set the width constraint for QuestionSpace to the width of view and the centerX constraint to the centerX constraint for view
        
        QuestionSpace.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        QuestionSpace.centerXAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        QuestionSpaceTwo.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        QuestionSpaceTwo.leadingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
        
        
        NSLayoutConstraint.activate([QuestionSpace.topAnchor.constraint(equalToSystemSpacingBelow: viewGuide.topAnchor, multiplier: 1.0),
                                     viewGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: QuestionSpace.bottomAnchor, multiplier: 1.0)])
        
        NSLayoutConstraint.activate([QuestionSpaceTwo.topAnchor.constraint(equalToSystemSpacingBelow: viewGuide.topAnchor, multiplier: 1.0),
                                     viewGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: QuestionSpaceTwo.bottomAnchor, multiplier: 1.0)])

        
        //Sit QuestionSpace between the 2 question labels
        nextQuestionLabel.centerXAnchor.constraint(equalTo: QuestionSpace.leadingAnchor).isActive = true
        currentQuestionLabel.centerXAnchor.constraint(equalTo: QuestionSpaceTwo.leadingAnchor).isActive = true
        nextQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        currentQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
       
        
    }
    
    func updateOffScreenLabel() {
        nextQuestionLabel.centerXAnchor.constraint(equalTo: QuestionSpaceTwo.trailingAnchor).isActive = false
        nextQuestionLabel.centerXAnchor.constraint(equalTo: QuestionSpace.leadingAnchor).isActive = true

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Set the label's initial alpha
        //nextQuestionLabel.alpha = 0


    }
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    
    let questions: [String] = [
    "What is 7+7?",
    "What is the capital of Vermont?",
    "What is cognac made from?"
    ]
    let answers: [String] = [
    "14",
    "Montpelier",
    "Grapes"
    ]
    
    var currentQuestionIndex: Int = 0
    
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex  += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
		    }
    
    
    @IBAction func showAnswer(_ sender: UIButton){
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
}

