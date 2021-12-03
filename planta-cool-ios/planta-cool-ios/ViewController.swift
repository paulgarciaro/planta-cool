//
//  ViewController.swift
//  planta-cool-ios
//
//  Created by Javier on 02/12/21.
//

import FirebaseDatabase
import UIKit

class ViewController: UIViewController {

    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database.child("P001").observe(.value, with: { snapshot in
            guard let humedadValor = snapshot.value as? [String: Any] else {
                return
            }
            
            let label = UILabel(frame: CGRect(x: 20, y:300, width: self.view.frame.size.width-40, height:50))
        
            var numValor: AnyObject
            
            if humedadValor["humedad"] != nil {
                numValor = humedadValor["humedad"] as AnyObject
                label.text = "\(numValor)%"
            }
            
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont(name: "Helvetica", size: 50)
            label.backgroundColor  = UIColor.white
            self.view.addSubview(label)
            

            
            print("Value: \(humedadValor)")
            
            
            // Label del tanque
            
        })
        
        let etiquetaHumedad = UILabel(frame: CGRect(x:20, y:200, width:view.frame.size.width-40, height:100))
        
        etiquetaHumedad.textAlignment = NSTextAlignment.center
        etiquetaHumedad.text = "Humedad:"
        etiquetaHumedad.font = UIFont(name: "Helvetica", size: 30)
        self.view.addSubview(etiquetaHumedad)
        
        let nombrePlanta = UILabel(frame: CGRect(x:20, y:60, width:view.frame.size.width-40, height:60))
        
        nombrePlanta.text = "Planta Cool 🌱"
        nombrePlanta.font = UIFont(name: "Helvetica-Bold", size: 40)
        self.view.addSubview(nombrePlanta)
        
        
        let button = UIButton(frame: CGRect(x: 20, y:500, width: view.frame.size.width-40, height:50))
        
        button.setTitle("Regar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        view.addSubview(button)
        button.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size:20)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.link.cgColor
    }
    
    @objc private func addNewEntry() {
        let object: [String: Any] = [
            "regar": 1 as NSObject,
            "humedad": "detectando el ",
            "tanque": "detectando..."
        ]
        database.child("P001").setValue(object)
    }


}

