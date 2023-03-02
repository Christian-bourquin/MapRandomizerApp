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
    let userLat = 42.2371
    let userLong = -88.3225
   var selectedCell = ""
    var parks : [MKMapItem] = []
    var selectedArray : [String] = []
    var distanceSelectedArray : [String] = []
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
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
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
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        for annotation in self.mapView.annotations {
                self.mapView.removeAnnotation(annotation)
            }
        selectedArray.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = textFieldOutlet.text ?? ""
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
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
                        if cell.accessoryType == .none{
                            
                        }
                        //start work here with removing
                    }
                }
                self.distanceSelectedArray.append(String(distance))
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
                self.selectedArray.append(mapItem.name ?? "")
                self.distanceSelectedArray.sort()
                self.tableViewOutlet.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none{
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
            }
    }
   
    @IBAction func toScreenAction(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "toRandomScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! secondViewController
        nvc.incoming = selectedArray
    }
}

