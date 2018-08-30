 //
//  MapViewControllerVC.swift
//  Simpobids
//
//  Created by Developer on 30/01/18.
//  Copyright © 2018 i Next Solutions. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
protocol  GetMapLocationProtocol {
    
    func GetUserLocation(selectedLocation:String)
    
 }

 @available(iOS 9.3, *)
 class MapVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UISearchControllerDelegate, UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate{
   
     var delegate: GetMapLocationProtocol?
    @IBOutlet weak var mapV: MKMapView!
    
    @IBOutlet weak var searchBarCity: UISearchBar!
    @IBOutlet weak var tableViewSearch: UITableView!
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    let locationManager = CLLocationManager()
    var cellId = "Cell"
    private var mapChangedFromUserInteraction = false
    var getlat = Double()
    var getlong =  Double()

    var getUserpickLocation = "True"
    
    var getAllLocation = String()
    
    var getlocation = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        self.locationManager.startUpdatingLocation()
        mapV.delegate = self
        self.InterfaceDesign()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
    
        navigationItem.title = "Location"
        
    }
    
   
    
    func InterfaceDesign()  {
        searchCompleter.delegate = self as MKLocalSearchCompleterDelegate

        self.tableViewSearch.isHidden = true
 
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)
        
        // set the text from the data model
        let searchResult = searchResults[indexPath.row]
       
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let completion = searchResults[indexPath.row]
        let searchRequest = MKLocalSearchRequest(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
     
        search.start
            { (response, error) in
                if (response != nil)
                {     print("response id +++++++++++++= ",response ?? String())
                    
                    let coordinate1 = response?.mapItems[0].placemark.coordinate

                    let getLat1 = response?.mapItems[0].placemark.coordinate.latitude
                    print(getLat1 ?? String())
                    let longLat1 = response?.mapItems[0].placemark.coordinate.longitude
                    print(longLat1 ?? String())
                    let span = MKCoordinateSpanMake(0.01, 0.01)
                    let region = MKCoordinateRegion(center: coordinate1! , span: span)
                    let geoCoder = CLGeocoder()
                    let location = CLLocation(latitude:getLat1!, longitude:longLat1!)

                    geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
                        guard let addressDict = placemarks?[0].addressDictionary

                            else {

                                return
                        }

                        addressDict.forEach {
                            print("addressDict",$0)

                        }

                        if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                            print(formattedAddress.joined(separator: ", "))
                        }

                        if let locationName = addressDict["Name"] as? String {
                            print("locationName",locationName)
                            self.getAllLocation = locationName
                        }
                        if let street = addressDict["Thoroughfare"] as? String {
                            print("street",street)
                            
                            self.getAllLocation = self.getAllLocation + "," + street
                        }
                        if let city = addressDict["City"] as? String {
                            
                            self.getAllLocation = self.getAllLocation + "," + city
                        }
                        if let zip = addressDict["ZIP"] as? String {
                            print("zip",zip)
                            
                            self.getAllLocation = self.getAllLocation + "," + zip
                        }
                        if let country = addressDict["Country"] as? String {
                            
                            self.getAllLocation = self.getAllLocation + "," + country
                        }

                        self.getlocation.text = completion.title



                    })
                    
                    self.searchBarCity.text = completion.title
                   
                  
                    self.tableViewSearch.isHidden = true
                    
                   self.searchBarCity.resignFirstResponder()
                
                    self.mapV.setRegion(region, animated: true)
                    self.locationManager.stopUpdatingLocation()
                }
                
        }
       
        }
    private func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mapV.subviews[0]
        //  Look through gesture recognizers to determine whether this region change is from user interaction
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == UIGestureRecognizerState.began || recognizer.state == UIGestureRecognizerState.ended ) {
                    return true
                }
            }
        }
        return false
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            
            getlat = location.coordinate.latitude
            
            getlong = location.coordinate.longitude
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude:getlat, longitude:getlong)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
                guard let addressDict = placemarks?[0].addressDictionary
                    
                    else {
                        
                        return
                }
                
                addressDict.forEach {
                    print("addressDict",$0)
                    
                }
                
                if let locationName = addressDict["Name"] as? String {
                    print("locationName",locationName)
                    self.getAllLocation = locationName
                }
                if let street = addressDict["Thoroughfare"] as? String {
                    print("street",street)
                    
                    self.getAllLocation = self.getAllLocation + "," + street
                }
                if let city = addressDict["City"] as? String {
                    
                    self.getAllLocation = self.getAllLocation + "," + city
                }
                if let zip = addressDict["ZIP"] as? String {
                    print("zip",zip)
                    
                    self.getAllLocation = self.getAllLocation + "," + zip
                }
                if let country = addressDict["Country"] as? String {
                    
                    self.getAllLocation = self.getAllLocation + "," + country
                }
                
                self.searchBarCity.text = self.getAllLocation
                self.getlocation.text = self.getAllLocation
                self.delegate?.GetUserLocation(selectedLocation: self.getlocation.text!)
                
                
            })
             mapV.setRegion(region, animated: true)
             self.locationManager.stopUpdatingLocation()
        }
        
           
            }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    @IBAction func showCurrentLoc_btn(_ sender: Any) {
        mapV.showsUserLocation = true
        
    }
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
   
        mapChangedFromUserInteraction = mapViewRegionDidChangeFromUserInteraction()
        if (mapChangedFromUserInteraction) {
          
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
     
        if (mapChangedFromUserInteraction) {
            
            getlat = mapView.centerCoordinate.latitude
            
            getlong = mapView.centerCoordinate.longitude
            
            let geoCoder = CLGeocoder()
            
            let location = CLLocation(latitude:getlat, longitude:getlong)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
                
                guard let addressDict = placemarks?[0].addressDictionary
                    
                    else {
                        
                        return
                }
                
                addressDict.forEach {
                    print("addressDict",$0)
                }
                
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                    print(formattedAddress.joined(separator: ", "))
                }
                
                if let locationName = addressDict["Name"] as? String {
                    print("locationName",locationName)
                     self.getAllLocation = locationName
                }
                if let street = addressDict["Thoroughfare"] as? String {
                    print("street",street)
                    
                    self.getAllLocation = self.getAllLocation + "," + street
                }
                if let city = addressDict["City"] as? String {
                  
                     self.getAllLocation = self.getAllLocation + "," + city
                }
                if let zip = addressDict["ZIP"] as? String {
                    print("zip",zip)
                   
                       self.getAllLocation = self.getAllLocation + "," + zip
                }
                if let country = addressDict["Country"] as? String {
                   
                    self.getAllLocation = self.getAllLocation + "," + country
                }
    
                self.getlocation.text = self.getAllLocation
                self.searchBarCity.text = self.getAllLocation
                self.locationManager.stopUpdatingLocation()
                
            })
           
        }
      
    }
    
    @IBAction func actnBtnDone(_ sender: Any) {
        self.delegate?.GetUserLocation(selectedLocation: self.getlocation.text!)
        self.navigationController?.popViewController(animated: true)
    }
 }
 
 @available(iOS 9.3, *)
 extension MapVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
        
        
    }
 }
 
 @available(iOS 9.3, *)
 extension MapVC: MKLocalSearchCompleterDelegate {
        

        func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            searchResults = completer.results
             self.tableViewSearch.isHidden = false

            self.tableViewSearch.reloadData()
            
        }
    
        func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
            // handle error
    }
 
 }


