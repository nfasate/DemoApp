//
//  PurchaseOrderViewController.swift
//  DemoApp
//
//  Created by NILESH_iOS on 05/04/18.
//  Copyright © 2018 iDev. All rights reserved.
//

import UIKit

var ctarget: UIViewController?

class PurchaseOrderViewController: UIViewController {

    @IBOutlet var txtPurchaseDate: HoshiTextField!
    @IBOutlet var txtVendorName: HoshiTextField!
    @IBOutlet var txtPrice: HoshiTextField!
    @IBOutlet var txtUnit: HoshiTextField!
    @IBOutlet var txtQuantity: HoshiTextField!
    @IBOutlet var btnPay: UIButton!
    @IBOutlet var viewDatePicker: UIView!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Purchase order"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        btnPay.applyGradient(withColours: [#colorLiteral(red: 0.0390000008, green: 0.3140000105, blue: 0.3689999878, alpha: 1), #colorLiteral(red: 0.06700000167, green: 0.4819999933, blue: 0.5730000138, alpha: 1)], gradientOrientation: .horizontal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showDatePickerView() {
        viewDatePicker.isHidden = false
        viewDatePicker.transform = CGAffineTransform(translationX: 0, y: viewDatePicker.frame.height)
        self.viewDatePicker.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.viewDatePicker.transform = .identity
        })
    }
    
    func hideDatePickerView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.viewDatePicker.alpha = 0
            self.viewDatePicker.transform = CGAffineTransform(translationX: 0, y: self.viewDatePicker.frame.height)
        }, completion: { (success) in
            self.viewDatePicker.isHidden = true
        })
    }
    
    func showVerifyCustomerScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let verifyController = storyboard.instantiateViewController(withIdentifier: "VerifyCustomerViewController") as! VerifyCustomerViewController
        ctarget?.present(verifyController, animated: true, completion: nil)
    }
    
    @IBAction func payBtnTpped(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            self.showVerifyCustomerScreen()
        }
        
    }
    
    @IBAction func showDatePicker(_ sender: UIButton) {
        self.view.endEditing(true)
        showDatePickerView()
    }
    
    @IBAction func datePickerDoneBtnTapped(_ sender: UIButton) {
        hideDatePickerView()
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let strDate = dateFormatter.string(from: datePicker.date)
        txtPurchaseDate.text = strDate
    }
    
    @IBAction func closeController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerCancelBtnTapped(_ sender: UIButton) {
        hideDatePickerView()
    }
}
