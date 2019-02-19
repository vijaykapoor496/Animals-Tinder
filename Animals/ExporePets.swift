import UIKit
import Poi
import Pods_Animals
import Alamofire
import Kingfisher
import AlamofireObjectMapper


class ExplorePets: UIViewController, PoiViewDataSource, PoiViewDelegate {
    
  
    
    @IBOutlet weak var poiView: PoiView!
    var sampleCards = [Card]()
    var petlist = [Pets]()
    
    let usertoken =  UserDefaults.standard.string(forKey: "session")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         var apicallobj2 = Apicalls()
        apicallobj2.apicall(usertoken!) { (respondedback) in
            let loginresponse = respondedback.result.value
            if loginresponse?.eresponse?.rstatus?.code == 200 {
                
                
                if let newpets =  loginresponse?.eresponse?.rdata?.pets
                {
                    self.petlist = newpets
                    self.createViews()
                    self.poiView.dataSource = self
                    self.poiView.delegate = self
                }
                
            }
            
            
        }
        //apicallsobj.request(txtEmail.text!, txtPassword.text!) { ( responseback  ) in
    }
        
       /*func apicall()
        {
            let usertoken =  UserDefaults.standard.string(forKey: "session")
            let headers: HTTPHeaders = [ "Authorization" : usertoken!]
            let url = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets"
            Alamofire.request(url, headers: headers).responseObject() { (response: DataResponse<Openblock>) in
                let loginresponse = response.result.value
                if loginresponse?.eresponse?.rstatus?.code == 200 {
                    
                    if let newpets =  loginresponse?.eresponse?.rdata?.pets
                    {
                     self.petlist = newpets
                     self.createViews()
                     self.poiView.dataSource = self
                     self.poiView.delegate = self
                    }
                
            }
    
        }
        
        
    } */
    
  /* @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "session")
        self.performSegue(withIdentifier: "logsout", sender: self)

    } */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func createViews() {
        for item in (0..<petlist.count) {
            // swiftlint:disable force_cast
            let card = UINib(nibName: "Card", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! Card
            card.prepareUI(text: self.petlist[item].Name!, img: petlist[item].Image!)
            sampleCards.append(card)
        }
    }
    
    // MARK: PoiViewDataSource
    func numberOfCards(_ poi: PoiView) -> Int {
        return petlist.count
    }
    
    func poi(_ poi: PoiView, viewForCardAt index: Int) -> UIView {
        return sampleCards[index]
    }
    
    func poi(_ poi: PoiView, viewForCardOverlayFor direction: SwipeDirection) -> UIImageView? {
        switch direction {
        case .right:
            let good = UIImageView(image: #imageLiteral(resourceName: "Like"))
            good.tintColor = UIColor.green
            return good
        case .left:
            let bad = UIImageView(image: #imageLiteral(resourceName: "Dislike"))
            bad.tintColor = UIColor.red
            return bad
        }
    }
    
    // MARK: PoiViewDelegate
   func poi(_ poi: PoiView, didSwipeCardAt: Int, in direction: SwipeDirection) {
        let urlString =  "pets/likes/" + petlist[didSwipeCardAt-1].ID!
        let headers: HTTPHeaders = [ "Authorization" : usertoken! ]
        let falseParameters: [String: Any] = [ "liked" : false ]
        let trueParameters: [String: Any] = [ "liked" : true ]
    var apicallobj2 = Apicalls()
        switch direction {
        case .left:
            apicallobj2.updatelikes(direction: "left", urlString, parameters: falseParameters, headers: headers) { (response) in}

        case .right:
            apicallobj2.updatelikes(direction: "right", urlString, parameters: trueParameters, headers: headers) { (response) in}
            
        }
        
    }
    
    @IBAction func logout(_ sender: Any) {
       UserDefaults.standard.set(nil, forKey: "session")
       self.performSegue(withIdentifier: "logsout", sender: self)
    }
    
    func poi(_ poi: PoiView, runOutOfCardAt: Int, in direction: SwipeDirection) {
        print("last")
    }
    
    // MARK: IBAction
    @IBAction func OKAction(_ sender: UIButton) {
        poiView.swipeCurrentCard(to: .right)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        poiView.swipeCurrentCard(to: .left)
    }
    
    @IBAction func undo(_ sender: UIButton) {
        poiView.undo()
    }
}

