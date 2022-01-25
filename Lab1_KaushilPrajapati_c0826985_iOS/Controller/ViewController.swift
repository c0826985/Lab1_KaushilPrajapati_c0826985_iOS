//
//  ViewController.swift
//  Lab1_KaushilPrajapati_c0826985_iOS
//
//  Created by Kaushil Prajapati on 17/01/22.
//

import UIKit

class ViewController: UIViewController{
    
    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            previousTurn?.setTitle(nil, for: .normal)
                if(cTurn == Turn.Nought)
                {
                cTurn = Turn.Cross
                turnLbl.text = CROSS
                }
                else
                {
                cTurn = Turn.Nought
                turnLbl.text = NOUGHT
                }
        }
    }
        
    enum Turn{
        case Cross
        case Nought
    }
    
    var cScore = 0
    var nScore = 0

    var fTurn = Turn.Cross
    var cTurn = Turn.Cross
    var CROSS = "X"
    var NOUGHT = "O"
    
    var previousTurn: UIButton?
    
    @IBOutlet weak var turnLbl: UILabel!
    @IBOutlet weak var r1: UIButton!
    @IBOutlet weak var r2: UIButton!
    @IBOutlet weak var r3: UIButton!
    @IBOutlet weak var r4: UIButton!
    @IBOutlet weak var r5: UIButton!
    @IBOutlet weak var r6: UIButton!
    @IBOutlet weak var r7: UIButton!
    @IBOutlet weak var r8: UIButton!
    @IBOutlet weak var r9: UIButton!
    @IBOutlet weak var nScoreLbl: UILabel!
    @IBOutlet weak var cScoreLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDraw()
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeleft(_:)))
       
        gesture.direction = .left
        
        view.addGestureRecognizer(gesture)
    }
    
    //variables for storing score of X and O
   
    
    var draw = [UIButton]()
    
   // To Initialize the board
    func initDraw()
    {
        draw.append(r1)
        draw.append(r2)
        draw.append(r3)
        draw.append(r4)
        draw.append(r5)
        draw.append(r6)
        draw.append(r7)
        draw.append(r8)
        draw.append(r9)
    }
    
   
    
    //function on tap action to verify who has won
    @IBAction func tap(_ sender: UIButton){
        previousTurn = sender
        
        add(sender)
        if check(CROSS){
            cScore += 1
            result(title:"Crosses has Won")
        }
        
        if check(NOUGHT){
            nScore += 1
            result(title:"Noughts has Won")
        }
        
        if(fullDraw())
        {
            result(title: "Result is Draw")
        }
        cScoreLbl.text = "Cross:" + String(cScore)
        nScoreLbl.text = "Noughts:"
        + String(nScore)
        
    }
    
    //func to reset on swipeleftgesture
    @IBAction func swipeleft(_ sender: UISwipeGestureRecognizer) {
        
        for button in draw
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(fTurn == Turn.Nought)
        {
            fTurn = Turn.Cross
            turnLbl.text = CROSS
        }
        else if(fTurn == Turn.Cross)
        {
            fTurn = Turn.Nought
            turnLbl.text = NOUGHT
        }
        cTurn = fTurn
    }
    
    //func to be used to check who has won by getting combinations
    func check(_ s :String) -> Bool
    {
        //for Horizontal
        if symbol(r1, s) && symbol(r2, s) && symbol(r3, s)
        {
            return true
        }
            if symbol(r4, s) && symbol(r5, s) && symbol(r6, s)
            {
                return true
            }
                if symbol(r7, s) && symbol(r8, s) && symbol(r9, s)
                {
                    return true
                }
        
        // for Vertical
        if symbol(r1, s) && symbol(r4, s) && symbol(r7, s)
        {
            return true
        }
            if symbol(r2, s) && symbol(r5, s) && symbol(r8, s)
            {
                return true
            }
                if symbol(r3, s) && symbol(r6, s) && symbol(r9, s)
                {
                    return true
                }
        
        //for Diagonal
        if symbol(r1, s) && symbol(r5, s) && symbol(r9, s)
        {
            return true
        }
            if symbol(r3, s) && symbol(r5, s) && symbol(r7, s)
            {
                return true
            }
               
        return false
    }
    
    //will get the string from the func check and returns true if exists
    func symbol(_ button: UIButton, _ sym: String) -> Bool
    {
        return button.title(for: .normal) == sym
    }
    
    //to show alert message after the game is over and also has a reset button which clears the board
    func result(title: String)
    {
        let msg  = "\nCross:" + String(cScore) + "\n\nNoughts:" + String(nScore)
        
        let gg = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        
        gg.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in self.resetDraw()}))
        
        self.present(gg, animated: true)
        
    }
    
    //func for the reset button
    func resetDraw()
    {
        for button in draw
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(fTurn == Turn.Nought)
        {
            fTurn = Turn.Cross
            turnLbl.text = CROSS
        }
        else if(fTurn == Turn.Cross)
        {
            fTurn = Turn.Nought
            turnLbl.text = NOUGHT
        }
        cTurn = fTurn
    }
    
    //to add X or O according to the turns
   func add(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(cTurn == Turn.Nought)
            {
                sender.setTitle(NOUGHT, for: .normal)
                cTurn = Turn.Cross
                turnLbl.text = CROSS
                
            }
            else if(cTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                cTurn = Turn.Nought
                turnLbl.text = NOUGHT
            }
            
            
            
        }
    }
    
    func fullDraw() -> Bool
    {
        for button in draw
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    
    
}

