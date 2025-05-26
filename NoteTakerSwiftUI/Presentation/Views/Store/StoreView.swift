//
//  StoreView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/18/25.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    @StateObject private var viewModel: StoreViewModel
    
    init(factory: ViewModelFactory) {
        _viewModel = StateObject(wrappedValue: factory.makeStoreViewModel())
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(StringConstants.Store.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        Text(StringConstants.Store.subtitle2)
                            .font(.subheadline)
                            .foregroundStyle(Color.secondary)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(PremiumFeature.allCases, id: \.self) { feature in
                                VStack {
                                    Image(systemName: feature.iconName)
                                        .font(.system(size: 24))
                                        .foregroundStyle(Color.blue)
                                    
                                    Text(feature.title)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(height: 80)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    } else if viewModel.productViewModels.isEmpty {
                        Text(StringConstants.Store.noProducts)
                            .foregroundStyle(Color.secondary)
                            .padding()
                    } else {
                        ForEach(viewModel.productViewModels, id: \.product.id) { productVM in
                            ProductCardView(productVM: productVM, isPurchased: viewModel.isPurchased(productVM.product.id), purchaseAction: {
                                Task {
                                    await viewModel.purchase(productVM.product)
                                }
                            })
                        }
                        .padding(.horizontal)
                    }
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(Color.red)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                
                Button(StringConstants.Store.restorePurchases) {
                    Task {
                        await viewModel.restorePurchases()
                    }
                }
                .padding()
                .foregroundStyle(Color.blue)
            }
        }
        .navigationTitle(StringConstants.Store.navigationTitle)
        .refreshable {
            await viewModel.loadProducts()
        }
    }
}

#Preview {
    StoreView(factory: ViewModelFactory(iapService: IAPService()))
}
