//
//  RegisterViewController.swift
//  DemoApp
//
//  Created by NILESH_iOS on 03/04/18.
//  Copyright © 2018 iDev. All rights reserved.
//

import UIKit
import QuartzCore
import FileBrowser

class RegisterViewController: UIViewController, UIDocumentPickerDelegate {
    @IBOutlet var txtVendorName: HoshiTextField!
    @IBOutlet var txtPinCode: HoshiTextField!
    @IBOutlet var txtEmail: HoshiTextField!
    @IBOutlet var txtFileName: HoshiTextField!
    @IBOutlet var txtDealsIn: HoshiTextField!
    @IBOutlet var txtPassword: HoshiTextField!
    @IBOutlet var btnSignUp: UIButton!
    
    var browseFileName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        btnSignUp.applyGradient(withColours: [#colorLiteral(red: 0.06700000167, green: 0.4819999933, blue: 0.5730000138, alpha: 1), #colorLiteral(red: 0.0390000008, green: 0.3140000105, blue: 0.3689999878, alpha: 1)], gradientOrientation: .horizontal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        present(homeController, animated: true, completion: nil)
    }
    
    func showDocumentBrowser() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 11.0, *) {
            let docController = storyboard.instantiateViewController(withIdentifier: "DocumentBrowserViewController") as! DocumentBrowserViewController
            docController.cDelegate = self
            present(docController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        

    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        showHomeScreen()
    }
    
    @IBAction func browseBtnTapped(_ sender: UIButton) {
//        let fileBrowser = FileBrowser()
//        present(fileBrowser, animated: true, completion: nil)
        if #available(iOS 11.0, *) {
            showDocumentBrowser()
        } else {
            // Fallback on earlier versions
            let fileBrowser = FileBrowser()
            present(fileBrowser, animated: true, completion: nil)
            //openImportDocumentPicker()
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //open document picker controller
    
    func openImportDocumentPicker() {
        //let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        /*  let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import) */
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
        
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    /*
     *
     * Handle Incoming File
     *
     */
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        if controller.documentPickerMode == .import {
            let alertMessage: String = "Successfully imported \(url.absoluteURL)"
        }
    }
    
    /*
     *
     * Cancelled
     *
     */
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Cancelled")
    }
    
    
    
}

extension RegisterViewController: DocumentBrowserViewControllerDelegate {
    func didPickDocument(at documentURL: URL) {
        txtFileName.text = documentURL.lastPathComponent
    }
}

/*
 
 @available(iOS 11.0, *)
 func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
 print(documentURLs[0].absoluteString)
 browseFileName = documentURLs[0].absoluteString
 controller.dismiss(animated: true, completion: nil)
 }
 
 @available(iOS 11.0, *)
 func documentBrowser(_ controller: UIDocumentBrowserViewController, willPresent activityViewController: UIActivityViewController) {
 
 }
 
 @available(iOS 11.0, *)
 func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
 
 }
 
 //    @available(iOS 11.0, *)
 //    func documentBrowser(_ controller: UIDocumentBrowserViewController, applicationActivitiesForDocumentURLs documentURLs: [URL]) -> [UIActivity] {
 //
 //    }
 
 @available(iOS 11.0, *)
 func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
 
 }
 
 @available(iOS 11.0, *)
 func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
 
 }
 
 */
