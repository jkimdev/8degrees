//
//  ContentView.swift
//  8degrees
//
//  Created by 김재민 on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(showsIndicators: false) {
                    ZStack(alignment: .bottomLeading){
                        Image("turtlerock")
                            .resizable()
                            .frame(height: UIScreen.main.bounds.height/1.8)
                        
                        VStack{
                            HStack{
                                Image(systemName: "mappin.and.ellipse")
                                VStack(alignment: .leading){
                                    Text("Turtlerock")
                                    Text("Irvine, CA 92603, USA")
                                        .font(.caption2)
                                }
                            }.padding()
                                .foregroundColor(.white)
                        }
                    }
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "car").renderingMode(.template)
                                .imageScale(.large)
                                .foregroundColor(.black)
                            Text("\(22)km")
                                .font(.caption)
                                .foregroundColor(.black)
                        })
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "sun.min").renderingMode(.template)
                                .imageScale(.large).foregroundColor(.black)
                            Text("\(17)°C")
                                .font(.caption)
                                .foregroundColor(.black)
                        })
                    }.padding([.horizontal, .vertical])
                    ScrollView(showsIndicators: false){
                        VStack {
                            Text("Turtle Rock is a neighborhood in the south part of Irvine, Orange County, California, near Concordia University, Irvine and the University of California, Irvine. It is bounded to the north by University Drive and Mason Regional Park, to the east by the Strawberry Farms Golf Club and Ridgeline Drive, to the south by Shady Canyon Drive, and to the west by Culver Drive. Turtle Rock is one of the five \"villages\" originally forming Irvine; its 1967 founding is commemorated by a sculpture of a turtle in Turtle Rock Community Park, at the corner of Turtle Rock and Sunnyhill Drives. A two-lane internal loop road, Turtle Rock Drive, encircles the village and carries traffic between housing developments and the city's main streets.")
                                .font(.body)
                                .lineSpacing(10)
                            Spacer()
                            
                        }
                    }.padding([.horizontal])
                    
                }
                
            }.edgesIgnoringSafeArea(.top)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "hand.thumbsup.fill").renderingMode(.template).foregroundColor(.teal)
                            Text("213")
                                .font(.caption)
                                .foregroundColor(.black)
                        })
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
