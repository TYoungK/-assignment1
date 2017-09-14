//
//  ViewController.swift
//  MapTest2
//
//  Created by D7703_29 on 2017. 9. 14..
//  Copyright © 2017년 D7703_29. All rights reserved.
//


import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var myMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomToRegion()
        
        
        let a = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.166197, longitude: 129.072594), title: "DIT", subtitle: "동의과학대학교")
        let b = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.168444, longitude: 129.057832), title: "부산시민공원", subtitle: "부산시민들의 휴식처")
        let c = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.165016,  longitude: 129.064629), title: "송상현광장", subtitle: "양정 명물")
        // Annotation(Pin) 꼽기
        
        myMapView.addAnnotations([a,b,c])
        myMapView.delegate = self
    }
    
    // MKMapViewDelegate method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myPin"
        
        // an already allocated annotation view
        var annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            //annotationView?.pinTintColor = UIColor.green
            annotationView?.animatesDrop = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        if annotation.title! == "DIT" {
            leftIconView.image = UIImage(named:"bright-7.png" )
            annotationView?.pinTintColor = UIColor.green
        }
        if annotation.title! == "부산시민공원" {
            leftIconView.image = UIImage(named:"1.jpeg" )
            annotationView?.pinTintColor = UIColor.blue
        }
        if annotation.title! == "송상현광장" {
            leftIconView.image = UIImage(named:"zenos.jpeg" )
            annotationView?.pinTintColor = UIColor.black
        }
        annotationView?.leftCalloutAccessoryView = leftIconView

        return annotationView
        
    }
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 35.166197, longitude: 129.072594)
        let region = MKCoordinateRegionMakeWithDistance(location, 2000.0, 4000)
        myMapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let viewAnno = view.annotation //as! ViewPoint
        let placeName = viewAnno?.title
        let placeInfo = viewAnno?.subtitle
        
        let ac = UIAlertController(title: placeName!, message: placeInfo!, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


