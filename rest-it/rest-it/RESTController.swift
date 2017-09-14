//
//  RESTController.swift
//  rest-it
//
//  Created by Francis Jones on 12/09/2017.
//  Copyright © 2017 fj. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RESTController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var SelectMethodButton: UIButton!
    @IBOutlet weak var AddHeadersButton: UIButton!
    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet weak var UrlText: UITextField!
    @IBOutlet weak var BodyText: UITextView!
    @IBOutlet weak var HeadersTable: UITableView!
    
    private var httpMethod:HTTPMethod!;
    private var httpHeaders:HTTPHeaders!;
    private var httpResult:String?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard");
        view.addGestureRecognizer(tap);
        self.UrlText.delegate = self;

        self.httpMethod = HTTPMethod.get;
        self.httpHeaders = HTTPHeaders.init();
    }
    
    func dismissKeyboard() {
        view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SelectMethodButtonClicked(_ sender: UIButton) {
        
    }
    
    private func SetMethod(method:String) {
        switch (method) {
            case "GET":
                self.httpMethod = HTTPMethod.get;
                break;
            case "POST":
                self.httpMethod = HTTPMethod.post;
                break;
            case "PUT":
                self.httpMethod = HTTPMethod.put;
                break;
            case "DELETE":
                self.httpMethod = HTTPMethod.delete;
                break;
            default:
                break;
        }
    }
    
    @IBAction func AddHeadersButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func SendButtonClicked(_ sender: UIButton) {
        let url = self.UrlText.text!;
        //headers
        let body = self.BodyText.text!;
        
        let params = JSON.parse(body).dictionaryValue;
        
        Alamofire.request(url,
            method: self.httpMethod,
            parameters: params,
            headers: self.httpHeaders)
            .responseString { (response) -> Void in
                
                if (response.result.value != nil)
                {
                    let json = JSON(response.result.value!);
                    
                    let alert = UIAlertController(title: "Result", message: json.stringValue, preferredStyle: .actionSheet);
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil);
                }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
