//
//  ViewController.swift
//  Lec11Part3
//
//  Created by hackeru on 21/11/2018.
//  Copyright © 2018 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginOrRegister: UIButton!
    
    @IBAction func toggle(_ sender: UISwitch) {
        let text = sender.isOn ? "Login" : "Register"
        loginOrRegister.setTitle(text, for: .normal)
    }
    @IBAction func loginOrRegister(_ sender: UIButton) {
        let register=sender.title(for: .normal) ?? "" == "Register"
        
        if userNameTextField.hasText && passTextField.hasText{
            let name = userNameTextField.text!
            let pass = passTextField.text!
            //let data = imageView.image.pngData()
            let image = imageView.image!
            let data = UIImagePNGRepresentation(image)
            
            let defaults = UserDefaults.standard
            
            if register{
                defaults.set(name, forKey: "user")
                defaults.set(pass, forKey: "pass")
                defaults.set(data, forKey: "image")
            }else{
                //login
                let n = defaults.string(forKey: "user")
                let p = defaults.string(forKey: "pass")
                
                if n == name && p == pass{
                    performSegue(withIdentifier: "loggedIn", sender: nil)
                }
            }
        }else{
            //animate the textfields with error.
        }
    }
    @IBOutlet weak var passTextField: UITextField!{
        didSet{
            passTextField.text = UserDefaults.standard.string(forKey: "pass")
        }
    }
    @IBOutlet weak var userNameTextField: UITextField!{
        didSet{
            userNameTextField.text = UserDefaults.standard.string(forKey: "user")
        }
    }
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            if let data = UserDefaults.standard.data(forKey: "image"){
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//print(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
    }
	
    @IBAction func pickImage(_ sender: UITapGestureRecognizer) {
        //let ip = UIImagePickerController()
        let picker = UIImagePickerController()
        picker.delegate = self
        //picker.sourceType = .camera //!
        //present
        present(picker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = img
        picker.dismiss(animated: true)
        
     	//info[UIImagePickerController.SourceType.originalImage]
    }
}













