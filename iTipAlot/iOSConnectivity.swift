//
//  iOSConnectivity.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/7/25.
//

import Foundation
import WatchConnectivity

class iOSConnectivity: NSObject, WCSessionDelegate {
    
    static let shared = iOSConnectivity()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        Task { @MainActor in
            if activationState == .activated {
                if session.isWatchAppInstalled {
                    print("✅ Watch app is installed")
                }
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}
