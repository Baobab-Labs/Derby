//
//  HomePage.swift
//  Derby
//
//  Created by Ben Hollar on 12/29/19.
//  Copyright © 2019 Ben Hollar. All rights reserved.
//

import SwiftUI

// MARK: - View
struct HomePage: View {
    
    @EnvironmentObject var appdata: AppData
    @State var showMenu: Bool = false
    
    var body: some View {
        
        /// Activates a horizontal drag gesture to open / close the side menu
        let dragGesture = DragGesture().onEnded({
            if $0.translation.width < -100 {
                withAnimation {
                    self.showMenu = false
                }
            } else if $0.translation.width > 100 {
                withAnimation {
                    self.showMenu = true
                }
            }
        })
        
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                MainView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width * 0.8 : 0)
                    .disabled(self.showMenu)
                if self.showMenu {
                    SideMenu(collections: self.$appdata.collections)
                        .frame(width: geometry.size.width * 0.8)
                        .transition(.move(edge: .leading))
                }
            }
            .gesture(dragGesture)
        }
    }
}

private struct MainView: View {
    @State var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            TextField("Search", text: $searchText)
                .padding()
                .background(Color("DerbyPurpleLight"))
                .foregroundColor(.white)
                .cornerRadius(30)
            // TODO: Need to hack around placeholder text color?
            Spacer()
            Image("chef")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
            Text("CHEF")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            HStack(spacing: 30) {
                Button("BUTTON", action: self.dummyButton).buttonStyle(RoundedButonStyle())
                Spacer()
                Button("BUTTON", action: self.dummyButton).buttonStyle(RoundedButonStyle())
            }
            .padding(.horizontal)
        }
        .padding()
        .background(
            Color("DerbyPurple")
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    private func dummyButton() {
        // TODO
    }
}

// MARK: - Helpers

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(AppData())
    }
}
