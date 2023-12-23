//
//  ArtGalleryScene.swift
//  Gesture
//
//  Created by Tekla on 12/22/23.
//

import SwiftUI

struct ArtGalleryScene: View {
    @State private var offset = CGSize.zero
    @State private var angle: Angle = .degrees(0)
    @State private var isImageVisible = true
    @State private var isBlinking = false
    @GestureState private var zoomFactor: CGFloat = 1.0
    @State private var currentScale: CGFloat = 1.0
    
    var magnification: some Gesture {
        return MagnificationGesture()
            .updating($zoomFactor) { value, scale, transaction in
                scale = value
            }
            .onChanged { value in
                withAnimation {
                    currentScale += value
                }
                
            }
            .onEnded { value in
                
            }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 7) {
                vanGogh1
                vanGogh2
                bosch1
                bosch2
                theKiss
            }
        }
    }
    
    var vanGogh1: some View {
        VStack {
            Image("vangogh1")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation
                        }
                        .onEnded { _ in
                            offset = .zero
                        }
                )
            
            Text("Vincent Van Gogh")
                .onTapGesture {
                    print("You are viewing Vincent Van Gogh's artwork.")
                }
        }
    }
    
    var vanGogh2: some View {
        VStack {
            Image("vangogh2")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .rotationEffect(angle)
                .gesture(
                    RotationGesture()
                        .onChanged{ value in
                            angle = value
                        }
                        .onEnded{_ in
                            withAnimation(.spring()){
                                angle = Angle(degrees: 0)
                            }
                        })
            
            Text("Vincent Van Gogh")
                .onTapGesture {
                    print("You are viewing Vincent Van Gogh's artwork.")
                }
        }
    }
    
    var bosch1: some View {
        VStack {
            Image("bosch1")
                .resizable()
                .scaleEffect(zoomFactor * currentScale)
                .gesture(magnification)
            
            Text("Bosch")
                .onTapGesture {
                    print("You are viewing Bosch's artwork.")
                }
        }
    }
    
    var bosch2: some View {
        VStack {
            if isImageVisible {
                Image("bosch2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .onTapGesture {
                        isImageVisible.toggle()
                    }
            }else {
                Text("View Bosch's Artwork")
                    .onTapGesture {
                        isImageVisible.toggle()
                    }
            }
            
            Text("Bosch")
                .onTapGesture {
                    print("You are viewing Bosch's artwork.")
                }
        }
    }
    
    var theKiss: some View {
        VStack {
            Image("thekiss")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .opacity(isBlinking ? 0.1 : 1.0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isBlinking.toggle()
                    }
                }
            
            Text("Gustav Klimt")
                .onTapGesture {
                    print("You are viewing Gustav Klimt's artwork.")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArtGalleryScene()
    }
}
