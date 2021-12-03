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
            
            let label = UILabel(frame: CGRect(x: 20, y:200, width: self.view.frame.size.width-40, height:50))
        
            var numValor: AnyObject
            
            if humedadValor["humedad"] != nil {
                numValor = humedadValor["humedad"] as AnyObject
                label.text = "\(numValor)"
            }
            
            label.textAlignment = NSTextAlignment.center
            
            label.backgroundColor  = UIColor.white
            self.view.addSubview(label)
            

            
            print("Value: \(humedadValor)")
        })
        
        
        let button = UIButton(frame: CGRect(x: 20, y:500, width: view.frame.size.width-40, height:50))
        
        button.setTitle("Add Entry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        view.addSubview(button)
        button.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
    }
    
    @objc private func addNewEntry() {
        let object: [String: Any] = [
            "name": "Javier" as NSObject,
            "Planta": "yes"
        ]
        database.child("something").setValue(object)
    }


}

