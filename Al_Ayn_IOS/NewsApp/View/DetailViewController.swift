//
//  DetailViewController.swift
//  Al_Ayn_IOS
//
//  Created by s ali on 05/02/22.
//


import Foundation
import UIKit
import AlamofireImage




class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishAtLabel: UILabel!
    var article:Article?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Article"
        setupViews()
    }
    

    
    
    private func setupViews()
    {
        if let _article = article
        {
            
            
            titleLabel.text =  _article.title ?? ""
            detailLabel.text =  _article.articleDescription ?? ""
            authorLabel.text = "Article By: " + (_article.author  ?? "")
            publishAtLabel.text = "Date: " + stringToDate(_article.publishedAt ?? "")
            
            if let imageURL = URL(string:(_article.urlToImage ?? ""))
            {
                imageView.af.setImage(withURL: imageURL)
            }
        }
    }
    
    
    
    @IBAction func goToBrowserVC(_ sender: Any)
    {
        performSegue(withIdentifier : "browserVc", sender:  self)
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let browserVc = segue.destination as? BrowserViewController
        {
            browserVc.url = article?.url
        }
    }
    
    
    @IBAction func shareArticle(_ sender: UIButton) {
        
        if let _article = article
        {
            let title = _article.title
            let link = _article.url
            let textShare = [ title , link]
            let activityViewController = UIActivityViewController(activityItems: textShare as! [String] , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    
    }
}

