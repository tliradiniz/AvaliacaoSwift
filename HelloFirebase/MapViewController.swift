//
//  MapViewController.swift
//  HelloFirebase
//
//  Created by Aluno R17 on 07/06/19.
//  Copyright © 2019 Daniel Valente. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var userLOcation = CLLocation()
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        mapView.showsUserLocation = true
        setupLocationManager()
        addGesture()
        
        //        if let userLocation = locationManager.location?.coordinate {
        //            let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation, 200, 200)
        //            mapView.setRegion(viewRegion, animated: false)
        //        }
        
        // MKUserTrackingMode é um ENUM com cases, basta colocar a config desejada
        mapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
    }
    
    
    
    //Primeira funcao - traz acuracia para localizacao
    
    func setupLocationManager(){
        locationManager.delegate = self
        //Melhor localizacao
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //Pedindo autorizacao do usuario
        locationManager.requestWhenInUseAuthorization()
        
        // Ciclo de atualizacao de posicao do usuario
        locationManager.startUpdatingLocation()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Criando um gesture
    func addGesture(){
        // O LongPressGestureRecognizer é uma subclasse da UIGestureRecognizer - Utilizado para pefar gestos longos na tela, e ainda podemos definir o tempo desse gesto.  Exemplo de uma propriedade computada!
        let longPress = UILongPressGestureRecognizer(target:self,action:#selector(addAnnotationToMap(gesture:)))
        longPress.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPress)
        
    }
    
    
    // Segunda funcao - localizacao do usuario
    func  locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            
            if let location = locations.last{
                userLOcation = location
                print("A localizacao do usuario é \(userLOcation.coordinate)")
                
            }
            
        }
    }
    
    // Terceira funcao - para criacao de uma estrutura do Annotation do mapa
    
    @objc func addAnnotationToMap(gesture:UIGestureRecognizer){
        //UIGestureRecognizer é uma classe que faz reconhecer os gestos da tela
        
        let touchPoint = gesture.location(in: mapView)
        let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        // A classe MKPointAnnotation define um ponto específico na tela , e ainda conseguimos adicionar um título para este ponto
        
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "Mapas"
        // Convertendo uma instancia para uma String
        newAnnotation.subtitle = String(describing:"Latitude \(newCoordinate.latitude) e Longitude éc\(newCoordinate.longitude))")
        // Criando nova Annoatation
        mapView.addAnnotation(newAnnotation)
        
    }
    
}

