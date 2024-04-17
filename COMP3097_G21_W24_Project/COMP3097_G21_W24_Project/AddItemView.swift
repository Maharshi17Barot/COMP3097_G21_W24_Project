import SwiftUI

struct AddItemView: View {
    @State private var itemName: String = ""
    @State private var itemPrice: String = ""
    @ObservedObject var itemList: ItemList
    @Binding var isAddItemActive: Bool
    
    var body: some View {
        VStack {
            Text("Add Item")
                .font(.system(size: 40))
                .fontWeight(.bold)
            
            VStack(alignment: .leading) {
                Text("Item Name")
                    .font(.title)
                TextField("Enter Item Name", text: $itemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Item Price")
                    .font(.title)
                TextField("Enter Item Price", text: $itemPrice)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
                Button(action: {
                    if !itemName.isEmpty && !itemPrice.isEmpty {
                        if let price = Float(itemPrice) {
                            let newItem = ListItem(name: itemName, quantity: 1, price: price) // Create a ListItem object
                            itemList.items.append(newItem)
                            isAddItemActive = false
                        } else {
                            // Show an alert or handle invalid input
                        }
                    }
                }) {
                    Text("Save")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding()
        }
    }
}
