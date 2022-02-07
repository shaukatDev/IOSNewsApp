//
//  ViewController.swift
//  Al_Ayn_IOS
//
//  Created by s ali on 04/02/22.
//

import UIKit
import AuthenticationServices



class EntryViewController: UIViewController {
    
    @IBOutlet weak var appleLogInButton: ASAuthorizationAppleIDButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        appleLogInButton.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
        appleLogInButton.cornerRadius = 10
        
        if let userName = UserDefaults.standard.string(forKey: "userName")
        {
            welcomeLabel.text = "Hi " + userName
            appleLogInButton.isHidden = true
            continueButton.setTitle("Tap to continue ...", for: .normal )
            
        }
        
    }
    
    @objc func handleLogInWithAppleID() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
}


extension EntryViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            if let name = appleIDCredential.fullName?.givenName
            {
                // store user id
                let defaults = UserDefaults.standard
                defaults.set(name, forKey: "userName")
                
            }
            
            performSegue(withIdentifier: "homeVc", sender: self)
            break
        default:
            break
        }
    }
}

extension EntryViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
