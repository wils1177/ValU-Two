//
//  ExpensesCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/30/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ExpensesCard: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                VStack{
                    Text("You've Spent").font(.subheadline).foregroundColor(.white).bold()
                    Text("$500").font(.system(size: 50)).foregroundColor(.white).bold().padding()
                    
                }
                Spacer()
            }.padding(.bottom)
            
            
        }.background(Color(.black)).cornerRadius(20).shadow(radius: 20)
    }
}

struct ExpensesCard_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesCard()
    }
}
