//
//  MenuVC.swift
//  Al_Ayn_IOS
//
//  Created by s ali on 06/02/22.
//

import UIKit


protocol MenuDelegate{
    func onChangeMenuItem(menuItemName: String)
    
}

enum MenuItem: String {
    case PupolarToday = "Pupolar Today"
    case TechCrunch = "TechCrunch"
    case WallStreetJournal = "Wall Street Journal"
    
}
class MenuViewViewController: UIViewController
{
    @IBOutlet weak var versione: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var profileChars: UILabel!
    
    
    private var data: [String] = []
    @IBOutlet var tableView: UITableView!
    
    static var menuDelegate: MenuDelegate?
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        //   profileChars.text = "\(name.first!)\(lastname.first!)"
        
        
        initMenu()
        
    }
    private func initMenu()
    {
        data.removeAll()
        
        data.append(MenuItem.PupolarToday.rawValue)
        data.append(MenuItem.TechCrunch.rawValue)
        data.append(MenuItem.WallStreetJournal.rawValue)
        
        tableView.reloadData()
        
        let indexPath = IndexPath(row: 1, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        
    }
    
    
    
}


extension MenuViewViewController : UITableViewDelegate,UITableViewDataSource
{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCellMenu") as! CustomCellMenu
        
        let text = data[indexPath.row]
        cell.label?.text = "    " + text
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let _menuItemName = data[indexPath.row]
        dismiss(animated: true, completion:{
            MenuViewViewController.menuDelegate?.onChangeMenuItem(menuItemName: _menuItemName)
        })
        
    }
    
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
}




class CustomCellMenu:UITableViewCell{
    
    @IBOutlet weak var label: UILabel!
    
}


