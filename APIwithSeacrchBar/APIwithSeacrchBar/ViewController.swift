//
//  ViewController.swift
//  APIwithSeacrchBar
//
//  Created by Mac on 03/04/23.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
       registerXIB()
        fetchingAPI()
        tableviewDelegateandDatasource()
        seachBarSetUp()
    }
    func seachBarSetUp(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    func registerXIB(){
        let uiNib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(uiNib, forCellReuseIdentifier: "TableViewCell")
    }
    func tableviewDelegateandDatasource(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func fetchingAPI(){
    let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request){
            data , reponse , error in
            print("Data")
            print("Response")
            print("error")

            let getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for dictionary in getJSONObject{
                let eachdictionry = dictionary as! [String:Any]
                let uid = eachdictionry["id"] as! Int
                let utitle = eachdictionry["title"] as! String
                
                var newpost = Post(id: uid, title: utitle)
                self.posts.append(newpost)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        dataTask.resume()
    }
}
extension ViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        if searchText == "" {
            fetchingAPI()
        }else {
            posts = posts.filter{
                $0.title.contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        cell.idlbl.text = "ID : \(posts[indexPath.row].id)"
        cell.namelbl.text = "Title : \(posts[indexPath.row].title)"
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
