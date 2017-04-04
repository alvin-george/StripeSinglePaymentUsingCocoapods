//
//  ShippingInfoViewController.swift
//  StripeIntegrationUsingCocoapods
//
//  Created by Pushpam Group on 03/04/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit

protocol ShippingDetailsDelegate {
    
    func getUserShippingDetails(shippingDetails: [String : String])
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
    var userShippingDetails = [String:String]()
        
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
    func showAlert (title:String, messsage:String){
        
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        if (nameTextField.text != ""){
            userShippingDetails["name"] = nameTextField.text!
        }
        if (addressTextField.text != "")
        {
            userShippingDetails["addresss"] = addressTextField.text!
        }
        if (apertmentTextField.text != ""){
            userShippingDetails["apartment"] = apertmentTextField.text!
        }
        if (cityTextField.text != ""){
            userShippingDetails["city"] = cityTextField.text!
        }
        if (stateTextField.text != ""){
            userShippingDetails["state"] = stateTextField.text!
        }
        if (zipcodeTextField.text != ""){
            userShippingDetails["zip_code"] = zipcodeTextField.text!
        }
        if (countryTextField.text != ""){
            userShippingDetails["country"] = countryTextField.text!
        }
        if (mobilenumberTextField.text != ""){
            userShippingDetails["mobile_number"] = mobilenumberTextField.text!
        }
        
        //nil check
        if (userShippingDetails.isEmpty){
            showAlert(title: "Empty", messsage: "Please add relevant informations")
        }
        else {
            
            if (userShippingDetails.count < 8){
                showAlert(title: "Not completed", messsage: "Please add missing informations")
            }
            else {
                
                print("card Data Dict : \(userShippingDetails)")
                
                //share delegate
                shipping_delegate.getUserShippingDetails(shippingDetails: userShippingDetails)
                self.navigationController?.popViewController(animated: true)
            }
        }
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
