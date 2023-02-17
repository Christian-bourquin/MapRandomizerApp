//
//  ViewController.swift
//  MapRandomizerApp
//
//  Created by CHRISTIAN BOURQUIN on 2/14/23.
//

import UIKit
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    var currentLocation : CLLocation!
    let locationManager = CLLocationManager()
    var parks : [MKMapItem] = []
    var selectedArray : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
        let center = CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225)
        let center2 = locationManager.location!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        var region = MKCoordinateRegion(center: center, latitudinalMeters: 1600, longitudinalMeters: 1600)
        var region2 = MKCoordinateRegion(center: center2, span: span)
        mapView.setRegion(region2, animated: true)
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
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
                self.selectedArray.append(mapItem.name ?? "")
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

