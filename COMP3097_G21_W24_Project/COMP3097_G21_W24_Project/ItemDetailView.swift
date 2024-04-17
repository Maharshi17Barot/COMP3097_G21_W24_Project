import SwiftUI

struct ItemDetailView: View {
    var itemName: String
    var itemPrice: Float
    var taxPercentage: Float
    
    var totalWithTax: Float {
        let taxAmount = itemPrice * (taxPercentage / 100)
        return itemPrice + taxAmount
    }
    
    var body: some View {
        VStack {
            Text("Item Details")
                .font(.title)
                .padding()
            Divider()
            Text("Item Name: \(itemName)")
                .padding()
            Text("Item Price: $\(itemPrice, specifier: "%.2f")")
                .padding()
            Text("Tax Percentage: \(taxPercentage)%")
                .padding()
            Text("Total with Tax: $\(totalWithTax, specifier: "%.2f")")
                .padding()
            Spacer()
        }
    }
}
