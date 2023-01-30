//
//  ParentCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ParentCategoryCard: View {
    
    var color : Color
    var colorSeconday : Color
    var colorTertiary : Color
    var icon : String
    
    var spent: Float
    var limit : Float
    var name: String
    var percentageSpent: Double
    var section: BudgetSection
    
    var coordinator: BudgetsTabCoordinator?
    
    @Binding var budgetFilter: BudgetFilter
    
    init(budgetSection: BudgetSection, coordiantor: BudgetsTabCoordinator? = nil, budgetFilter: Binding<BudgetFilter>){
        self.coordinator = coordiantor
        self.section = budgetSection
        self._budgetFilter = budgetFilter
        self.color = colorMap[Int(budgetSection.colorCode)]
        self.colorSeconday = Color(colorMapUIKit[Int(budgetSection.colorCode)].lighter()!)
        self.colorTertiary = Color(colorMapUIKit[Int(budgetSection.colorCode)].darker()!)
        self.icon = budgetSection.icon!
        self.spent = Float(budgetSection.getSpent())
        self.limit = Float(budgetSection.getLimit())
        self.name = budgetSection.name!
        
        self.percentageSpent = budgetSection.getPercentageSpent()
        
    }
    
    
    func getDisplayPercent() -> Double{
        if self.percentageSpent < 0.1{
            return 0.1
        }
        else{
            return self.percentageSpent
        }
    }
    
    
    func getLeft() -> String{
        var left = 0.0
        if self.budgetFilter == .Spending{
            left = self.section.getFreeLimit() - self.section.getFreeSpent()
        }
        else{
            left = self.section.getRecurringLimit() - self.section.getRecurringSpent()
        }
        
        
        var leftOver = " Left"
        if left < 0 {
            leftOver = " Over"
        }
        
        return CommonUtils.makeMoneyString(number: Int(left)) + leftOver
    }
    


    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 17),
        //GridItem(.flexible(), spacing: 17)
        //GridItem(.flexible(), spacing: 17)
        ]
    
    
    @State var isLarge = true
    
    var header: some View{
        HStack{
            
          
            Button(action: {
                // What to perform
                coordinator?.showIndvidualBudget(budgetSection: self.section)
                
            }) {
                // How the button looks like
                //Image(systemName: "chevron.right").font(.system(size: 19)).foregroundColor(globalAppTheme.themeColorPrimary).padding(.trailing, 3).rotationEffect(.degrees(isLarge ? 90 : 0)).padding(.trailing, 3)
                //BudgetSectionIconLarge(color: self.color, icon: self.section.icon ?? "book", size: 30).padding(.trailing, 2)
                Image(systemName: self.section.icon!).font(.system(size: 21, design: .rounded)).fontWeight(.bold).foregroundColor(color.opacity(0.4))
                Text(self.name).font(.system(size: 21, design: .rounded)).foregroundColor(color).fontWeight(.bold).lineLimit(1).listRowSeparator(.hidden)
                
                
                Spacer()
               
                NavigationBarTextButton(text: getLeft(), color: color)
                //Image(systemName: "chevron.right").font(.system(size: 14, design: .rounded)).fontWeight(.bold).foregroundColor(Color(.lightGray))
                
            }.buttonStyle(PlainButtonStyle())
 
        }.padding(.bottom, 5)
    }
    
    var circleNuts: some View{
        
        
        
        
        
        VStack(spacing: 0){
            
            header.padding(.bottom, 15)
            
            ForEach(self.section.getBudgetCategories(), id: \.self) { category in
                
                VStack(spacing: 0.0){
                    if self.budgetFilter == .Spending && !category.recurring{
                        Button(action: {
                            // What to perform
                            self.coordinator?.showCategoryDetail(category: category)
                        }) {
                            // How the button looks like
                            CategorySlideView(category: category, color: self.color).padding(.vertical, 4)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    else if self.budgetFilter == .Recurring && category.recurring{
                        Button(action: {
                            // What to perform
                            self.coordinator?.showCategoryDetail(category: category)
                        }) {
                            // How the button looks like
                            CategorySlideView(category: category, color: self.color).padding(.vertical, 4)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                
            }
            
            
            
            
        }
        
    }

    
    var body: some View {
        
        
        
        self.circleNuts
    }
}

struct OtherSectionView: View{
    
    var model : OtherBudgetViewModel
    
    var percent: Double
    
    var left: Double
    
    var color = globalAppTheme.otherColor
    
    init(service: BudgetTransactionsService){
        let viewModel = OtherBudgetViewModel(budgetTransactionsService: service)
        self.model = viewModel
        self.percent = model.getPercentageSpent()
        self.left = model.getleft()
        
    }
    
    func getPercentage() -> Double{
        
        
        if percent > 1.0{
            return 1.0
        }
        if percent < 0.1 && percent != 0{
            return 0.1
        }
        
        else{
            return percent
        }
    }
    
    func getDisplayPercent() -> String{
        let intPercent = Int(percent * 100)
        return String(intPercent) + "%"
    }
    
    func getLeft() -> String{
        return CommonUtils.makeMoneyString(number: Int(left))
    }
    
    func getText() -> String{
        if left >= 0{
            return "Left"
        }
        else{
            return "Over"
        }
    }
    
    
    
    var body: some View{
        
        Section{
            VStack{
                
                
                
                    VStack{
                        
                        HStack{
                            
          
                            Text("Other").font(.system(size: 23, design: .rounded)).fontWeight(.bold).listRowSeparator(.hidden)

                            Spacer()
                            
                            
                        }.padding(.horizontal, 12).padding(.top, 8)
                        
                        Rectangle().frame(height: 3).foregroundColor(Color(.lightGray).opacity(0.2))
                        
                        HStack{
                            
                            ZStack(alignment: .center){
                                //RoundedRectangle(cornerRadius: 8).frame(width: 40, height: 40, alignment: .center).foregroundColor(color.opacity(0.7))
                                Text("👄").font(.system(size: 27, design: .rounded))
                            }
                            
                            GeometryReader{ g in
                                
                                    ZStack(alignment: .leading){
                                        
                                        
                                        
                                        RoundedRectangle(cornerRadius: 10).frame(width: g.size.width, height: 40).foregroundColor(self.color.opacity(0.08))
                                        
                                        
                                        RoundedRectangle(cornerRadius: 10).frame(width: g.size.width * getPercentage(), height: 40).foregroundColor(self.color.opacity(0.4))
                                        
                                        
                                        HStack{
                                            
                                            
                                            VStack(alignment: .leading){
                                                Text("Other").font(.system(size:15, design: .rounded)).bold().foregroundColor(Color(.black)).lineLimit(1)
                                                Text(getDisplayPercent()).font(.system(size:12, design: .rounded)).bold().foregroundColor(color).lineLimit(1)
                                            }
                                            
                                            Spacer()
                                            
                                            
                                            
                                        }.padding(.horizontal, 10)
                                        
                                    }
                                
                                
                                
                                
                            }
                            
                            
                            
                            Spacer()
                            
                            
                            VStack(alignment: .trailing){
                                    //Text(category.spendingCategory!.name!).font(.system(size:15, design: .rounded)).bold().lineLimit(1)
                                    Text(getLeft()).font(.system(size:15, design: .rounded)).bold().lineLimit(1)
                                    Text(getText()).font(.system(size:13, design: .rounded)).foregroundColor(Color(.lightGray)).bold().lineLimit(1)
                                    Spacer()
                                }.frame(width: 50)
                            
                            
                            
                        }.frame(height: 50).padding(12)
                        
                        
                        }.padding(.top, 8).background(Color(.tertiarySystemBackground)).cornerRadius(25)
                    
                }
                
                
            }

        
    }
}


struct CategorySlideView: View{
    
    var category : BudgetCategory
    var color : Color
    var percent : Double = 0.0
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    init(category: BudgetCategory, color: Color){
        self.category = category
        self.color = color
        self.percent = createPercent(cat: category)
        
    }
    
    func createPercent(cat: BudgetCategory) -> Double {
        
        if cat.limit == left{
            return 0.0
        }
        
        if cat.limit != 0{
            return cat.getAmountSpent() / cat.limit
        }
        else{
            return 1.0
        }
    }
    
    var left : Double{
        return category.limit - category.getAmountSpent()
    }
    
    func getPercentage() -> Double{
        
        
        
        if percent > 1.0{
            return 1.0
        }
        if percent < 0.1 && percent != 0{
            return 0.1
        }
        
        else{
            return percent
        }
    }
    
    func getDisplayPercent() -> String{
        let intPercent = Int(percent * 100)
        return String(intPercent) + "%"
    }
    
    func getLeft() -> String{
        return CommonUtils.makeMoneyString(number: Int(left))
    }
    
    func getText() -> String{
        if left >= 0{
            return "Left"
        }
        else{
            return "Over"
        }
    }
    
    
    var body : some View{
        
        HStack{
            
            ZStack(alignment: .center){
                //RoundedRectangle(cornerRadius: 8).frame(width: 40, height: 40, alignment: .center).foregroundColor(color.opacity(0.7))
                Text(category.spendingCategory?.icon ?? "").font(.system(size: 27, design: .rounded))
            }
            
            GeometryReader{ g in
                
                    ZStack(alignment: .leading){
                        
                        
                        
                        RoundedRectangle(cornerRadius: 10).frame(width: g.size.width, height: 40).foregroundColor(Color(.lightGray).opacity(0.11))
                        
                        
                        RoundedRectangle(cornerRadius: 10).frame(width: g.size.width * getPercentage(), height: 40).foregroundColor(self.color.opacity(0.4))
                        
                        
                        HStack{
                            
                            
                            VStack(alignment: .leading){
                                Text(category.spendingCategory!.name!).font(.system(size:15, design: .rounded)).bold().foregroundColor((colorScheme == .dark) ? Color.white : Color.black).lineLimit(1)
                                Text(getDisplayPercent()).font(.system(size:12, design: .rounded)).bold().foregroundColor(color).lineLimit(1)
                            }
                            
                            Spacer()
                            
                            
                            
                        }.padding(.horizontal, 10)
                        
                    }
                
                
                
                
            }
            
            
            
            Spacer()
            
            
            VStack(alignment: .trailing){
                    //Text(category.spendingCategory!.name!).font(.system(size:15, design: .rounded)).bold().lineLimit(1)
                    Text(getLeft()).font(.system(size:15, design: .rounded)).bold().lineLimit(1)
                    Text(getText()).font(.system(size:13, design: .rounded)).foregroundColor(Color(.lightGray)).bold().lineLimit(1)
                    Spacer()
                }.frame(width: 50)
            
            
            
        }.frame(height: 50)
        
        
    }
    
}


