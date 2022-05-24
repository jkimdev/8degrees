//
//  ContentView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                Text("8Degrees").italic().font(.system(size: 28))
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
