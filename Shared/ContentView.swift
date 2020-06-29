//
//  ContentView.swift
//  Shared
//
//  Created by Jordan Singer on 6/28/20.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Set<Int> = [0]
    
    var body: some View {
        NavigationView {
            List(selection: self.$selection) {
                MessageCell(name: "Jordan Singer", message: "Hello, world").tag(0)
                MessageCell(name: "Craig Federighi", message: "About lil apps...")
                MessageCell(name: "Leo Gill", message: "iMessage")
                MessageCell(name: "June Cha", message: "iMessage")
                MessageCell(name: "Britney Cooper", message: "iMessage")
                MessageCell(name: "Andrew Kumar", message: "iMessage")
                MessageCell(name: "Andrew Kumar", message: "iMessage")
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Messages")
            
            Text("No message selected")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Messages")
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                }
            }
            
            ToolbarItem(placement: .status) {
                Button(action: {}) {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}

struct MessageCell: View {
    @State var name: String
    @State var message: String
    
    var body: some View {
        NavigationLink(destination: MessageView()) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 40))
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .center) {
                        Text(name)
                            .font(.headline)
                        Spacer()
                        Text("9:41 AM")
                            .font(.callout)
                    }
                    
                    Text(message)
                        .font(.callout)
                        .lineLimit(1)
                }
            }
            .padding(.vertical, 12)
        }
    }
}

struct MessageView: View {
    @State var message = ""
    @State var messages = [
        "Here’s to the crazy ones",
        "the misfits, the rebels, the troublemakers",
        "the round pegs in the square holes…",
        "the ones who see things differently — they’re not fond of rules…",
        "You can quote them, disagree with them, glorify or vilify them",
        "but the only thing you can’t do is ignore them because they change things…",
        "they push the human race forward",
        "and while some may see them as the crazy ones",
        "we see genius",
        "because the ones who are crazy enough to think that they can change the world",
        "are the ones who do."
    ]
    
    #if os(macOS)
    var backgroundColor = Color(NSColor.controlBackgroundColor)
    #else
    var backgroundColor = Color(UIColor.systemBackground)
    #endif
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(0..<messages.count, id: \.self) { i in
                        ChatBubbleView(message: messages[i], index: i)
                    }
                }
                .padding()
            }
            
            TextField("iMessage", text: $message, onCommit: { self.sendMessage() })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .background(backgroundColor)
        .navigationTitle("Message")
//        .navigationBarTitleDisplayMode(.inline)
    }
    
    func sendMessage() {
        self.messages.append(self.message)
        self.message = ""
    }
}

struct ChatBubbleView: View {
    @State var message: String
    @State var index: Int
    
    #if os(macOS)
    var outgoingBubbleColor = NSColor.systemBlue
    var incomingBubbleColor = NSColor.windowBackgroundColor
    var incomingLabelColor = NSColor.labelColor
    #else
    var outgoingBubbleColor = UIColor.systemBlue
    var incomingBubbleColor = UIColor.secondarySystemBackground
    var incomingLabelColor = UIColor.label
    #endif
    
    var body: some View {
        HStack {
            if index % 2 != 0 {
                Spacer()
            }
            
            Text(message)
                .foregroundColor(Color(index % 2 != 0 ? .white : incomingLabelColor))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(index % 2 != 0 ? outgoingBubbleColor : incomingBubbleColor))
                .cornerRadius(16)
            
            if index % 2 == 0 {
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
