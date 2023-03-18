//
//  ViewController.swift
//  MapRandomizerApp
//
//  Created by CHRISTIAN BOURQUIN on 2/14/23.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var currentLocation : CLLocation!
    let locationManager = CLLocationManager()
    var testing = 0
    let userLat = 42.2371
    let userLong = -88.3225
   var selectedCell = ""
    var parks : [MKMapItem] = []
    var selectedArray : [String] = []
    var distanceSelectedArray : [String] = []
    var done = 0

    var tempSelectedArray : [String] = []
    var tempDistanceSelectedArray : [String] = []
    var intoLong : [Double] = []
    var intoLat : [Double] = []
    var tempIntoLong : [Double] = []
    var tempIntoLat : [Double] = []
    var x = 0.05
    var y = 0.05
    @IBOutlet weak var radiusArrayOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelOutlet.isHidden = true
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
        let center = CLLocationCoordinate2D(latitude: userLat, longitude: userLong)
        //let center2 = locationManager.location!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: x, longitudeDelta: y)
        var region = MKCoordinateRegion(center: center, latitudinalMeters: 1600, longitudinalMeters: 1600)
        //var region2 = MKCoordinateRegion(center: center2, span: span)
        mapView.setRegion(region, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "myCell")!
        cell.detailTextLabel?.text = "\(distanceSelectedArray[indexPath.row]) mi"
        cell.textLabel?.text = selectedArray[indexPath.row]
        return cell
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        for annotation in self.mapView.annotations {
                self.mapView.removeAnnotation(annotation)
            }
        selectedArray.removeAll()
        distanceSelectedArray.removeAll()
        intoLat.removeAll()
        intoLong.removeAll()
        let request = MKLocalSearch.Request()
        let center = CLLocationCoordinate2D(latitude: userLat, longitude: userLong)
        request.naturalLanguageQuery = textFieldOutlet.text ?? ""
        let span = MKCoordinateSpan(latitudeDelta: x, longitudeDelta: y)
        var region = MKCoordinateRegion(center: center, latitudinalMeters: (x*69)*1609
, longitudinalMeters: (y*69)*1609)
        mapView.setRegion(region, animated: true)

        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        let search = MKLocalSearch(request: request)
        search.start { [self] (response, error) in
            guard let response = response
            else{return}
            for mapItem in response.mapItems{
                let annotation = MKPointAnnotation()
                self.parks.append(mapItem)
                annotation.coordinate = mapItem.placemark.coordinate
                let lat = mapItem.placemark.coordinate.latitude
                let long = mapItem.placemark.coordinate.longitude
                //loop through and only remove the ones with check marks
                let user = CLLocation(latitude: self.userLat, longitude: self.userLong)
                let currentLoc = CLLocation(latitude: lat, longitude: long)
                let preDistance = (user.distance(from: currentLoc))/1609
                let distance = ceil(preDistance * 100) / 100.0

                for i in 0...self.selectedArray.count {
                    let indexPath = IndexPath(row: i, section: 0)
                    
                    if let cell = self.tableViewOutlet.cellForRow(at: indexPath){
                        cell.accessoryType = .none
                                            }
                }
               
                self.distanceSelectedArray.append(String(distance))
                self.intoLong.append(long)
                self.intoLat.append(lat)
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
                self.selectedArray.append(mapItem.name ?? "")
                self.tableViewOutlet.reloadData()
                print(self.selectedArray.count)
                if self.selectedArray.count > 1{
                    self.done = 1
                }
                else {
                    self.done = 0
                }
            }
            
        }
        /*
        let p = tempSelectedArray.count
        if tempSelectedArray.count > 0 {
            for i in 0...p {
                
               
                distanceSelectedArray.insert(tempDistanceSelectedArray[i], at: 1)
                selectedArray.insert(tempSelectedArray[i], at: i)
                self.tableViewOutlet.reloadData()
                
            }

        }
         */
    }
    
    
    
    @IBAction func radiusSearchAction(_ sender: Any) {
        if let out = Double(radiusArrayOutlet.text!) {
            x = out/69
            y = out/69
            print(x*69)
            print(selectedArray.count)
        }
        else{
            x = 0.05
            y = 0.05
        }
        searchAction(sender)
    }
    
    
    
    @IBAction func directionsAction(_ sender: Any) {
        if labelOutlet.isHidden == true{
            print("bye")
            labelOutlet.textColor = .blue
            labelOutlet.text = "1) first you will enter catagory of places you would like to visit, for example:parks,food,cities \n2) click the search once you have chosen a catagory\n3) the search range will automatically be 3.5 miles but you can enter miles and click search\n4) if you wish to save any of the locations then click them and they will save once randomized\n5) lastly you will click randomize to give you a random location for you and your friends to go to"
            labelOutlet.isHidden = false
        }
        else{
            print("hi")
            labelOutlet.isHidden = true
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none{
                cell.accessoryType = .checkmark
                
               
                self.tempDistanceSelectedArray.append((cell.detailTextLabel?.text)!)
                self.tempSelectedArray.append((cell.textLabel?.text)!)
                var indexx = -1
                for i in 0...self.selectedArray.count {
                    if (tempSelectedArray[i] == (cell.textLabel?.text)) {
                            indexx = i;
                            break;
                        }
                }
                self.tempIntoLat.append(intoLat[indexx])
                self.tempIntoLong.append(intoLong[indexx])
            }
            else{
                cell.accessoryType = .none
                var index = -1
                for i in 0...self.selectedArray.count {
                    if (tempSelectedArray[i] == (cell.textLabel?.text)) {
                            index = i;
                            break;
                        }
                }
                tempSelectedArray.remove(at: index)
                tempDistanceSelectedArray.remove(at: index)
                tempIntoLat.remove(at: index)
                tempIntoLong.remove(at: index)
            }
            }
    }
   
    @IBAction func toScreenAction(_ sender: UIBarButtonItem) {
        if done == 1 {
            performSegue(withIdentifier: "toRandomScreen", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! secondViewController
        nvc.incoming = selectedArray
        nvc.incomingD = distanceSelectedArray
        nvc.tIncoming = tempSelectedArray
        nvc.tIncomingD = tempDistanceSelectedArray
        nvc.incomingLat = intoLat
        nvc.incomingLong = intoLong
        nvc.tIncomingLat = tempIntoLat
        nvc.tIncomingLong = tempIntoLong
        
    }
}

