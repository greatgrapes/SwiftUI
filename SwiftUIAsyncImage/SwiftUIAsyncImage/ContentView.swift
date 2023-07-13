//
//  ContentView.swift
//  SwiftUIAsyncImage
//
//  Created by 박진성 on 2023/07/13.
//

import SwiftUI

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
            .imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

struct ContentView: View {
    private let imageURL: String = "https://credo.academy/credo-academy@3x.png"

    var body: some View {
        // MARK: - 1. BASIC
        // URL은 선택사항 이기 때문에 비동기이미지는 기본 회색 뷰를 표시함. URL 문자열이 유효하지 않으면
        // AsyncImage(url: URL(string: imageURL))
        
        // MARK: - 2. SCALE
        // 사진 크기 조절은 Scale Float값으로 조절
        // AsyncImage(url: URL(string: imageURL), scale: 3.0)
        
        // MARK: - 3. PLACEHOLDER
       
        /*AsyncImage(url: URL(string: imageURL)) { image in
            image.imageModifier()
        } placeholder: {
            Image(systemName: "photo.circle.fill").iconModifier()
        }
        .padding(40)*/
        
        // MARK: - 4. PHASE
        
       /* AsyncImage(url: URL(string: imageURL)) { phase in
            // SUCCESS: The image successfully loaded.
            // FAILURE: The image failed to load with an error.
            // EMPTY: No image is loaded.

            if let image = phase.image {
                image.imageModifier()
            } else if phase.error != nil {
                Image(systemName: "ant.circle.fill").iconModifier()
            } else {
                Image(systemName: "photo.circle.fill").iconModifier()
            }
        }
        .padding(40)*/
        
        // MARK: - 5. Animation
        
        // 위에서 if문으로 구현한 비동기 코드를 Switch문으로 구현
        
        AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image
                    .imageModifier()
//                    .transition(.move(edge: .bottom))
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifier()
            @unknown default:
                ProgressView()
            }
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// iOS 15에서는 인터넷에서 받은 이미지 자산을 로드하고 싶다면 타사 플러그인이 필요없다.

