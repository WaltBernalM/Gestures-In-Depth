//
//  ContentView.swift
//  Gestures-In-Depth
//
//  Created by Walter Bernal Montero on 23/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var offsetValue = CGSize.zero
    @State private var amount = Angle.zero
    @State private var finalAmount = Angle.zero
    @State private var amount1: Double = 0
    @State private var finalAmount1: Double = 1
    
    var body: some View {
        VStack{
            Text("one tap")
                .onTapGesture {
                    print("text tapped once!")
                }
                .padding()
                .foregroundColor(Color.orange)
                .font(.largeTitle)
            
            Text("two taps")
                .onTapGesture(count: 2) {
                    print("text tapped twice!")
                }
                .padding()
                .foregroundColor(Color.blue)
                .font(.largeTitle)
            
            Text("long tap")
                .onLongPressGesture(minimumDuration: 4, maximumDistance: 15, perform: {
                    print("Long tap")
                })
                .padding()
                .foregroundColor(Color.red)
                .font(.largeTitle)
            
            Image("LittleLemon_Logo")
                .offset(offsetValue)
                .gesture(
                    DragGesture()
                        .onChanged{ gesture in
                            offsetValue = gesture.translation
                        }
                )
            
            Image("LittleLemon_Logo")
                .rotationEffect(amount + finalAmount)
                .gesture(
                    RotationGesture()
                        .onChanged { value in
                            amount = value
                        }
                        .onEnded { value in
                            finalAmount += amount
                            amount = .zero
                        }
                )
            
            Image("LittleLemon_Logo")
                .scaleEffect(finalAmount1 + amount1)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            amount1 = value - 1
                        }
                        .onEnded { value in
                            finalAmount1 += amount1
                            amount1 = 0
                        }
                )
            
            let longPress = LongPressGesture()
                .onEnded{_ in
                    print("Long press then can drag")
                }
            let drag = DragGesture()
                .onChanged{_ in
                    print("Dragging...")
                }
            let sequence = longPress.sequenced(before: drag)
            Image("LittleLemon_Logo")
                .gesture(sequence)
        }
    }
}

#Preview {
    ContentView()
}
