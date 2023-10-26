//
//  LoginPageController.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 22.10.23.
//

import UIKit

class LoginPageController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    let loginEmail = "ziyad@gmail.com"
    let loginPass = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layerConfig()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        checkLogin()
    }
    
}
// Functions: LayerConfig, UserDefault, Notification, Login Check
extension LoginPageController {
    func layerConfig() {
        emailTextField.layer.cornerRadius = 32
        passwordTextField.layer.cornerRadius = 32
        button.layer.cornerRadius = 32
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.masksToBounds = true
        button.layer.masksToBounds = true
    }
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(true, forKey: "loggedIN") //setting the flag
            sceneDelegate.loginClicked(windowScene: scene)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
    
    func checkLogin() {
        if let email = emailTextField.text,
           let password = passwordTextField.text,
           !email.isEmpty,
           !password.isEmpty {
            if (email == loginEmail) && (password == loginPass) {
                setRoot()
                let controller = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                navigationController?.show(controller, sender: nil)
            } else {
                showAlert(title: "Xəta", message: "Email və ya şifrə düzgün daxil edilməyib")
            }
        } else {
            showAlert(title: "Xəta", message: "Düzgün məlumatı daxil edin.")
        }
    }
}
