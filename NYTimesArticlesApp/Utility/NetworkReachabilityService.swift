//
//  NetworkReachabilityService.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import Foundation
import Network
protocol NetworkReachabilityServiceProtocol {
    var isReachable: Bool { get }
    func startMonitoring(completion: @escaping (Bool) -> Void)
    func stopMonitoring()
}

class NetworkReachabilityService:NetworkReachabilityServiceProtocol {
    private let monitor = NWPathMonitor()
    private var isMonitoring = false
    private(set) var isReachable: Bool = true
    
    func startMonitoring(completion: @escaping (Bool) -> Void) {
        guard !isMonitoring else { return }
        
        monitor.pathUpdateHandler = { [weak self] path in
            let isReachable = path.status == .satisfied
            self?.isReachable = isReachable
            
            DispatchQueue.main.async {
                completion(isReachable)
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
