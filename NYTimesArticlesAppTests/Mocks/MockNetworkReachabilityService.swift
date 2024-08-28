//
//  MockNetworkReachabilityService.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 28/08/2024.
//
@testable import NYTimesArticlesApp
import Foundation
class MockNetworkReachabilityService: NetworkReachabilityServiceProtocol {
    var isReachable: Bool = true
    
    func startMonitoring() {}
    func stopMonitoring() {}
}
