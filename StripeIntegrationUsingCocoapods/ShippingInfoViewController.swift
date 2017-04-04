//
//  ShippingInfoViewController.swift
//  StripeIntegrationUsingCocoapods
//
//  Created by Pushpam Group on 03/04/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit

protocol ShippingDetailsDelegate {
    
    func getUserShippingDetails(shippingDetails: [Dictionary<String,String>])
}

class ShippingInfoViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var apertmentTextField: UITextField!
    
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    
    @IBOutlet var zipcodeTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var mobilenumberTextField: UITextField!
    
    var shipping_delegate: ShippingDetailsDelegate!
    var userShippingDetails = [Dictionary<String,String>]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        if (nameTextField.text != nil){
            userShippingDetails.append(["key":"name", "value": nameTextField.text!])
        }
        if (addressTextField.text != nil)
        {
            userShippingDetails.append(["key":"addresss", "value": addressTextField.text!])
            
        }
        if (apertmentTextField.text != nil){
            userShippingDetails.append(["key": "apartment", "value": apertmentTextField.text!])
            
        }
        if (cityTextField.text != nil){
            userShippingDetails.append(["key": "city", "value": cityTextField.text!])
            
        }
        if (stateTextField.text != nil){
            userShippingDetails.append(["key": "state", "value": stateTextField.text!])
            
        }
        if (zipcodeTextField.text != nil){
            userShippingDetails.append(["key": "zip_code", "value": zipcodeTextField.text!])
            
        }
        if (countryTextField.text != nil){
            userShippingDetails.append(["key": "country", "value": countryTextField.text!])
            
        }
        if (mobilenumberTextField.text != nil){
            userShippingDetails.append(["key": "mobile_number", "value": mobilenumberTextField.text!])
            
        }
        shipping_delegate.getUserShippingDetails(shippingDetails: userShippingDetails)
        
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
