//
//  PurchaseViewController.swift
//  StripeIntegrationUsingCocoapods
//
//  Created by Pushpam Group on 03/04/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit
import Stripe
import Alamofire

class PurchaseViewController: UIViewController, STPPaymentContextDelegate,STPPaymentCardTextFieldDelegate {
    
    
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
    
    
    let paymentTextField = STPPaymentCardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentTextField.frame =  CGRect(x: 15,y: 199 ,width: self.view.frame.size.width-30,height: 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
       // buyButton.isHidden = true;
        
        
        
        
        if productPriceInfo != nil{
            productPrice.setTitle("$ "+self.productPriceInfo , for: UIControlState.normal)
        }
        
        let thumbnailImage = (productImageName.convertToImage()) as UIImage
        self.productImage.image = thumbnailImage
        
        
    }
    @IBAction func selectPaymentButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "segueToAddCardViewController", sender: self)
    }
    
    @IBAction func buynowButtonClicked(_ sender: Any) {
        // Initiate the card
        // self.paymentContext.requestPayment()
        
        let card = paymentTextField.cardParams
        
        STPAPIClient.shared().createToken(withCard: card, completion: {(token, error) -> Void in
            if let error = error {
                print(error)
            }
            else if let token = token {
                print(token)
                self.chargeUsingToken(token: token)
            }
        })
        
    }
    func chargeUsingToken(token:STPToken) {
        
        let requestString = "https://thawing-inlet-46474.herokuapp.com/charge.php"
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
