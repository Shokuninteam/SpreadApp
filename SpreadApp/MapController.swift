import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {

    @IBOutlet var map: MKMapView!
    
    var note : Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if note != nil {
            displayMap(note!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayMap(note : Note){
        var locations = [CLLocationCoordinate2D]()
        var latMin = 200.0
        var longMin = 200.0
        var latMax = 0.0
        var longMax = 0.0
        for spread in note.spread! {
            var lat : Double = spread.loc!.coordinates![1]
            var long = spread.loc!.coordinates![0]
            let location = CLLocationCoordinate2D(latitude: lat,longitude: long)
            locations.append(location)
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(location)
            map.addAnnotation(annotation)
            if lat < latMin{
                latMin = lat
            }
            if long < longMin{
                longMin = long
            }
            if lat > latMax{
                latMax = lat
            }
            if long > longMax{
                longMax = long
            }
        }
        let span = MKCoordinateSpanMake(latMax - latMin, longMax - longMin)
        let center = CLLocationCoordinate2D(latitude: (latMin + latMax) / 2,longitude: (longMin + longMax) / 2)
        let region = MKCoordinateRegionMake(center, span)
        map.setRegion(region, animated: true)
    }

}
