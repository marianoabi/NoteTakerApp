//
//  StoreViewModel.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/18/25.
//

import Foundation
import Combine
import StoreKit

class StoreViewModel: ObservableObject {
    @Published var productViewModels: [IAPProductViewModel] = []
    @Published var purchasedProductIDs = Set<String>()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let iapService: IAPServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var rawProducts: [Product] = []
    
    init(iapService: IAPServiceProtocol) {
        self.iapService = iapService
        
        iapService.purchasedProductsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] purchasedIDs in
                guard let self = self else { return }
                self.purchasedProductIDs = purchasedIDs
            }
            .store(in: &cancellables)
        
        Task {
            await loadProducts()
        }
    }
    
    func loadProducts() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let fetchedProducts = try await iapService.fetchProducts()
            self.rawProducts = fetchedProducts
            await MainActor.run {
                self.updateProductViewModels()
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func purchase(_ product: Product) async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            _ = try await iapService.purchase(product)
            await MainActor.run {
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func restorePurchases() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            try await iapService.restorePurchases()
            await MainActor.run {
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func isPurchased(_ productID: String) -> Bool {
        return iapService.isPurchased(productID)
    }
    
    func isAnyPremiumProductPurchased() -> Bool {
        for product in rawProducts {
            if isPurchased(product.id) {
                return true
            }
        }
        return false
    }
}

// MARK: - Private Methods
extension StoreViewModel {
    private func updateProductViewModels() {
        productViewModels = rawProducts.map { product in
            IAPProductViewModel(product: product, isPurchased: purchasedProductIDs.contains(product.id))
        }
    }
}
