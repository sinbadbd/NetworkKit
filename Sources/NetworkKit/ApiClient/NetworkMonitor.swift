//
//  NetworkMonitor.swift
//  MovieZoo
//
//  Created by Imran on 7/9/23.
//

import Foundation
import Network
import Combine
import SwiftUI

//@available(iOS 13.0, *)
class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    
    var isMonitoring = false
    @Published var isConnected = true
    private init() {}
    
    func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                // Network is available
                print("Network is available")
            } else {
                // Network is unavailable
                print("Network is unavailable")
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        isMonitoring = true
    }
    
    func stopMonitoring() {
        guard isMonitoring else { return }
        monitor.cancel()
        isMonitoring = false
    }
}
