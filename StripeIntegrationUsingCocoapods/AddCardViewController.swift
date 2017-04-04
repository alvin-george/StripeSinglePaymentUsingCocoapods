//
//  AddCardViewController.swift
//  StripeIntegrationUsingCocoapods
//
//  Created by Pushpam Group on 03/04/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit
import Stripe

//send back data using delegate
protocol CardDetailsDelegate {
    func getUserCardDetails(cardDetails: [String:String])
}

class AddCardViewController: UIViewController, UITextFieldDelegate,STPPaymentCardTextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var monthYearTextField: UITextField!
    @IBOutlet var cvcTextField: UITextField!
    @IBOutlet var saveforUserSwitch: UISwitch!
    @IBOutlet var cardNumberView: UIView!
    @IBOutlet var mobileNumberTextField: UITextField!
    
    var delegate: CardDetailsDelegate!
    
    var paymentTextField = STPPaymentCardTextField()
    var usercardData = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.navigationController?.isNavigationBarHidden =  true
        
        paymentTextField.frame =  CGRect(x: 10,y: 35 ,width: self.cardNumberView.frame.size.width+20,height: 40)
        paymentTextField.delegate = self
        paymentTextField.backgroundColor = UIColor.white
        cardNumberView.addSubview(paymentTextField)
        
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        
    }
    @IBAction func saveforUseSwitchValueChanged(_ sender: Any) {
        
        
    }
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        if (emailTextField.text != ""){
            usercardData["email"] = emailTextField.text
        }
        if (paymentTextField.cardNumber != "")
        {
            if (paymentTextField.hasText){
                usercardData["card_number"] = paymentTextField.cardNumber!
            }
            
        }
        if (mobileNumberTextField.text != ""){
            usercardData["mobile_number"] = mobileNumberTextField.text!
        }
        if (monthYearTextField.text != ""){
            usercardData["month_year"] = monthYearTextField.text!
        }
        if (cvcTextField.text != ""){
            usercardData["cvc"] = cvcTextField.text!
        }
        
        if (usercardData.isEmpty){
            showAlert(title: "Empty", messsage: "Please add relevant informations")
        }
        else {
            
            if (usercardData.count < 5){
                showAlert(title: "Form not completed", messsage: "Please add missing informations")
            }
            else {
                
                print("card Data Dict : \(usercardData)")
                
                //share delegate
                delegate?.getUserCardDetails(cardDetails: usercardData)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
        
        
    }
    func showAlert (title:String, messsage:String){
        
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
