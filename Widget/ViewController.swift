//
//  ViewController.swift
//  Widget
//
//  Created by Kumar Basant on 22/11/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewLock:UIView!
    
    @IBOutlet weak var txt1:UITextField!
    @IBOutlet weak var txt2:UITextField!
    @IBOutlet weak var txt3:UITextField!
    @IBOutlet weak var txt4:UITextField!
    
    @IBOutlet weak var lblHeading:UILabel!
    @IBOutlet weak var lblError:UILabel!
    var password = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewLock.layer.cornerRadius = 12.0
        viewLock.layer.masksToBounds = true
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
        
        txt1.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        txt2.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        txt3.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        txt4.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        txt1.becomeFirstResponder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txt1.text = ""
        txt2.text = ""
        txt3.text = ""
        txt4.text = ""
        lblError.text = ""
        txt1.backgroundColor = .white
        txt2.backgroundColor = .white
        txt3.backgroundColor = .white
        txt4.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.txt1.becomeFirstResponder()
        })
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        
    }
    @IBAction func showNew(_sender:UIButton){
        self.performSegue(withIdentifier: "lock", sender: nil)
    }
    @objc func textFieldDidChange(textField: UITextField){
        textField.textColor = .green
        let txt = textField.text
        if txt!.count >= 1{
            switch textField{
            case txt1:
                txt1.backgroundColor = UIColor.green
                txt2.becomeFirstResponder()
            case txt2:
                txt2.backgroundColor = UIColor.green
                txt3.becomeFirstResponder()
            case txt3:
                txt3.backgroundColor = UIColor.green
                txt4.becomeFirstResponder()
            case txt4:
                txt4.backgroundColor = UIColor.green
                txt4.resignFirstResponder()
                if !txt1.text!.isEmpty && !txt2.text!.isEmpty && !txt3.text!.isEmpty && !txt4.text!.isEmpty && (txt1.text! + txt2.text! + txt3.text! + txt4.text!) == "1234"{
                    lblError.text = ""
                    self.performSegue(withIdentifier: "lock", sender: nil)
                }else{
                    lblError.text = "Wrong Password"
                    /*let alert = UIAlertController(title: "Alert", message: "Wrong Password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)*/
                    
                }
                
                
            default:
                break
            }
        }else if txt!.count == 0{
            switch textField{
            case txt4:
                txt4.backgroundColor = UIColor.white
                txt3.becomeFirstResponder()
            case txt3:
                txt3.backgroundColor = UIColor.white
                txt2.becomeFirstResponder()
            case txt2:
                txt2.backgroundColor = UIColor.white
                txt1.becomeFirstResponder()
            case txt1:
                txt1.backgroundColor = UIColor.white
                //txt1.resignFirstResponder()
                txt1.becomeFirstResponder()
            default:
                break
            }
        }
    }
}

extension ViewController{
   // func textViewShouldBeginEditing(_ textView: UITextField) -> Bool {
        //        if txt1 == textView && txt1.text!.count >= 1{
        //            txt1.backgroundColor = UIColor.red
        //            txt2.becomeFirstResponder()
        //        }else if txt2 == textView && txt2.text!.count >= 1{
        //            txt2.backgroundColor = UIColor.red
        //            txt3.becomeFirstResponder()
        //        }else if txt3 == textView && txt3.text!.count >= 1{
        //            txt3.backgroundColor = UIColor.red
        //            txt4.becomeFirstResponder()
        //        }else if txt4 == textView && txt4.text!.count >= 1{
        //            txt4.backgroundColor = UIColor.red
        //            //txt2.becomeFirstResponder()
        //        }
        //
        //
        //        return true
        //    }
    
/*
        func textFieldDidEndEditing(_ textField: UITextField) {
            if txt1 == textField && txt1.text!.count >= 1{
                txt1.backgroundColor = UIColor.red
                txt2.becomeFirstResponder()
            }else if txt2 == textField && txt2.text!.count >= 1{
                txt2.backgroundColor = UIColor.red
                txt3.becomeFirstResponder()
            }else if txt3 == textField && txt3.text!.count >= 1{
                txt3.backgroundColor = UIColor.red
                txt4.becomeFirstResponder()
            }else if txt4 == textField && txt4.text!.count >= 1{
                txt4.backgroundColor = UIColor.red
                //txt2.becomeFirstResponder()
            }
        }*/
   /* func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if txt1 == textField && txt1.text!.count >= 1{
            txt1.backgroundColor = UIColor.red
            txt2.becomeFirstResponder()
        }else if txt2 == textField && txt2.text!.count >= 1{
            txt2.backgroundColor = UIColor.red
            txt3.becomeFirstResponder()
        }else if txt3 == textField && txt3.text!.count >= 1{
            txt3.backgroundColor = UIColor.red
            txt4.becomeFirstResponder()
        }else if txt4 == textField && txt4.text!.count >= 1{
            txt4.backgroundColor = UIColor.red
            txt4.becomeFirstResponder()
        }
        return true
    }*/
}
