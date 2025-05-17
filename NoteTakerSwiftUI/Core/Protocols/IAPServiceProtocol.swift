//
//  IAPServiceProtocol.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/17/25.
//

import Foundation
import StoreKit

protocol IAPServiceProtocol {
    var purchasedProductsPublisher: Published<Set<String>>.Publisher { get }
    func fetchProducts() async throws -> [Product]
    func purchase(_ product: Product) async throws -> Transaction?
    func isPurchased(_ productIdentifier: String) -> Bool
    func restorePurchases() async throws
}
