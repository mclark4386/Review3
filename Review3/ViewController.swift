//
//  ViewController.swift
//  Review3
//
//  Created by Matthew Clark on 12/10/19.
//  Copyright © 2019 Matthew Clark. All rights reserved.
//

import UIKit

enum AccountType {
    case guest, member, editor, admin
}

func accountTypeFromString(type:String)->AccountType{
    switch type {
    case "member":
        return .member
    case "editor":
        return .editor
    case "admin":
        return .admin
    default:
        return .guest
    }
}

func accountTypeFromInt(index:Int)->AccountType{
    switch index {
    case 1:
        return .member
    case 2:
        return .editor
    case 3:
        return .admin
    default:
        return .guest
    }
}

func intFromAccountType(type:AccountType)->Int{
    switch type {
    case .guest:
        return 0
    case .member:
        return 1
    case .editor:
        return 2
    case .admin:
        return 3
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var age: UISlider!
    @IBOutlet weak var ageDisplay: UILabel!
    @IBOutlet weak var accountType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ageDisplay.text = "\(age.value)"
        
        loadUser()
    }

    @IBAction func ageUpdated(_ sender: UISlider) {
        ageDisplay.text = "\(sender.value)"
    }
    
    func loadUser(){
        let prefs = UserDefaults()
        name.text = (prefs.value(forKey: NameKey) as? String) ?? ""
        email.text = (prefs.value(forKey: EmailKey) as? String) ?? ""
        age.value = (prefs.value(forKey: AgeKey) as? Float) ?? 24.0
        accountType.selectedSegmentIndex = (prefs.value(forKey: TypeKey) as? Int) ?? 0
    }
    
    func saveUser(){
        let prefs = UserDefaults()
        prefs.set(name.text, forKey: NameKey)
        prefs.set(email.text, forKey: EmailKey)
        prefs.set(age.value, forKey: AgeKey)
        prefs.set(accountType.selectedSegmentIndex, forKey: TypeKey)
        print("\(accountTypeFromInt(index: accountType.selectedSegmentIndex))")
    }
    
    @IBAction func handleCreate(_ sender: Any) {
        let type = accountTypeFromInt(index: accountType.selectedSegmentIndex)
        
        switch type {
        case .member:
            saveUser()
            performSegue(withIdentifier: "memberSegue", sender: self)
        case .editor:
            saveUser()
            performSegue(withIdentifier: "editorSegue", sender: self)
        case .admin:
            saveUser()
            present(storyboard!.instantiateViewController(withIdentifier: "admin"), animated: true, completion: {print("Now in Admin")})
        case .guest:
            performSegue(withIdentifier: "guestSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "guestSegue" {
            (segue.destination as! GuestViewController).sessionID = "\(arc4random())"
        }
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue){}
}

