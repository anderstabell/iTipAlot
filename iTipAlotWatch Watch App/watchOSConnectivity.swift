//
//  watchOSConnectivity.swift
//  iTipAlotWatch Watch App
//
//  Created by Anders Tabell on 1/7/25.
//

import Foundation
import WatchConnectivity

class watchOSConnectivity: NSObject, WCSessionDelegate {
    
    static let shared = watchOSConnectivity()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
}
