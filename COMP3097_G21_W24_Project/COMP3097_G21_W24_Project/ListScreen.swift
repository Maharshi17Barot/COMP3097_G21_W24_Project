import SwiftUI

struct ListItem {
    var name: String
    var quantity: Int
    var price: Float
    var total: Float {
        price * Float(quantity)
    }
}

class ListItems: ObservableObject {
    @Published var items: [ListItem]
    
    init(items: [ListItem] = []) {
        self.items = items
    }
}

class ItemList: ObservableObject {
    @Published var items: [ListItem]
    
    init(items: [ListItem] = []) {
        self.items = items
    }
}

struct TotalView: View {
    var total: Float
    
    var body: some View {
        VStack {
            Text("Total")
                .font(.title) // Keep the title font size
                .padding()
            Divider()
            Text("Total Price: $\(total, specifier: "%.2f")")
                .font(.headline) // Increase font size for total price
                .padding()
            Spacer()
        }
    }
}

struct ListDetailScreen: View {
    var listName: String
    @EnvironmentObject var itemList: ItemList
    @State private var isAddItemActive = false
    @State private var isItemDetailActive = false
    @State private var selectedItemIndex: Int?
    @State private var isTotalActive = false
    @State private var total: Float = 0 // Add state for total price
    @State private var tax: Float = 0 // Add state for tax amount
    
    var body: some View {
        VStack {
            Text("Detail view for \(listName)")
                .font(.title) // Increase font size for title
            List {
                ForEach(itemList.items.indices, id: \.self) { index in
                    Text("\(itemList.items[index].name) - \(itemList.items[index].price)")
                        .onTapGesture {
                            self.selectedItemIndex = index
                            self.isItemDetailActive = true
                        }
                }
            }
            Spacer() // Add spacer to push total to the bottom
            HStack {
                Spacer()
                Text("Tax: $\(tax, specifier: "%.2f")") // Display tax amount
                    .font(.headline)
                Spacer()
            }
            HStack {
                Spacer()
                Text("Total: $\(total, specifier: "%.2f")")
                    .font(.headline) // Increase font size for total
                Spacer()
            }
            .padding()
            Button(action: {
                // Calculate total price
                total = itemList.items.reduce(0) { $0 + $1.total }
                tax = total * 0.13 // Calculate tax amount
                total *= 1.13 // Add tax to total
                isTotalActive = false // Activate the total sheet
            }) {
                Text("Total")
            }
            .sheet(isPresented: $isTotalActive) {
                TotalView(total: total) // Pass the calculated total to TotalView
            }
        }
        .navigationBarItems(trailing:
            Button(action: {
                self.isAddItemActive = true
            }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $isAddItemActive) {
                AddItemView(itemList: itemList, isAddItemActive: $isAddItemActive)
            }
        )
        .sheet(isPresented: $isItemDetailActive) {
            if let selectedItemIndex = selectedItemIndex {
                let selectedItem = itemList.items[selectedItemIndex]
                let itemName = selectedItem.name
                let itemPrice = selectedItem.price
                let taxPercentage: Float = 13
                ItemDetailView(itemName: itemName, itemPrice: itemPrice, taxPercentage: taxPercentage)
            }
        }
    }
}

struct ListScreen: View {
    @State private var isAddListActive = false
    @StateObject var listItems = ListItems()
    @State private var lists: [String] = []
    @StateObject var itemList = ItemList()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(lists, id: \.self) { list in
                        NavigationLink(destination: ListDetailScreen(listName: list).environmentObject(listItems).environmentObject(itemList)) {
                            HStack {
                                Text(list)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("List", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.isAddListActive = true
                }) {
                    Text("Add")
                }
            )
            .sheet(isPresented: $isAddListActive) {
                AddList(listItems: listItems, isAddListActive: $isAddListActive, lists: $lists)
            }
        }
    }
}
