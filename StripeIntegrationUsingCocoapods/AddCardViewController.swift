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
    func getUserCardDetails(cardDetails: [Dictionary<String,String>])
}

class AddCardViewController: UIViewController, UITextFieldDelegate,STPPaymentCardTextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var saveforUserSwitch: UISwitch!
    @IBOutlet var cardNumberView: UIView!
    @IBOutlet var mobileNumberTextField: UITextField!
    
    var delegate: CardDetailsDelegate!
    
    var paymentTextField = STPPaymentCardTextField()
    var userCardDetails = [Dictionary<String,String>]()
    
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
        //share delegate
        
        if (emailTextField.text != nil){
            userCardDetails.append(["key":"email", "value": emailTextField.text!])
        }
        if (paymentTextField.cardNumber != nil)
        {
            userCardDetails.append(["key":"card_number", "value": paymentTextField.cardNumber!])
            
        }
        if (mobileNumberTextField.text != nil){
            userCardDetails.append(["key": "mobile_number", "value": mobileNumberTextField.text!])
        }

        
        delegate?.getUserCardDetails(cardDetails: userCardDetails)
        self.navigationController?.popViewController(animated: true)
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
