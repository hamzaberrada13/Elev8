//
//  Venue.swift
//  DucTran-MapKit
//
//  Created by Duc Tran on 9/10/17.
//  Copyright © 2017 Duc Tran. All rights reserved.
//

import MapKit
import AddressBook
//import SwiftyJSON


class Gym: NSObject, MKAnnotation
{
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    let number: String?
    let website: String?
    let logo: String?
    let lat: Double?
    let long: Double?
    
    init(title: String, locationName: String?, coordinate: CLLocationCoordinate2D, number: String, website: String, logo: String, lat: Double, long: Double)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.number = number
        self.website = website
        self.logo = logo
        self.lat = lat
        self.long = long
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
//    class func from(json: JSON) -> Gym?
//    {
//        var title: String
//        if let unwrappedTitle = json["name"].string {
//            title = unwrappedTitle
//        } else {
//            title = ""
//        }
//
//        let locationName = json["location"]["address"].string
//        let lat = json["location"]["lat"].doubleValue
//        let long = json["location"]["lng"].doubleValue
//        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        let number = json["location"]["number"].string
//        let website = json["location"]["website"].string
//        let logo = json["location"]["logo"].string
//
//        return Gym(title: title, locationName: locationName, coordinate: coordinate, number: number!, website: website!, logo: logo!)
//    }
    
    //Open maps and gives you directions
//    func mapItem() -> MKMapItem
//    {
//        let addressDictionary = [String(kABPersonAddressStreetKey) : subtitle]
//        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary as [String : Any])
//        let mapItem = MKMapItem(placemark: placemark)
//
//        mapItem.name = "Allez \(title)"
//
//        return mapItem
//    }
    
  
}











