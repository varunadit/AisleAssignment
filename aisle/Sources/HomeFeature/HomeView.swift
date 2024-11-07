//
//  HomeView.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//
import SwiftUI
import AisleUI
import ComposableArchitecture
import SharedModels

public struct HomeView: View {
    let store: StoreOf<HomeReducer>
    
    public init(store: StoreOf<HomeReducer>) {
        self.store = store
    }
    public var body: some View {
        GeometryReader { geometry in
            WithPerceptionTracking {
                ScrollView {
                    
                    WithPerceptionTracking {
                        VStack(spacing: 0) {
                            
                            Text("Notes")
                                .font(.title)
                                .foregroundStyle(.black)
                                .fontWeight(.bold)
                            Text("Personal messages to you")
                                .font(.subheadline)
                                .foregroundStyle(.black)
                                .fontWeight(.medium)
                            
                            VStack {
                                ZStack {
                                    AsyncImage(url: URL(string: store.profileList?.invites.profiles.first?.photos.first?.photo ?? "")) { image in
                                        image
                                            .image?.resizable()
                                            .scaledToFill()
                                            .clipped()
                                    }
                                    
                                    LinearGradient(colors: [.clear, .clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                                    
                                    VStack(alignment: .leading) {
                                        Text((store.profileList?.invites.profiles.first?.generalInformation.firstName ?? " ") + " \(store.profileList?.invites.profiles.first?.generalInformation.age ?? 0)")
                                            .foregroundStyle(.white)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                }
                            }
                            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.width)
                            .roundedCorners(radius: 12)
                            .padding(.top)
                            
                            HStack(alignment: .center) {
                                VStack(alignment: .leading) {
                                    Text("Interested In You")
                                        .font(.title3)
                                        .foregroundStyle(.black)
                                        .fontWeight(.bold)
                                    Text("Premium members can\nview all their likes at once ")
                                        .font(.body)
                                        .foregroundStyle(.gray)
                                        .fontWeight(.bold)
                                }
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Text("Upgrade")
                                        .font(.body)
                                        .foregroundStyle(.black)
                                        .fontWeight(.bold)
                                }
                                .buttonStyle(.aislePrimary)
                            }
                            .padding([.horizontal, .top])
                            
                            HStack(alignment: .center) {
                                ForEach(store.profileList?.likes.profiles[0..<2] ?? [], id: \.avatar) { profile in
                                    VStack {
                                        ZStack {
                                            AsyncImage(url: URL(string: profile.avatar)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipped()
                                            } placeholder: {
                                                Color.gray
                                            }
                                            .blur(radius: 15, opaque: true)
                                            
                                            LinearGradient(colors: [.clear, .clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                                            
                                            VStack {
                                                Text(profile.firstName)
                                                    .foregroundStyle(.white)
                                                    .fontWeight(.heavy)
                                                    
                                            }
                                            .padding()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                        }
                                    }
                                    .roundedCorners(radius: 8)

                                }
                                
                            }
                        }
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height)
                        
                    }
                    
                }
                .padding(.horizontal)
            }
            .onAppear {
                store.send(.fetch)
            }
        }
        .background(Color.aisleDemoBackground)
    }
}

#Preview {
    HomeView(
        store:
        Store(initialState: {
            HomeReducer.State(profileList: ProfileListResponse.mockProfileListResponse)
        }(), reducer: {
            HomeReducer()
        })
    )
}


struct InterestedInYouSection: View {
    @State private var blurRadius: CGFloat = 0
    @State private var opacity: Double = 1

    var body: some View {
        GeometryReader { geometry in
            ZStack {

                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)

                
            }
            .foregroundStyle(.black)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.3)) {
                    blurRadius = 20
                    opacity = 0.5
                }
            }
            .onDisappear {
                withAnimation(.easeInOut(duration: 0.3)) {
                    blurRadius = 0
                    opacity = 1
                }
            }
        }
    }
}
