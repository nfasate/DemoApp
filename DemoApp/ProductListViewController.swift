//
//  ProductListViewController.swift
//  DemoApp
//
//  Created by NILESH_iOS on 05/04/18.
//  Copyright © 2018 iDev. All rights reserved.
//

import UIKit
import AVFoundation

class ProductListViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var photos = Photo.allPhotos()
    var navSearchBtn : UIBarButtonItem?
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Product List"
        
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView!.backgroundColor = UIColor.clear
        collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        addBarButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if processCompleted == true {
            processCompleted = false
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBarButtons()
    {
        navSearchBtn = createSearchBtn()
        navigationItem.rightBarButtonItems  = [navSearchBtn!]
        //addRefreshControl()
    }
    
    /**
     Create group button on for adding view right corner.
     */
    func createSearchBtn() -> UIBarButtonItem
    {
        let btnImage = #imageLiteral(resourceName: "search")
        let imageButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageButton.setBackgroundImage(btnImage, for: UIControlState())
        imageButton.addTarget(self, action: #selector(showNavSearchBar(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: imageButton)
    }
    
    func showSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems  = []
        self.navigationItem.titleView = self.searchBar
        self.searchBar.alpha = 1
        searchBar.transform = CGAffineTransform(translationX: -500, y: searchBar.frame.origin.y)
        searchBar.subviews[0].subviews.flatMap(){ $0 as? UITextField }.first?.tintColor = UIColor.gray
        
        UIView.animate(withDuration: 0.4, animations: {
            self.searchBar.transform = .identity
        }) { (success) in
            self.searchBar.keyboardType = UIKeyboardType.asciiCapable
            self.searchBar.becomeFirstResponder()
        }
    }
    
    func hideSearchBar() {
        self.searchBar.resignFirstResponder()
        UIView.animate(withDuration: 0.6, animations: {
            self.searchBar.transform = CGAffineTransform(translationX: 5000, y: self.searchBar.frame.origin.y)
        }) { (success) in
            self.searchBar.alpha = 0.0
            self.navigationItem.titleView = nil
            self.navigationItem.rightBarButtonItems  = [self.navSearchBtn!]
        }
    }
    
    /**
     Present create group view controller on create group button tapped.
     */
    @objc func showNavSearchBar(_ sender: AnyObject)
    {
        showSearchBar()
    }
    
    func showPurchaseOrderScreen(indexItem: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let payController = storyboard.instantiateViewController(withIdentifier: "payNavigationController") as! UINavigationController
        ctarget = self
        self.present(payController, animated: true, completion: nil)
    }
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photos.count)
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotatedPhotoCell", for: indexPath) as! AnnotatedPhotoCell
        cell.photo = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        showPurchaseOrderScreen(indexItem: indexPath.item)
    }
}

extension ProductListViewController: PinterestLayoutDelegate {
    // 1. Returns the photo height
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        let photo = photos[indexPath.item]
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: photo.image.size, insideRect: boundingRect)
        return rect.size.height
    }
    
    // 2. Returns the annotation size based on the text
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        
        let photo = photos[indexPath.item]
        let font = UIFont(name: "ClanPro-Book", size: 10)!
        let commentHeight = photo.heightForComment(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        return height
    }
}

extension ProductListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
}

extension ProductListViewController: OTPViewControllerDelegate {
    func processComplete() {
        
    }
}
