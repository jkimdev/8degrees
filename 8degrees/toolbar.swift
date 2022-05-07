//
//  toolbar.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/06.
//

import SwiftUI

struct toolbar: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("turtlerock")
                }
            }
        }
    }
}

struct toolbar_Previews: PreviewProvider {
    static var previews: some View {
        toolbar()
    }
}
