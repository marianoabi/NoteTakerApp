//
//  ProductCardView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/18/25.
//

import SwiftUI
import StoreKit

struct ProductCardView: View {
    let productVM: IAPProductViewModel
    let isPurchased: Bool
    let purchaseAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.Store.title)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(StringConstants.Store.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(productVM.displayName)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(productVM.localizedDescription)
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                }
                
                Spacer()
                
                if isPurchased {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.green)
                        .font(.title)
                }
            }
            
            VStack(alignment: .leading) {
                ForEach(productVM.features, id: \.self) { feature in
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color.green)
                            .font(.footnote)
                        
                        Text(feature.title)
                            .font(.callout)
                    }
                }
            }
            .padding(.leading, 4)
            
            Button(action: purchaseAction) {
                HStack {
                    Text(isPurchased ? StringConstants.Store.purchased : StringConstants.Store.buyFormat.formatted(with: productVM.formattedPrice))
                        .fontWeight(.semibold)
                    
                    if !isPurchased {
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(isPurchased ? Color.secondary.opacity(0.2) : Color.blue)
                .foregroundStyle(isPurchased ? Color.secondary : Color.white)
                .cornerRadius(12)
            }
            .disabled(isPurchased)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: 16, style: .circular)
        )
    }
}

// Preview provider
struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        // To create a preview we need to mock the Product type
        // This is challenging since Product is a concrete type from StoreKit
        // Here's a placeholder approach
        Group {
            Text("ProductCardView Preview not available directly")
                .padding()
            
            // Alternative: Show a mock design
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Premium Features")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("Unlock all premium features")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                        Text("Advanced Colors")
                    }
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                        Text("Export Options")
                    }
                }
                
                Button(action: {}) {
                    Text("Buy for $0.99")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .padding()
        }
    }
}
