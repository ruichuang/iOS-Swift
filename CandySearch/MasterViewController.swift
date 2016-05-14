
import UIKit

class MasterViewController: UITableViewController {
    
    // MARK: - Properties
    var filteredCandies = [Candy]()
    var detailViewController: DetailViewController? = nil
    var candies = [Candy]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        candies = [
            Candy(category: "Chocolate", name: "Chocolate Bar"),
            Candy(category: "Chocolate", name: "Chocolate Chip"),
            Candy(category: "Chocolate", name: "Dark Chocolate"),
            
            Candy(category: "Hard", name: "Candy Cane"),
            Candy(category: "Hard", name: "Jaw Breaker"),
            Candy(category: "Hard", name: "Lollipop"),
            
            Candy(category: "Other", name: "Caramel"),
            Candy(category: "Other", name: "Sour Chew"),
            Candy(category: "Other", name: "Gummi Bear")
            
        ]
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard","Other"]
        searchController.searchBar.delegate = self
        
    }
    
    func filterContentForSearchText(searchText: String, scope: String="All") {
        filteredCandies = candies.filter{ candy in
            let categoryMatch = (scope  == "All") || (candy.category == scope)
            return categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searchController.active && searchController.searchBar.text != ""{
            return filteredCandies.count
        }
        return candies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let candy: Candy
        if searchController.active && searchController.searchBar.text != ""{
            candy = filteredCandies[indexPath.row]
        }else{
            candy = candies[indexPath.row]
        }
        
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category
        return cell
    
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let candy: Candy
                if searchController.active && searchController.searchBar.text != ""{
                    candy = filteredCandies[indexPath.row]
                } else {
                    candy = candies[indexPath.row]
                }
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailCandy = candy
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}

extension MasterViewController: UISearchResultsUpdating{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension MasterViewController: UISearchBarDelegate{
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}











