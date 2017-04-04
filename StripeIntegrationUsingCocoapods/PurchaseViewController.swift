//
//  PurchaseViewController.swift
//  StripeIntegrationUsingCocoapods
//
//  Created by Pushpam Group on 03/04/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit
import Foundation
import Stripe
import Alamofire

class PurchaseViewController: UIViewController, STPPaymentContextDelegate,STPPaymentCardTextFieldDelegate, CardDetailsDelegate, ShippingDetailsDelegate {
    
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productPrice: UIButton!
    
    @IBOutlet var buyButton: UIButton!
    var productPriceInfo:String = String()
    var productImageName:String!
    
    let stripePublishableKey = "pk_test_Leq79U3DlM2aDJ5GqkrCANWM"
    let backendBaseURL: String? = "https://sample-payment-app.herokuapp.com"
    let companyName = "Emoji Apparel"
    let paymentCurrency = "usd"
    
    // let paymentContext: STPPaymentContext
    
    var cardDetailsDict = [String : String]()
    var shippingDetailsDict = [String : String]()
    
    
    let paymentTextField = STPPaymentCardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentTextField.frame =  CGRect(x: 15,y: 199 ,width: self.view.frame.size.width-30,height: 44)
        paymentTextField.delegate = self
        //view.addSubview(paymentTextField)
        // buyButton.isHidden = true;
        
        
        if productPriceInfo != nil {
            productPrice.setTitle("$ "+self.productPriceInfo , for: UIControlState.normal)
        }
        
        let thumbnailImage = (productImageName.convertToImage()) as UIImage
        self.productImage.image = thumbnailImage
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func selectPaymentButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segueToAddCardViewController", sender: self)
    }
    @IBAction func shippingAddressButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segueToShippingInfoViewController", sender: self)
    }
    
    @IBAction func buynowButtonClicked(_ sender: Any) {
        
        if (cardDetailsDict.isEmpty || shippingDetailsDict.isEmpty)
        {
            self.showAlert(title: "Oops!", messsage: "Please add card and shipping information")
        }
        else{
            
            let card_number = cardDetailsDict["card_number"]! as String
            let expiry_date = cardDetailsDict["month_year"]! as String
            let card_cvc = cardDetailsDict["cvc"]! as String
            
            let stripCard = STPCard()
            
            // Split the expiration date to extract Month & Year
            let expMonth = UInt(expiry_date.substring(from: expiry_date.index(expiry_date.startIndex, offsetBy: +2)))
            let expYear = UInt(expiry_date.substring(from: expiry_date.index(expiry_date.endIndex, offsetBy: -2)))
            
            // Send the card info to Strip to get the token
            stripCard.number = card_number
            stripCard.cvc = card_cvc
            stripCard.expMonth = expMonth!
            stripCard.expYear = expYear!
            
            
            //Validate and send to Stripe Backend and get Token
            STPAPIClient.shared().createToken(withCard: stripCard, completion: {(token, error) -> Void in
                if let error = error {
                    print("toke registartion failed : \(error)")
                    
                    UIAlertView(title: "Please Try Again",message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
                }
                else if let token = token {
                    print(token)
                    self.chargeUsingToken(token: token)
                }
            })
        }
        
    }
    func showAlert (title:String, messsage:String){
        
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func chargeUsingToken(token:STPToken) {
        
        print(token.tokenId)
        
        let requestString = "https://sample-payment-app.herokuapp.com"
        let params = ["stripeToken": token.tokenId, "amount": "200", "currency": "usd", "description": "testRun"]
        
        
        Alamofire.request(requestString,method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print("response : \(response.result.value)")
                }
                break
                
            case .failure(_):
                print("Failure : \(response.result.error)")
                break
                
            }
        }
        
    }
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        
        if textField.valid {
            buyButton.isHidden = false;
        }
    }
    
    
    
    
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didUpdateShippingAddress address: STPAddress, completion: @escaping STPShippingMethodsCompletionBlock) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //set delegate of AddcardVC here
        if let viewController = segue.destination as? AddCardViewController {
            viewController.delegate = self
        }
        else  if let viewController = segue.destination as? ShippingInfoViewController {
            viewController.shipping_delegate = self
        }
        else {
            
        }
    }
    //CardDetails Delegate
    func getUserCardDetails(cardDetails: [String : String]) {
        print("cardDetails : \(cardDetails)")
        self.cardDetailsDict = cardDetails
        
    }
    
    //ShippingDetails Delegate
    func getUserShippingDetails(shippingDetails: [String : String]) {
        print("shippingDetails : \(shippingDetails)")
        self.shippingDetailsDict =  shippingDetails
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
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
