//
//  HomeViewController.swift
//  Al_Ayn_IOS
//
//  Created by s ali on 05/02/22.
//

import Foundation
import UIKit
import SideMenu
import AlamofireImage


let reuseIdentifier = "newsItemCell"

class HomeViewController: UIViewController,MenuDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var articles = [Article]()
    private var article:Article?
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News"
        setupSideMenu()
        // setup activity indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // start fetching from server
        fetchNews("top-headlines?sources=techcrunch")
        
    }
    
    
    private func fetchNews(_ searhParams:String)
    {
        activityIndicator.startAnimating()
        
        ApiImp.getNews(params: searhParams ){
            result in
            
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .success(let news):
                self.parseNews(news)
            case .failure(let error):
                let alert = UIAlertController(title: "Oops", message: "Service is not available at the moment please try again later", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                debugPrint(error.localizedDescription)
            }
            
        }
        
    }
    
    private func parseNews(_ news:News)
    {
        if let totalResults = news.totalResults
        {
            if(totalResults > 0)
            {
                articles.removeAll()
                articles = news.articles
                collectionView.reloadData()
                collectionView.layoutIfNeeded()
       
            }
        }
    }
    
    @IBAction func menu(_ sender: Any)
    {
        let lmenuVc = SideMenuManager.default.menuLeftNavigationController
        if(lmenuVc != nil)
        {
            self.present( lmenuVc! , animated: true, completion: nil)
        }
        else
        {
            self.performSegue(withIdentifier:"menu", sender: self)
        }
        
    }
    
    private func setupSideMenu() {
        
        MenuViewViewController.menuDelegate = self
        
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        SideMenuManager.defaultManager.menuPresentMode = .menuSlideIn
        SideMenuManager.defaultManager.menuFadeStatusBar = false
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
    }
    
    
    func onChangeMenuItem(menuItemName: String) {
        
        var searchParams  = "top-headlines?sources=techcrunch"
        switch menuItemName
        {
        case MenuItem.PupolarToday.rawValue:
            
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let dateString = df.string(from: date)
            searchParams  = "everything?q=apple&from=\(dateString)&to=\(dateString)&sortBy=popularity"
            
        case MenuItem.TechCrunch.rawValue:
            searchParams  = "top-headlines?sources=techcrunch"
            
        case MenuItem.WallStreetJournal.rawValue:
            searchParams  = "everything?domains=wsj.com"
            
        default:
            break
        }
        
        fetchNews(searchParams)
    }
    
    
}


extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! NewsItemCell
        
        let article =  self.articles[indexPath.row]
        
        cell.author.text = "Article By: " + (article.author ?? "")
        cell.title.text = article.title ?? ""
        cell.publishAt.text = "Date: " + stringToDate(article.publishedAt ?? "")
        
        if let imageURL = URL(string:(article.urlToImage ?? ""))
        {
            cell.image.af.setImage(withURL: imageURL)
        }

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        article = articles[indexPath.row]
        performSegue(withIdentifier : "detailViewController", sender:  self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let detailVc = segue.destination as? DetailViewController
        {
            detailVc.article = article
        }
    }
    
}



class NewsItemCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var publishAt: UILabel!
    @IBOutlet weak var image: UIImageView!
    
}
