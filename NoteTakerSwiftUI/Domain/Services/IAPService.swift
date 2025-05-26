//
//  IAPService.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/17/25.
//

import Foundation
import StoreKit

enum StoreError: Error {
    case failedVerification
}

class IAPService: IAPServiceProtocol {
    @Published private var purchasedProducts: Set<String> = []
    var purchasedProductsPublisher: Published<Set<String>>.Publisher { $purchasedProducts }
    
    private var productIDs: Set<String>
    private var updateListenerTask: Task<Void, Error>?
    
    init(productIDs: Set<String> = [StringConstants.ProductIDs.premiumMonthly]) {
        self.productIDs = productIDs
        self.updateListenerTask = listenForTransactions()
        
        Task {
            await updatePurchaseProducts()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
        print(StringConstants.App.dealloc.formatted(with: String(describing: Self.self)))
    }
    
    func fetchProducts() async throws -> [Product] {
        try await Product.products(for: productIDs)
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verificationResult):
            let transaction = try checkVerified(verificationResult)
            await updatePurchaseProducts()
            await transaction.finish()
            return transaction
            
        case .userCancelled:
            return nil
        case .pending:
            return nil
        @unknown default:
            return nil
        }
    }
    
    func isPurchased(_ productIdentifier: String) -> Bool {
        return purchasedProducts.contains(productIdentifier)
    }
    
    func restorePurchases() async throws {
        try await AppStore.sync()
        await updatePurchaseProducts()
    }
    
    
}

// MARK: - Private methods
extension IAPService {
    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await self.updatePurchaseProducts()
                    await transaction.finish()
                } catch {
                    print(StringConstants.Error.transactionFailed.formatted(with: error.localizedDescription))
                }
            }
        }
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    private func updatePurchaseProducts() async {
        var purchaseIdentifiers = Set<String>()
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                purchaseIdentifiers.insert(transaction.productID)
            } catch {
                print(StringConstants.Error.verficationFailed.formatted(with: error.localizedDescription))
            }
        }
        
        await MainActor.run {
            self.purchasedProducts = purchaseIdentifiers
        }
    }
}
