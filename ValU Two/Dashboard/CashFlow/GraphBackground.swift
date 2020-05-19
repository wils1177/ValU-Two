//
//  GraphBackground.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct GraphBackground: View {
    
    var graphSpacing : CGFloat
    
    var viewModel : CashFlowViewModel
    var viewData : [TransactionDateCache]
    
    var maxHeight : CGFloat
    
    init(viewModel: CashFlowViewModel, viewData: [TransactionDateCache], scale: Int, maxHeight: CGFloat){
        self.viewModel = viewModel
        self.viewData = viewData
        self.maxHeight = maxHeight
        self.graphSpacing = maxHeight / 4
        self.scale = scale
    }
    
    var scales = [50, 100, 200, 500, 1000, 5000]
    
    var scale = 50
    
    
    
    var body: some View {
        VStack(spacing: 0.0){
            ZStack(){
                Divider()
                HStack(spacing: 0){
                    Spacer()
                    Text(String(scale * 4)).foregroundColor(Color(.lightGray)).background(Color(.white))
                }
            }
            Spacer()
            ZStack{
                Divider()
                HStack(spacing: 0){
                    Spacer()
                    Text(String(scale * 3)).foregroundColor(Color(.lightGray)).background(Color(.white))
                }
            }
            Spacer()
            ZStack{
                Divider()
                HStack(spacing: 0){
                    Spacer()
                    Text(String(scale * 2)).foregroundColor(Color(.lightGray)).background(Color(.white))
                }
            }
            Spacer()
            ZStack{
                Divider()
                HStack(spacing: 0){
                    Spacer()
                    Text(String(scale * 1)).foregroundColor(Color(.lightGray)).background(Color(.white))
                }
            }
            Spacer()
            ZStack{
                Divider()
                HStack(spacing: 0){
                    Spacer()
                    Text(String(scale * 0)).foregroundColor(Color(.lightGray)).background(Color(.white))
                }
            }

        }.frame(height: self.maxHeight)
    }
}


