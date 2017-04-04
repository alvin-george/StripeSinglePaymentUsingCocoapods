//
//  ViewController.swift
//  StripeIntegrationUsingCocoapods
//
//  Created by Pushpam Group on 03/04/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit
import Stripe

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var productListTableView: UITableView!
    
    var productAndPrices: [String:Int] = [:]
    var selectedProduct:String?
    var selectedProductPrice:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden =  true
        
        
        productAndPrices = ["👕": 2000,"👖": 4000, "👗": 3000, "👞": 700, "👟": 600,"👠": 1000,"👡": 2000,"👢": 2500,"👒": 800,"👙": 3000,"💄": 2000,"🎩": 5000,"👛": 5500, "👜": 6000, "🕶": 2000,"👚": 2500]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return productAndPrices.count
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ProductListTableCell = tableView.dequeueReusableCell(withIdentifier: "productListTableCell") as! ProductListTableCell
        
        let product = Array(self.productAndPrices.keys)[(indexPath as NSIndexPath).row]
        let price = self.productAndPrices[product]!
        
        let thumbnailImage = (product.convertToImage()) as UIImage
        cell.productImage.image = thumbnailImage
        cell.productPriceLabel.text = "$\(price/100).00"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedProduct = Array(self.productAndPrices.keys)[(indexPath as NSIndexPath).row]
        selectedProductPrice =  Array(self.productAndPrices.values)[(indexPath as NSIndexPath).row]
        
        self.performSegue(withIdentifier: "segueToPurchaseViewController", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! PurchaseViewController
        destinationVC.productImageName =  selectedProduct
        destinationVC.productPriceInfo = String(describing: selectedProductPrice)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//Additional
extension String {
    func convertToImage() -> UIImage {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

