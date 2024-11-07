//
//  RootView.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//
import SharedModels
import SwiftUI
import ComposableArchitecture
import HomeFeature
import TabFeature

public struct RootView: View {
    @Bindable var store: StoreOf<RootReducer>
    
    public init(store: StoreOf<RootReducer>) {
        self.store = store
        UITabBar.appearance().isHidden = true
    }
    public var body: some View {
        GeometryReader { geometry in
            let _ = geometry.size.height
            let screenWidth = geometry.size.width
            
            var tabWidth: CGFloat {
                return screenWidth / CGFloat(TabModel.allCases.count)
            }
            let iconH: CGFloat = screenWidth * (200/1000)
            WithPerceptionTracking  {
                TabView(selection: $store.tabBar.selectedTab.sending(\.tabBar.didSelectTab)) {
                    
                    Text(TabModel.discover.rawValue)
                        .padding(.bottom, iconH)
                        .ignoresSafeArea(.container, edges: .bottom)
                        .tag(TabModel.discover)
                    
                    HomeView(store: store.scope(state: \.home, action: \.home))
                        .padding(.bottom, iconH)
                        .ignoresSafeArea(.container, edges: .bottom)
                        .tag(TabModel.notes)
                    
                    Text(TabModel.notes.rawValue)
                        .padding(.bottom, iconH)
                        .ignoresSafeArea(.container, edges: .bottom)
                        .tag(TabModel.matches)
                    
                    Text(TabModel.profile.rawValue)
                        .padding(.bottom, iconH)
                        .ignoresSafeArea(.container, edges: .bottom)
                        .tag(TabModel.profile)
                    
                }
                .overlay(alignment: .bottom) {
                    let store = store.scope(state: \.tabBar, action: \.tabBar)
                    AisleTabView(store: store, proxy: geometry)
                        .compositingGroup()
                        .shadow(color: Color.gray.opacity(0.6), radius: 5)
                }
                .ignoresSafeArea(.container, edges: .bottom)
            }
        }
        .dynamicTypeSize(...(.large))

    }
    
}

