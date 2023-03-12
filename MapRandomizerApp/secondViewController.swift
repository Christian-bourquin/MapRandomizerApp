//
//  secondViewController.swift
//  MapRandomizerApp
//
//  Created by CHRISTIAN BOURQUIN on 2/16/23.
//

import UIKit
import MapKit
class secondViewController: UIViewController,MKMapViewDelegate {
    var incoming : [String] = []
    var incomingD : [String] = []
    var tIncoming : [String] = []
    var tIncomingD : [String] = []
    var incomingLong : [Double] = []
    var incomingLat : [Double] = []
    var tIncomingLong : [Double] = []
    var tIncomingLat : [Double] = []
    var a = 0
    var b = 0
    var test = 0
var uniIndex = 0
    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    @IBOutlet weak var labelOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewOutlet.delegate = self
        // Do any additional setup after loading the view.
        
//        let request = MKDirections.Request()
//               request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059), addressDictionary: nil))
//               request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667), addressDictionary: nil))
//               request.requestsAlternateRoutes = true
//        request.transportType = .
//
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let overlays = mapViewOutlet.overlays
        mapViewOutlet.removeOverlays(overlays)

         test = Int.random(in:1..<3)
        if test == 1 && tIncoming.count > 0{
             a = Int.random(in: 0..<tIncoming.count)
            labelOutlet.text = "\(tIncoming[a]): \(tIncomingD[a])"

            let request = MKDirections.Request()
                  request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                  request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: tIncomingLat[a], longitude: tIncomingLong[a]), addressDictionary: nil))
                  request.requestsAlternateRoutes = true
                  request.transportType = .automobile

                  let directions = MKDirections(request: request)

                  directions.calculate { [unowned self] response, error in
                      guard let unwrappedResponse = response else { return }

                      for route in unwrappedResponse.routes {
                          self.mapViewOutlet.addOverlay(route.polyline)
                          self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                      }
                  }
            
            
            
            
        }
        else{
             b = Int.random(in: 0..<incoming.count)
            labelOutlet.text = "\(incoming[b]): \(incomingD[b]) mi"
            let request = MKDirections.Request()
                  request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                  request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: incomingLat[b], longitude: incomingLong[b]), addressDictionary: nil))
                  request.requestsAlternateRoutes = true
                  request.transportType = .automobile

                  let directions = MKDirections(request: request)

                  directions.calculate { [unowned self] response, error in
                      guard let unwrappedResponse = response else { return }

                      for route in unwrappedResponse.routes {
                          self.mapViewOutlet.addOverlay(route.polyline)
                          self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                      }
                  }
        }
        
        
        
        
    }

    @IBAction func randomize(_ sender: Any) {
        let overlays = mapViewOutlet.overlays
        mapViewOutlet.removeOverlays(overlays)
         test = Int.random(in:1..<3)
        if test == 1 && tIncoming.count > 0{
             a = Int.random(in: 0..<tIncoming.count)
            labelOutlet.text = "\(tIncoming[a]): \(tIncomingD[a])"
            if uniIndex == 0 {
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: tIncomingLat[a], longitude: tIncomingLong[a]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                      request.transportType = .automobile

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
            else if uniIndex == 1{
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: tIncomingLat[a], longitude: tIncomingLong[a]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                request.transportType = .walking

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
            else if uniIndex == 2{
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: tIncomingLat[a], longitude: tIncomingLong[a]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                request.transportType = .transit

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
        }
        else{
             b = Int.random(in: 0..<incoming.count)
            labelOutlet.text = "\(incoming[b]): \(incomingD[b]) mi"
            
            if uniIndex == 0 {
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: incomingLat[b], longitude: incomingLong[b]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                      request.transportType = .automobile

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
            else if uniIndex == 1{
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: incomingLat[b], longitude: incomingLong[b]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                request.transportType = .walking

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
            else if uniIndex == 2{
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: incomingLat[b], longitude: incomingLong[b]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                request.transportType = .transit

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
            
        }
        
    }
    
    @IBAction func segmentedControllerAction(_ sender: UISegmentedControl) {
        let overlays = mapViewOutlet.overlays
        mapViewOutlet.removeOverlays(overlays)

        var select = sender.selectedSegmentIndex
        uniIndex = select
        if test == 1 && tIncoming.count > 0{
            if select == 0 {
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: tIncomingLat[a], longitude: tIncomingLong[a]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                      request.transportType = .automobile

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
            else if select == 1{
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: tIncomingLat[a], longitude: tIncomingLong[a]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                request.transportType = .walking

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
            else if select == 2{
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: tIncomingLat[a], longitude: tIncomingLong[a]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                request.transportType = .transit

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
        }
        else{
            if select == 0 {
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: incomingLat[b], longitude: incomingLong[b]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                      request.transportType = .automobile

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
            else if select == 1{
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: incomingLat[b], longitude: incomingLong[b]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                request.transportType = .walking

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
            else if select == 2{
                let request = MKDirections.Request()
                      request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3225), addressDictionary: nil))
                      request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: incomingLat[b], longitude: incomingLong[b]), addressDictionary: nil))
                      request.requestsAlternateRoutes = true
                request.transportType = .transit

                      let directions = MKDirections(request: request)

                      directions.calculate { [unowned self] response, error in
                          guard let unwrappedResponse = response else { return }

                          for route in unwrappedResponse.routes {
                              self.mapViewOutlet.addOverlay(route.polyline)
                              self.mapViewOutlet.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                          }
                      }
                
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
