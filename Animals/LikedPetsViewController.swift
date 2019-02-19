import Foundation
import UIKit
import Alamofire

var ab = Apicalls()
class LikedpetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    
    var petlist = [Pets]()

    var currentpetlist = [Pets]()


    @IBOutlet weak var likedPetsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        ab.likedpetinfoRetrival() { ( response ) in
            //apicallsobj.request(txtEmail.text!, txtPassword.text!) { ( responseback  ) in
            
            print(response)
            if response.response?.statusCode == 200
            {
                if let petResponse = response.result.value {
                    
                    self.petlist = (petResponse.eresponse?.rdata?.pets)!
                    self.currentpetlist = self.petlist
                    self.likedPetsTableView.delegate = self
                    self.likedPetsTableView.dataSource = self
                    self.likedPetsTableView.reloadData()
                    print(petResponse.eresponse?.rdata?.pets!)
                }
            }
        }
       // setUpSearchBar()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentpetlist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let likedpetlist = currentpetlist[indexPath.row]
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedPetsTableCell") as! LikedPetsTableCell
        cell.setLikedPetsTableCell(name: likedpetlist.Name!, image: likedpetlist.Image!, description: likedpetlist.Description!)
        return cell
    }
    private func setUpSearchBar()
    {
        searchBar.delegate = self
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        // swiftlint:disable identifier_name
        currentpetlist = petlist.filter({ Pets -> Bool in
            guard let text = searchBar.text else { return false }
            return (Pets.Name?.contains(text))!
        })
        likedPetsTableView.reloadData()
        
        
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
    {
        
    }
    
    
    
   /* func likedpetinfoRetrival() {
        
        let urlString = URL(string: "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets/likes")
        // let headers: HTTPHeaders = ["Authorization": token]
        Alamofire.request(urlString!, method: .get).responseObject()
            {(response: DataResponse<Openblock>) in
                print(response)
                if response.response?.statusCode == 200
                {
                    if let petResponse = response.result.value {
                        
                        self.petlist = (petResponse.eresponse?.rdata?.pets)!
                        self.currentpetlist = self.petlist
                        self.likedPetsTableView.delegate = self
                        self.likedPetsTableView.dataSource = self
                        self.likedPetsTableView.reloadData()
                        print(petResponse.eresponse?.rdata?.pets!)
                    }
                }
        }
    } */
}
