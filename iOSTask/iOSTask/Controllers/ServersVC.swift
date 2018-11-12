//
//  ServersVC.swift
//  iOSTask
//
//  Created by Zaid Qattan on 11/9/18.
//  Copyright © 2018 Elsuhud. All rights reserved.
//

import UIKit
import SVProgressHUD

class ServersVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let controller = UISearchController(searchResultsController: nil)

    var currentPage = 0;
    let kLoadingCellTag = 1234;

    @IBOutlet var searchBarView: UIView!
    @IBOutlet var serverTableView: UITableView!
    @IBOutlet var imgGradientLogo: UIImageView!
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var btnAll: UIButton!
    @IBOutlet var btnActive: UIButton!
    @IBOutlet var btnDown: UIButton!
    @IBOutlet var btnAllLocations: UIButton!
    @IBOutlet var topView: UIView!
    @IBOutlet var notificationView: UIView!
    @IBOutlet var btnFilterAll: UIButton!
    
    var JSONResponse = [Root]()
    var ContentResponse = [Content]()
    var filteredServers = [Content]()
    var totalPages: Int = 0
    var btnFilterAllIsHighlighted: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        JSONResponse.removeAll()
        filteredServers.removeAll()
        
        LoadRemoteData()
        self.serverTableView.delegate = self
        self.serverTableView.dataSource = self
        
        setUpViews()
        setUpSearchBar()
        
        
        }
    
    @IBAction func btnFilterAllClicked(_ sender: Any) {
        if(!btnFilterAllIsHighlighted){
            btnFilterAllIsHighlighted = true
            btnFilterAll.backgroundColor = UIColor(hexFromString: "#46A4F7")
            btnFilterAll.setTitleColor(UIColor.white, for: .normal)
        }
        else{
            btnFilterAllIsHighlighted = false
            btnFilterAll.backgroundColor = UIColor(hexFromString: "#F5F5F5")
            btnFilterAll.setTitleColor(UIColor(hexFromString: "#AAAAAA"), for: .normal)
        }
    }

    func setUpSearchBar(){
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.frame = searchBarView.frame
            controller.searchBar.autoresizingMask = .flexibleRightMargin
            definesPresentationContext = true
            self.searchBarView.addSubview(controller.searchBar)
    }
    
    func didDismissSearchController(searchController: UISearchController) {
        setupSearchBarSize()
    }
    
    override func viewDidLayoutSubviews() {
        setupSearchBarSize()
    }
    
    func setupSearchBarSize(){
        controller.searchBar.sizeToFit()
        controller.searchBar.clipsToBounds = true;
        self.controller.searchBar.frame.size.width = self.searchBarView.frame.size.width
    }

    func updateSearchResults(for searchController: UISearchController) {
        setupSearchBarSize()
        filterContentForSearchText(searchController.searchBar.text!)
    }

    func searchBarIsEmpty() -> Bool {
        return controller.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredServers = (ContentResponse.filter({( server : Content) -> Bool in
            return server.name!.lowercased().contains(searchText.lowercased())
        }))
        self.serverTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return controller.isActive && !searchBarIsEmpty()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredServers.count
        }
        else if (currentPage < totalPages) {
            return ContentResponse.count+1;
        }
        return ContentResponse.count;

    }
        func serverCellForIndexPath(indexPath: IndexPath) -> UITableViewCell{
            let cell = self.serverTableView.dequeueReusableCell(withIdentifier: "ServerCell", for: indexPath) as! ServersTableViewCell
            let server: Content
            if isFiltering() {
                server = filteredServers[indexPath.row]
            } else {
                server = ContentResponse[indexPath.row]
            }
            
            //Server Logo
            cell.imgServerLogo.layer.cornerRadius = min(cell.imgServerLogo.frame.size.height, cell.imgServerLogo.frame.size.width) / 2.0
            cell.imgServerLogo.clipsToBounds = true
            cell.imgServerLogo.image = UIImage(named: "datacenter")
            
            cell.btnCheck.layer.cornerRadius = min(cell.imgServerLogo.frame.size.height, cell.btnCheck.frame.size.width) / 2.0
            cell.btnCheck.clipsToBounds = true
            
            cell.btnPhoneCall.layer.cornerRadius = min(cell.btnPhoneCall.frame.size.height, cell.btnPhoneCall.frame.size.width) / 2.0
            cell.btnPhoneCall.clipsToBounds = true
            
            cell.btnTimer.layer.cornerRadius = min(cell.btnTimer.frame.size.height, cell.btnTimer.frame.size.width) / 2.0
            cell.btnTimer.clipsToBounds = true
            
            cell.btnMute.layer.cornerRadius = min(cell.btnMute.frame.size.height, cell.btnMute.frame.size.width) / 2.0
            cell.btnMute.clipsToBounds = true
            
            
            
            //Server Status
            cell.viewServerStatus.layer.cornerRadius = min(cell.imgServerLogo.frame.size.height, cell.viewServerStatus.frame.size.width) / 2.0
            cell.viewServerStatus.clipsToBounds = true
            if(server.status?.id == 1){
                cell.viewServerStatus.backgroundColor = UIColor.green
            }
            else if(server.status?.id == 2){
                cell.viewServerStatus.backgroundColor = UIColor.orange
            }
            else if(server.status?.id == 3){
                cell.viewServerStatus.backgroundColor = UIColor.yellow
            }
            else if(server.status?.id == 4){
                cell.viewServerStatus.backgroundColor = UIColor.red
            }
            //if the id of the status is not matching any of above
            else{
                cell.viewServerStatus.backgroundColor = UIColor.gray
            }
            
            //Server Name, IP, Subnet
            cell.lblServerName.text = server.name
            cell.lblServerIP.text = server.ipAddress
            cell.lblServerSubnet.text = server.ipSubnetMask
            
            //Country Name
            if(server.location == 1){
                cell.lblCountryName.text = "Brasil"
            }
            else{
                cell.lblCountryName.text = "Argentina"
            }
            return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row < ContentResponse.count) {
            return serverCellForIndexPath(indexPath: indexPath);
        } else {
            return self.setUpLoadingCell();
        }

    }
    
    func setUpLoadingCell() -> UITableViewCell{
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center = CGPoint(x: cell.bounds.width / 0.85, y: cell.bounds.height / 0.85)
        cell.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        cell.tag = kLoadingCellTag
        return cell
        
    }
    func removeLoadingCell() -> UITableViewCell{
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (cell.tag == kLoadingCellTag) {
            currentPage = currentPage+1
            self.LoadRemoteData()
        }
    }
    
    func setUpViews(){
    
    imgProfile.layer.cornerRadius = self.imgGradientLogo.frame.size.width / 1.5;
    imgGradientLogo.clipsToBounds = true
    imgGradientLogo.layer.cornerRadius = 10
    imgGradientLogo.layer.borderColor = UIColor.black.cgColor
    imgGradientLogo.layer.borderWidth = 1.0

    controller.searchBar.placeholder = "Search for a server name..."
    controller.searchBar.searchBarStyle = UISearchBar.Style.minimal
    controller.searchBar.isTranslucent = false
    controller.searchBar.barTintColor = UIColor.white
        
    btnAll.layer.cornerRadius = 20;
    btnAll.clipsToBounds = true;
    btnActive.layer.cornerRadius = 20;
    btnActive.clipsToBounds = true;
    btnDown.layer.cornerRadius = 20;
    btnDown.clipsToBounds = true;
    btnAllLocations.layer.cornerRadius = 20;
    btnAllLocations.clipsToBounds = true;
    topView.layer.cornerRadius = 10;
    topView.clipsToBounds = true;
    notificationView.layer.cornerRadius = 5;
    notificationView.clipsToBounds = true;
    }
    
    func LoadRemoteData(){
        let current = self.currentPage
        
        SVProgressHUD.show()
        guard let jsonUrl = URL(string: "http://144.76.67.162:8601/zaid/index.php?page=\(current)&size=10") else {return}
        URLSession.shared.dataTask(with: jsonUrl) { (data, response, err) in
            guard let data = data else {return}
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(Root.self, from: data)
                self.JSONResponse.append(data)
                self.totalPages = data.totalPages!
                for item in data.content!{
                    self.ContentResponse.append(item)
                }
                DispatchQueue.main.async {
                   self.serverTableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            }
            catch let jsonError{
                SVProgressHUD.dismiss()
                print("Error!", jsonError)
            }
            }.resume()

        }
}

