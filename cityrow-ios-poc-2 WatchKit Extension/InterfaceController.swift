//
//  InterfaceController.swift
//  cityrow-ios-poc-2 WatchKit Extension
//
//  Created by Stiven Suarez on 19/01/22.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    //@IBOutlet weak var firstLabel: WKInterfaceLabel!
    
    @IBOutlet weak var message: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        let session = WCSession.default
        // Configure interface objects here.
        if WCSession.isSupported() {
            print("Is supported")
            session.delegate = self
            session.activate()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Watch WC Session Activated")
        case .notActivated:
            print("Watch WC Session not activated")
        case .inactive:
            print("Watch WC Session inactive")
        default:
            print("Ups")
        }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("Message \(message)")
        let text = message["message"] as! String
        self.message.setText(text)
    }
    
    func sendMessage() {
        let message:[String:Any] = ["hello":"Value"]
        print("Message sent \(message)")
        WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
    }
    
    @IBAction func testClick() {
        print("Send test was clicked")
        //self.message.setText("Clicked")
        sendMessage()
        
    }
    
}

