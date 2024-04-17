import SwiftUI

struct AddList: View {
    @State private var listName: String = ""
    @ObservedObject var listItems: ListItems
    @Binding var isAddListActive: Bool
    @Binding var lists: [String] // Update to use binding
    
    var body: some View {
        VStack {
            Text("Add List")
                .font(.system(size: 40))
                .fontWeight(.bold)
            
            VStack(alignment: .leading) {
                Text("List Name")
                    .font(.title)
                TextField("Enter List Name", text: $listName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
                Button(action: {
                    if !listName.isEmpty {
                        // Add the listName directly to lists
                        lists.append(listName)
                        isAddListActive = false
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
