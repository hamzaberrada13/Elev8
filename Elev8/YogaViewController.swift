import UIKit
import CoreLocation
import MapKit
import SafariServices
//import SwiftyJSON


struct Place: Codable {
    let id: Int
    let name, address, number, website, logo: String
    let lat, long: Double

    enum CodingKeys: String, CodingKey {
        case id, name, address, number,logo
        case website = "website"
        case lat, long
    }
}

struct My {
    static var snapShot: UIView? = nil
    static var position: CGFloat? = nil
}


class YogaViewController: UIViewController {
    
    var customView: UIView!
    
    var nameLabel: UILabel!
    var numberLabel: UILabel!
    var websiteLabel: UILabel!
    var directionLabel: UILabel!
    var calloutLogo: UIImageView!
    
    var boxUncheckedGuestPass: UIButton!
    var boxCheckedGuestPass: UIButton!
    
    var boxUncheckedYoga: UIButton!
    var boxCheckedYoga: UIButton!

    var boxUncheckedPilates: UIButton!
    var boxCheckedPilates: UIButton!
    
    var boxUncheckedSpin: UIButton!
    var boxCheckedSpin: UIButton!
    
    var boxUncheckedBasketball: UIButton!
    var boxcheckedBasketball: UIButton!
    
    var boxUncheckedVolleyball: UIButton!
    var boxCheckedVolleyball: UIButton!
    
    var boxUncheckedTennis: UIButton!
    var boxCheckedTennis: UIButton!
    
    var boxUncheckedWeight: UIButton!
    var boxCheckedWeight: UIButton!
    
    var boxUncheckedCrossFit: UIButton!
    var boxCheckedCrossfit: UIButton!
    
    var boxUncheckedBoxing: UIButton!
    var boxCheckedBoxing: UIButton!
    
    var numberButton: UIButton!
    var websiteButton: UIButton!
    var directionButton: UIButton!
    var dragImage: UIImageView!
    
    var filterBy: UILabel!
    var requiresMembership: UILabel!
    var yogaLabel: UILabel!
    var pilatesLabel: UILabel!
    var spinLabel: UILabel!
    var weightLabel: UILabel!
    var basketballLabel: UILabel!
    var tennisLabel: UILabel!
    var volleyballLabel: UILabel!
    var boxingLabel: UILabel!
    var crossfitLabel: UILabel!
    
    var slideupView : UIView!
    
    var panGesture : UIPanGestureRecognizer!
    var slideUpViewTopContraint: NSLayoutConstraint!
    
    var location: Gym?
    
    var checked: String!
    var unchecked: String!
    
    var counterGuessPass: Int! = 0
    var counterYoga: Int! = 0
    var counterPilates: Int! = 0
    
    
    // MARK: - Properties
   

    var locationManager: CLLocationManager!
    
    var mapView: MKMapView!
    
    let centerMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "location-arrow-flat").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCenterLocation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        configureMapView()
        enableLocationServices()
       
        fetchData()
        
        

               mapView.delegate = self
        
    }
    
    // MARK: - Selectors
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer){
        
        customView.isHidden = true
        var translation = gesture.translation(in: self.view)
        if gesture.state == .began {
            print("began")
//            My.snapShot = SnapshotofSliding(inputView: slideupView)
//            view.addSubview(My.snapShot!)
//            My.snapShot?.center = slideupView.center
//            slideupView.isHidden = true
//
//            My.position = slideupView.center.y
//            print(My.position!)
            //let translation = gesture.translation(in: self.view)
            //slideupView.transform = CGAffineTransform(translationX: 0, y: -5)
            
            
            if translation.y < -200 {
                slideupView.transform = CGAffineTransform(translationX: 0, y: translation.y)
                print("this")
                print(translation.y)
            }
            
  //          else if translation.y > -5 {
 //               slideupView.transform = CGAffineTransform(translationX: 0, y: -5)
  //          }
  
        }else if gesture.state == .changed {
            print("changed")
//            if translation.y > -5 {
//                 slideupView.transform = CGAffineTransform(translationX: 0, y: -5)
//            }
            
        
            slideUpViewTopContraint.constant = -50
            
            //let translation = gesture.translation(in: self.view)
            slideupView.transform = CGAffineTransform(translationX: 0, y: translation.y)
             print(translation.y)
        }else if gesture.state == .ended {
            print("ended")
           // slideupView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            if translation.y > -5 {
                 slideupView.transform = CGAffineTransform(translationX: 0, y: -5)
            }
            else if translation.y < -50 {
                slideupView.transform = CGAffineTransform(translationX: 0, y: -285)
            }
            else {
                slideupView.transform = CGAffineTransform(translationX: 0, y: translation.y)
                
            }
           // customView.isHidden = false
        }
        
        }
    
    
    @objc func handleCenterLocation() {
        centerMapOnUserLocation()
        centerMapButton.alpha = 0
    }
    
    // MARK: - Helper Functions
    @objc func buttonAction(sender: UIButton!) {
       // print("this is" + (location?.website)!)
      //  UIApplication.shared.open(URL(string: (location?.website)!)! as URL, options: [:], completionHandler: nil)
       // showWebpage(at: "https://www.google.com")
        
        //      var link = "www.google.com"
//        showWebpage(at: link)
        
        // print("Button tapped")h
        if let phoneNumber = location?.number{
       // var phoneNumber = "2148458555"
            //print(location?.number)
            if let phoneUrl = URL(string: "tel://\(phoneNumber)"){
                //print(phoneUrl)
                UIApplication.shared.open(phoneUrl)
            }
        }
        
    }
    
    @objc func websiteClick(sender: UIButton!) {
    //print("this is" + (location?.website)!)
    UIApplication.shared.open(URL(string: (location?.website)!)! as URL, options: [:], completionHandler: nil)
    }
    
    @objc func guestPassBoxClicked(sender: UIButton!) {
        
        print("clicking the button")
        checked = "baseline_check_box_white_18pt_2x"
        unchecked = "baseline_check_box_outline_blank_white_18pt_2x"
        
        //counter = 0
        if counterGuessPass % 2 == 0 {
            boxUncheckedGuestPass.setImage(#imageLiteral(resourceName: checked).withRenderingMode(.alwaysOriginal), for: .normal)
            counterGuessPass = counterGuessPass + 1
        print(counterGuessPass!)
        }
            else {
                boxUncheckedGuestPass.setImage(#imageLiteral(resourceName: unchecked).withRenderingMode(.alwaysOriginal), for: .normal)
                    counterGuessPass = counterGuessPass + 1
                print(counterGuessPass!)
            }
        
      //  boxUncheckedGuestPass.setImage(#imageLiteral(resourceName: checked).withRenderingMode(.alwaysOriginal), for: .normal)
      //  boxUncheckedGuestPass.setImage(#imageLiteral(resourceName: "baseline_check_box_white_18pt_2x").withRenderingMode(.alwaysOriginal), for: .normal)
    }
    @objc func yogaBoxClicked(sender: UIButton!) {
        print("yooooooogaaaaaaaaaaaa")
        if counterYoga % 2 == 0 {
              boxUncheckedYoga.setImage(#imageLiteral(resourceName: checked).withRenderingMode(.alwaysOriginal), for: .normal)
              counterYoga = counterYoga + 1
          print(counterYoga!)
          }
              else {
                  boxUncheckedYoga.setImage(#imageLiteral(resourceName: unchecked).withRenderingMode(.alwaysOriginal), for: .normal)
                      counterYoga = counterYoga + 1
                  print(counterYoga!)
              }
        
    }
    
    @objc func pilatesBoxClicked(sender: UIButton!) {
           print("pilaaaaaa")
           if counterPilates % 2 == 0 {
        boxUncheckedPilates.setImage(#imageLiteral(resourceName: checked).withRenderingMode(.alwaysOriginal), for: .normal)
                 counterPilates = counterPilates + 1
             print(counterPilates!)
             }
                 else {
                     boxUncheckedPilates.setImage(#imageLiteral(resourceName: unchecked).withRenderingMode(.alwaysOriginal), for: .normal)
                         counterPilates = counterPilates + 1
                     print(counterPilates!)
                 }
           
       }
//    func showWebpage(at address: String) {
//        if let url = URL(string:address){
//            let config = SFSafariViewController.Configuration()
//            config.entersReaderIfAvailable = true
//            let webPageViewController = SFSafariViewController(url: url, configuration: config)
//            webPageViewController.preferredBarTintColor = UIColor.black
//            present(webPageViewController, animated: true)
//        }
//    }
    @objc func addressClick(sender: UIButton!) {
        print("this is" + (location?.locationName)!)
        guard let lat = location?.lat else { return  }
        guard let long = location?.long else { return  }
        let coordinate = CLLocationCoordinate2DMake(lat , long)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = location?.title
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
//        UIApplication.shared.open(URL(string: (location?.website)!)! as URL, options: [:], completionHandler: nil)
        }
    //    func showWebpage(at address: String) {
    //        if let url = URL(string:address){
    //            let config = SFSafariViewController.Configuration()
    //            config.entersReaderIfAvailable = true
    //            let webPageViewController = SFSafariViewController(url: url, configuration: config)
    //            webPageViewController.preferredBarTintColor = UIColor.black
    //            present(webPageViewController, animated: true)
    //        }
    //    }
    
    func fetchData() {
        
        let jsonUrlString = "https://www.elev8dfw.com/Gyms-1.json"
        //let jsonUrlString = "https://www.elev8dfw.com/logo.json"
        
        guard let url = URL(string: jsonUrlString) else {return}

           URLSession.shared.dataTask(with: url) { (data, response, err) in

            guard let data = data else { return }

            do {
                let places = try JSONDecoder().decode([Place].self, from: data)

             
                for place in places {
                    
                    
                    let sampleStarbucks = Gym(title: place.name, locationName: place.address, coordinate: CLLocationCoordinate2D(latitude: place.lat, longitude: place.long), number: place.number, website: place.website, logo: place.logo, lat: place.lat, long: place.long)
                    
                    self.mapView.addAnnotations([sampleStarbucks])
                    
                }

            } catch let jsonErr{
                print("Error serializing json: ", jsonErr)
            }

        }.resume()
        
    }
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func configureMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        
        view.addSubview(mapView)
        mapView.frame = view.frame
        view.addSubview(centerMapButton)
        
        // ADDING SLIDEUP BUTTON
        
        slideupView = UIView()
        
        view.addSubview(slideupView)
        slideupView.backgroundColor = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1.0)
        slideupView.translatesAutoresizingMaskIntoConstraints = false
        slideupView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        slideupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        slideupView.heightAnchor.constraint(equalToConstant: 360).isActive = true
        slideupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        
        slideUpViewTopContraint = NSLayoutConstraint(item: slideupView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -100)
        view.addConstraint(slideUpViewTopContraint)
        
        // ADDING CALLOUT VIEW
        customView = UIView()
        
        view.addSubview(customView)
        customView.backgroundColor = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1.0)
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        customView.trailingAnchor.constraint(equalTo: centerMapButton.leadingAnchor, constant: -20).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        customView.isHidden = true
        //_______________________________________________________
        
        // NAME LABEL
        
        nameLabel = UILabel(frame: CGRect(x: 183, y: 30, width: 105, height: 45))
        
        customView.addSubview(nameLabel)
        nameLabel.text = "name"
        //nameLabel.textColor = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1.0)
        nameLabel.textColor = UIColor.red
        nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font.withSize(25)
        nameLabel.textAlignment = .center
        
        nameLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: customView.rightAnchor, constant: -50).isActive = true

        
        nameLabel.isHidden = true
        
        //________________________________________
        
        //number Label
        numberButton = UIButton()
        numberButton.frame = CGRect(x: 85, y: 40, width: 100, height: 30)
        
        numberButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        customView.addSubview(numberButton)
        
        numberButton.topAnchor.constraint(equalTo: customView.topAnchor, constant: 20).isActive = true
        numberButton.rightAnchor.constraint(equalTo: customView.rightAnchor, constant: -50).isActive = true
        numberButton.setImage(#imageLiteral(resourceName: "baseline_call_white_48pt_1x").withRenderingMode(.alwaysOriginal), for: .normal)
       
        numberButton.contentMode = .scaleAspectFit
        
        
        websiteButton = UIButton()
        websiteButton.frame = CGRect(x: 155, y: 40, width: 100, height: 30)
        websiteButton.addTarget(self, action: #selector(websiteClick), for: .touchUpInside)
        
        customView.addSubview(websiteButton)
        
        websiteButton.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10).isActive = true
        websiteButton.rightAnchor.constraint(equalTo: customView.rightAnchor, constant: -40).isActive = true
        
        websiteButton.setImage(#imageLiteral(resourceName: "baseline_public_white_36pt_1x").withRenderingMode(.alwaysOriginal), for: .normal)
        websiteButton.contentMode = .scaleAspectFit
        //_____________________________________________________
        //Direction
        
   directionButton = UIButton()
        directionButton.frame = CGRect(x: 225, y: 40, width: 100, height: 30)
        directionButton.addTarget(self, action: #selector(addressClick), for: .touchUpInside)

        customView.addSubview(directionButton)

        directionButton.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10).isActive = true
        directionButton.rightAnchor.constraint(equalTo: customView.rightAnchor, constant: -40).isActive = true
        
        directionButton.setImage(#imageLiteral(resourceName: "baseline_directions_white_48pt_1x").withRenderingMode(.alwaysOriginal), for: .normal)
        directionButton.contentMode = .scaleAspectFit
        
        
        filterBy = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
//
        slideupView.addSubview(filterBy)
        filterBy.text = "Filter By:"
        filterBy.textColor = UIColor.white
       filterBy.translatesAutoresizingMaskIntoConstraints = false
        filterBy.font.withSize(25)
        filterBy.textAlignment = .center
//
        filterBy.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:50).isActive = true
        filterBy.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 10).isActive = true
        filterBy.adjustsFontSizeToFitWidth = true

        
                requiresMembership = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
        //
                slideupView.addSubview(requiresMembership)
                requiresMembership.text = "Guest Pass"
                requiresMembership.textColor = UIColor.white
               requiresMembership.translatesAutoresizingMaskIntoConstraints = false
                requiresMembership.font.withSize(10)
                requiresMembership.textAlignment = .center
        //
                requiresMembership.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:80).isActive = true
                requiresMembership.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 50).isActive = true
                requiresMembership.adjustsFontSizeToFitWidth = true
        
        
        yogaLabel = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
          //
                  slideupView.addSubview(yogaLabel)
                  yogaLabel.text = "Yoga"
                  yogaLabel.textColor = UIColor.white
                 yogaLabel.translatesAutoresizingMaskIntoConstraints = false
                  yogaLabel.font.withSize(25)
                  yogaLabel.textAlignment = .center
          
                  yogaLabel.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:110).isActive = true
                  yogaLabel.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 50).isActive = true
                  yogaLabel.adjustsFontSizeToFitWidth = true
        
        
        pilatesLabel = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
            
                    slideupView.addSubview(pilatesLabel)
                    pilatesLabel.text = "Pilates"
                    pilatesLabel.textColor = UIColor.white
                   pilatesLabel.translatesAutoresizingMaskIntoConstraints = false
                    pilatesLabel.font.withSize(25)
                    pilatesLabel.textAlignment = .center
            
                    pilatesLabel.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:140).isActive = true
                    pilatesLabel.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 50).isActive = true
                    pilatesLabel.adjustsFontSizeToFitWidth = true
        
        
        spinLabel = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
                   
                           slideupView.addSubview(spinLabel)
                           spinLabel.text = "Spin"
                           spinLabel.textColor = UIColor.white
                          spinLabel.translatesAutoresizingMaskIntoConstraints = false
                           spinLabel.font.withSize(25)
                           spinLabel.textAlignment = .center
                   
                           spinLabel.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:170).isActive = true
                           spinLabel.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 50).isActive = true
                           spinLabel.adjustsFontSizeToFitWidth = true
        
        basketballLabel = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
                    
                            slideupView.addSubview(basketballLabel)
                            basketballLabel.text = "Basketball"
                            basketballLabel.textColor = UIColor.white
                           basketballLabel.translatesAutoresizingMaskIntoConstraints = false
                            basketballLabel.font.withSize(25)
                            basketballLabel.textAlignment = .center
                    
                            basketballLabel.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:200).isActive = true
                            basketballLabel.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 50).isActive = true
                            basketballLabel.adjustsFontSizeToFitWidth = true
        
        
        volleyballLabel = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
                    
                            slideupView.addSubview(volleyballLabel)
                            volleyballLabel.text = "Volleyball"
                            volleyballLabel.textColor = UIColor.white
                           volleyballLabel.translatesAutoresizingMaskIntoConstraints = false
                            volleyballLabel.font.withSize(25)
                            volleyballLabel.textAlignment = .center
                    
                            volleyballLabel.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:230).isActive = true
                            volleyballLabel.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 50).isActive = true
                            volleyballLabel.adjustsFontSizeToFitWidth = true
        
        
    tennisLabel = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
                          
    slideupView.addSubview(tennisLabel)
    tennisLabel.text = "Tennis"
    tennisLabel.textColor = UIColor.white
    tennisLabel.translatesAutoresizingMaskIntoConstraints = false
    tennisLabel.font.withSize(25)
    tennisLabel.textAlignment = .center
                           
    tennisLabel.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:80).isActive = true
    tennisLabel.rightAnchor.constraint(equalTo: slideupView.rightAnchor, constant: -50).isActive = true
    tennisLabel.adjustsFontSizeToFitWidth = true
        
        
    weightLabel = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
                                 
    slideupView.addSubview(weightLabel)
    weightLabel.text = "Weight Lifting"
    weightLabel.textColor = UIColor.white
    weightLabel.translatesAutoresizingMaskIntoConstraints = false
    weightLabel.font.withSize(25)
    weightLabel.textAlignment = .center
                                  
    weightLabel.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:110).isActive = true
    weightLabel.rightAnchor.constraint(equalTo: slideupView.rightAnchor, constant: -50).isActive = true
    weightLabel.adjustsFontSizeToFitWidth = true
        
        
    crossfitLabel = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
                                     
    slideupView.addSubview(crossfitLabel)
    crossfitLabel.text = "Crossfit"
    crossfitLabel.textColor = UIColor.white
    crossfitLabel.translatesAutoresizingMaskIntoConstraints = false
    crossfitLabel.font.withSize(25)
    crossfitLabel.textAlignment = .center
                                      
    crossfitLabel.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:140).isActive = true
    crossfitLabel.rightAnchor.constraint(equalTo: slideupView.rightAnchor, constant: -50).isActive = true
    crossfitLabel.adjustsFontSizeToFitWidth = true
        
        
        boxingLabel = UILabel(frame: CGRect(x: 83, y: 30, width: 105, height: 45))
                                         
        slideupView.addSubview(boxingLabel)
        boxingLabel.text = "Boxing"
        boxingLabel.textColor = UIColor.white
        boxingLabel.translatesAutoresizingMaskIntoConstraints = false
        boxingLabel.font.withSize(25)
        boxingLabel.textAlignment = .center
                                          
        boxingLabel.topAnchor.constraint(equalTo: slideupView.topAnchor, constant:170).isActive = true
        boxingLabel.rightAnchor.constraint(equalTo: slideupView.rightAnchor, constant: -50).isActive = true
        boxingLabel.adjustsFontSizeToFitWidth = true
//        websiteLabel.isHidden = false
        

        
        boxUncheckedGuestPass = UIButton()
         boxUncheckedGuestPass.frame = CGRect(x: 15, y: 76, width: 28, height: 28)
         boxUncheckedGuestPass.addTarget(self, action: #selector(guestPassBoxClicked), for: .touchUpInside)
         slideupView.addSubview(boxUncheckedGuestPass)
         boxUncheckedGuestPass.topAnchor.constraint(equalTo: slideupView.topAnchor, constant: 80).isActive = true
         boxUncheckedGuestPass.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 30).isActive = true
         boxUncheckedGuestPass.setImage(#imageLiteral(resourceName: "baseline_check_box_outline_blank_white_18pt_2x").withRenderingMode(.alwaysOriginal), for: .normal)
        boxUncheckedGuestPass.contentMode = .scaleAspectFit
        
     
        boxUncheckedYoga = UIButton()
                boxUncheckedYoga.frame = CGRect(x: 15, y: 105, width: 28, height: 28)
                boxUncheckedYoga.addTarget(self, action: #selector(yogaBoxClicked), for: .touchUpInside)
                slideupView.addSubview(boxUncheckedYoga)
                boxUncheckedYoga.topAnchor.constraint(equalTo: slideupView.topAnchor, constant: 80).isActive = true
                boxUncheckedYoga.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 30).isActive = true
                boxUncheckedYoga.setImage(#imageLiteral(resourceName: "baseline_check_box_outline_blank_white_18pt_2x").withRenderingMode(.alwaysOriginal), for: .normal)
               boxUncheckedYoga.contentMode = .scaleAspectFit
        
        boxUncheckedPilates = UIButton()
                   boxUncheckedPilates.frame = CGRect(x: 15, y: 145, width: 28, height: 28)
                   boxUncheckedPilates.addTarget(self, action: #selector(pilatesBoxClicked), for: .touchUpInside)
                   slideupView.addSubview(boxUncheckedPilates)
                   boxUncheckedPilates.topAnchor.constraint(equalTo: slideupView.topAnchor, constant: 80).isActive = true
                   boxUncheckedPilates.leftAnchor.constraint(equalTo: slideupView.leftAnchor, constant: 30).isActive = true
                   boxUncheckedPilates.setImage(#imageLiteral(resourceName: "baseline_check_box_outline_blank_white_18pt_2x").withRenderingMode(.alwaysOriginal), for: .normal)
                  boxUncheckedPilates.contentMode = .scaleAspectFit
       // slideupView.addSubview(boxUncheckedGuestPass)
        
        /*
         websiteButton = UIButton()
         websiteButton.frame = CGRect(x: 155, y: 40, width: 100, height: 30)
         websiteButton.addTarget(self, action: #selector(websiteClick), for: .touchUpInside)
         
         customView.addSubview(websiteButton)
         
         websiteButton.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10).isActive = true
         websiteButton.rightAnchor.constraint(equalTo: customView.rightAnchor, constant: -40).isActive = true
         
         websiteButton.setImage(#imageLiteral(resourceName: "baseline_public_white_36pt_1x").withRenderingMode(.alwaysOriginal), for: .normal)
         websiteButton.contentMode = .scaleAspectFit
         */
    //-------------------------------------------------
        // adding logo to callout
        calloutLogo = UIImageView()
        calloutLogo.backgroundColor = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1.0)
        calloutLogo.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        calloutLogo.image = UIImage()
        
        
   customView.addSubview(calloutLogo)
       
        dragImage = UIImageView()
        dragImage.backgroundColor = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1.0)
        dragImage.frame = CGRect(x: 190, y: 10, width: 60, height: 20)
        dragImage.image = UIImage(named: "baseline_view_headline_white_36pt_1x")
        
        slideupView.addSubview(dragImage)
        
        dragImage.isUserInteractionEnabled = false
        slideupView.isUserInteractionEnabled = true
        
        slideupView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture)))
        
        //---------------------------------------------
        
        
        centerMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        centerMapButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        centerMapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        centerMapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        centerMapButton.layer.cornerRadius = 50 / 2
        centerMapButton.alpha = 0
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000)
        mapView.setRegion(region, animated: true)
    }
    
    func SnapshotofSliding(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        let cellSnapshot: UIView = UIImageView(image:image)
        return cellSnapshot
    }
    
    
}

// MARK: - MKMapViewDelegate

extension YogaViewController: MKMapViewDelegate {
    
    
   func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.centerMapButton.alpha = 1
        }
    }
    
//     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
//    {
//        if let annotation = annotation as? Gym {
//            let identifier = "pin"
//            var view: MKPinAnnotationView
//            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
//                dequeuedView.annotation = annotation
//                view = dequeuedView
//            } else {
//                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                view.canShowCallout = true
//                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
//                //view.rightCalloutAccessoryView = UIView()
//            }
//
//            return view
//        }
//
//        return nil
//    }
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        let location = view.annotation as! Gym
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
//        location.mapItem().openInMaps(launchOptions: launchOptions)
//    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
       
      
        customView.isHidden = false
        //nameLabel.isHidden = false
        //slideupView.isHidden = true
        
        location = view.annotation as? Gym
        guard let location = location else {return}
        
        
  
        nameLabel.text = location.title
     //   directionLabel.text = location.locationName
    //    numberLabel.text = location.number
//        websiteLabel.text = location.website
       // calloutLogo.image = UIImage(data: location.logo as! Data)
       // numberButton.setTitle(location.number, for: .normal)
       // websiteButton.setTitle(location.website, for: .normal)
      //  directionButton.setTitle(location.locationName, for: .normal)
       //print(location.number)
        //print(location.website)
        //print(location.locationName)
        
/// let url = "https://www.elev8dfw.com/wp-content/uploads/2018/12/la-fitness-logo.jpg"
      let url = location.logo
        let imageUrl = URL(string: url!)!
        let imageData = try! Data(contentsOf: imageUrl)
        calloutLogo.image = UIImage(data: imageData)
        //print(location.number)
        
        //slideupView.isHidden = false
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        customView.isHidden = true
        
   
    }
    
    
}

// MARK: - CLLocationManagerDelegate

extension YogaViewController: CLLocationManagerDelegate {
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Location auth status is NOT DETERMINED")
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            centerMapOnUserLocation()
        case .restricted:
            print("Location auth status is RESTRICTED")
        case .denied:
            print("Location auth status is DENIED")
       case .authorizedAlways:
            print("Location auth status is AUTHORIZED ALWAYS")
        case .authorizedWhenInUse:
            print("Location auth status is AUTHORIZED WHEN IN USE")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            centerMapOnUserLocation()
        @unknown default:
            print("Unknown Default")
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.mapView.showsUserLocation = true
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard locationManager.location != nil else { return }
        centerMapOnUserLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
}

