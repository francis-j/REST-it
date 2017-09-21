//
//  MethodViewController.swift
//  rest-it
//
//  Created by Francis Jones on 14/09/2017.
//  Copyright © 2017 fj. All rights reserved.
//

import UIKit
import Alamofire

protocol MethodDelegate {
    func didSelectMethod(method:HTTPMethod);
}

class MethodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var methodTable: UITableView!
    var methods:[String]!;
    var delegate:MethodDelegate!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setMethodValues();

        self.methodTable.delegate = self;
        self.methodTable.dataSource = self;
    }
    
    private func setMethodValues() {
        self.methods = ["GET", "POST", "PUT", "DELETE"];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.methods.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.methodTable.dequeueReusableCell(withIdentifier: "methodCell", for: indexPath) as? MethodViewCell else {
            fatalError("Dequeued cell not MethodViewCell.");
        }
        
        cell.label.text = self.methods[indexPath.row];
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.didSelectMethod(method: self.getHttpMethod(method: self.methods[indexPath.row]));
        self.dismiss(animated: true, completion: nil);
    }
    
    private func getHttpMethod(method:String) -> HTTPMethod {
        switch method {
        case "GET":
            return HTTPMethod.get;
        case "POST":
            return HTTPMethod.post;
        case "PUT":
            return HTTPMethod.put;
        case "DELETE":
            return HTTPMethod.delete;
        default:
            return HTTPMethod.get;
        }
    }

}
