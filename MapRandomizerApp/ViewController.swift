//
//  ViewController.swift
//  MapRandomizerApp
//
//  Created by CHRISTIAN BOURQUIN on 2/14/23.
//

import UIKit
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
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
    var tempSelectedArray : [String] = []
    var tempDistanceSelectedArray : [String] = []
    var x = 0.05
    var y = 0.05
    @IBOutlet weak var radiusArrayOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = textFieldOutlet.text ?? ""
        let span = MKCoordinateSpan(latitudeDelta: x, longitudeDelta: y)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response
            else{return}
            for mapItem in response.mapItems{
                self.parks.append(mapItem)
                let annotation = MKPointAnnotation()
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
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
                self.selectedArray.append(mapItem.name ?? "")
                self.tableViewOutlet.reloadData()
                
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
        }
        else{
            x = 0.05
            y = 0.05
        }
        searchAction(sender)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none{
                cell.accessoryType = .checkmark
                self.tempDistanceSelectedArray.append((cell.detailTextLabel?.text)!)
                self.tempSelectedArray.append((cell.textLabel?.text)!)
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
            }
            }
    }
   
    @IBAction func toScreenAction(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "toRandomScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! secondViewController
        nvc.incoming = selectedArray
        nvc.incomingD = distanceSelectedArray
        nvc.tIncoming = tempSelectedArray
        nvc.tIncomingD = tempDistanceSelectedArray
        
    }
}

