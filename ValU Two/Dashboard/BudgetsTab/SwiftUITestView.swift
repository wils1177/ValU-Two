//
//  SwiftUITestView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI


struct BudgetCardView: View {
    
    let budget : Budget
    var viewModel : BudgetsViewModel
    
    var title: String
    var spent : String
    var remaining: String
    var percentage: Float
    var available : String
    
    var savingsGoal : String
    
    init(budget : Budget, viewModel: BudgetsViewModel){
        self.budget = budget
        self.title = CommonUtils.getMonthFromDate(date: self.budget.startDate!)
        self.spent = "$" + String(Int(self.budget.getAmountSpent()))
        self.remaining = "$" + String(Int(self.budget.getAmountAvailable() - self.budget.spent))
        self.percentage = self.budget.spent / self.budget.getAmountAvailable()
        self.available = "$" + String(Int(self.budget.getAmountAvailable()))
        self.savingsGoal = "$" + String(Int(self.budget.amount * self.budget.savingsPercent))
        self.viewModel = viewModel
    }
    
    

    

    
    var editButton: some View{
        
        Button(action: {
            self.viewModel.editBudget(budget: self.budget)
            
        }){
        ZStack{
            
            Text("Edit").font(.headline).foregroundColor(Color(.gray))
        }
        }.buttonStyle(PlainButtonStyle())
        
    }
    
    
    var textColor = Color(.black)
    
    var cirleWithPercent : some View {
        ZStack{
            VStack(alignment: .center){
                Text("Remaining").foregroundColor(Color(.systemGreen)).bold()
                Text("$2,434").font(.title).bold()
            }
            Circle().fill(Color.clear).frame(width:140, height: 140)
                .overlay(Circle()
                        .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: CGFloat(1.0))
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(8.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                        
                )
                .overlay(Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: 0.66)
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(8.0), lineCap: .round, lineJoin: .round))
                    .fill(LinearGradient(gradient:  Gradient(colors: [.green, .yellow]), startPoint: .topTrailing, endPoint: .center))
                    
            )
            
        }
    }
    
    var circleNoPercent : some View{
        ZStack{
            Circle().fill(Color.clear).frame(width:100, height: 100)
                .overlay(Circle()
                        .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: CGFloat(1.0))
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(13.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                        
                )
                .overlay(Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: 0.66)
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(13.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(.systemPurple))
                    
            )
            
        }
    }
    
    var ratioCircle : some View{
        ZStack{
            Circle().fill(Color.clear).frame(width:100, height: 100)
                .overlay(Circle()
                        .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: CGFloat(1.0))
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(14.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(.systemOrange))
                        
                )
                .overlay(Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: 0.66)
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(14.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(.systemPurple))
                    
            )
            
        }
    }
    
    var bigCircle : some View{
        ZStack{
            VStack(alignment: .center){
                Text("Remaining").foregroundColor(Color(.systemPurple)).bold()
                Text("$2,434").font(.title).bold()
            }
            Circle().fill(Color.clear).frame(width:155, height: 155)
                .overlay(Circle()
                        .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: CGFloat(1.0))
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(8.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                        
                )
                .overlay(Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: 0.66)
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(8.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(.systemPurple))
                    
            )
            
        }
    }
    
    var bigCirleWithLegend : some View{
        HStack{
            
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Circle().frame(width: 7, height: 7).foregroundColor(Color(.systemPurple))
                            Text("Spent").foregroundColor(Color(.darkGray)).bold()
                        }.padding(.bottom ,5)
                        
                        Text("$5,000").font(.title).bold()
                    }
                    Spacer()
                }.padding(.horizontal).padding(.top)
                
                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Circle().frame(width: 7, height: 7).foregroundColor(Color(.lightGray))
                            Text("Remaining").foregroundColor(Color(.darkGray)).bold()
                        }.padding(.bottom ,5)
                        
                        Text("$2,434").font(.title).bold()
                    }
                    Spacer()
                }.padding(.horizontal).padding(.bottom)
                Spacer()
            }
            VStack{
                ZStack{
                    bigCircle
                }.padding(.trailing)
            }
            
            
        }.padding(.horizontal)
    }
    
    var legend : some View {
        VStack(alignment: .center, spacing: 0.0){
            HStack{
                Circle().frame(width: 5, height: 5).foregroundColor(Color(.systemPurple))
                Text("Income").foregroundColor(Color(.systemPurple)).font(.callout)
            }
            HStack{
                Circle().frame(width: 5, height: 5).foregroundColor(Color(.systemOrange))
                Text("Expenses").foregroundColor(Color(.systemOrange)).font(.callout)
            }
        }
    }
    
    var smallerCircle : some View {
        ZStack{
            //Text(self.icon).font(.headline)
            Circle().fill(Color.clear).frame(width:70, height: 70)
                .overlay(Circle()
                        .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: CGFloat(1.0))
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(7.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                        
                )
                .overlay(Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: CGFloat(0.0), to: 0.66)
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(7.0), lineCap: .round, lineJoin: .round))
                    .fill(Color(.systemOrange))
                    
            )
            
        }
    }
    
    var option: some View{
        
        HStack{
            
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            Circle().frame(width: 7, height: 7).foregroundColor(Color(.systemPurple))
                            Text("Income").foregroundColor(Color(.lightGray)).bold()
                        }
                        
                        Text("$5,000").font(.title)
                    }
                    Spacer()
                }.padding(.horizontal).padding(.top)
                
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            Circle().frame(width: 7, height: 7).foregroundColor(Color(.systemOrange))
                            Text("Expenses").foregroundColor(Color(.lightGray)).bold()
                        }
                        
                        Text("$2,434").font(.title)
                    }
                    Spacer()
                }.padding(.horizontal).padding(.bottom)
                Spacer()
            }
            VStack{
                ZStack{
                    circleNoPercent
                    smallerCircle
                }.padding(.trailing)
            }
            
            
        }.padding(.horizontal)
        
        
    }
    
    var option4 : some View{
        HStack{
            
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Circle().frame(width: 7, height: 7).foregroundColor(Color(.lightGray))
                            Text("Budget").foregroundColor(Color(.darkGray)).bold()
                        }.padding(.bottom ,5)
                        
                        Text("$5,000").font(.title).bold()
                    }
                    Spacer()
                }.padding(.horizontal)
                
                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Circle().frame(width: 7, height: 7).foregroundColor(Color(.lightGray))
                            Text("Spent").foregroundColor(Color(.darkGray)).bold()
                        }.padding(.bottom ,5)
                        
                        Text("$2,434").font(.title).bold()
                    }
                    Spacer()
                }.padding(.horizontal).padding(.bottom)
                Spacer()
            }
            VStack{
                ZStack{
                    cirleWithPercent.offset( y: -15)
                }.padding(.trailing)
            }
            
            
        }.padding(.horizontal)
}
    
    var option3 : some View{
        HStack{
            
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        Text("Budget").foregroundColor(Color(.lightGray)).bold()
                        Text("$5,000").font(.title).bold()
                    }
                    Spacer()
                }.padding()
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Remaining").foregroundColor(Color(.lightGray)).bold()
                        Text("$2,434").font(.title).bold()
                    }
                    Spacer()
                }.padding()
                Spacer()
            }
            VStack{
                ZStack{
                    cirleWithPercent
                }.padding(.trailing)
            }
            
            
        }.padding(.horizontal)
    }
    
    var option2 : some View{
        VStack(){
            HStack{
                Spacer()
                Text("April").font(.title).bold().padding(.horizontal).foregroundColor(textColor)
                Spacer()
                //EditBudgetButton(budget: self.viewModel.currentBudget!, coordinator: self.viewModel.coordinator!).padding(.trailing, 10)
            }.padding(.bottom, 20).padding(.horizontal).padding(.top)
            HStack{
                Text("Budget").font(.system(size: 17)).foregroundColor(textColor).bold()
                Spacer()
                Text("$3,234").font(.system(size: 23)).foregroundColor(textColor).bold()
            }.padding(.horizontal, 10).padding(.horizontal)
            Divider().background(Color(.white)).padding(.horizontal)
            HStack{
                Text("Spent").font(.system(size: 17)).foregroundColor(textColor).bold()
                Spacer()
                Text("$2,254").font(.system(size: 23)).foregroundColor(textColor).bold()
            }.padding(.vertical, 5).padding(.horizontal, 10).padding(.horizontal)
            Divider().background(Color(.white)).padding(.horizontal)
            HStack{
                Text("Remaining").font(.system(size: 17)).foregroundColor(textColor).bold()
                Spacer()
                Text("$1,454").font(.system(size: 23)).foregroundColor(textColor).bold()
            }.padding(.top, 10).padding(.horizontal, 10).padding(.bottom, 10).padding(.horizontal)
            
            HStack(spacing: 0.0){
                Spacer()
                HStack{
                    Image(systemName: "checkmark.circle.fill").resizable()
                        .frame(width: 25.0, height: 25.0).foregroundColor(Color(.white)).padding(.trailing)
                    VStack(alignment: .leading){
                        Text("Savings goal is on track.").foregroundColor(Color(.white))
                        
                        Text("$500").foregroundColor(Color(.lightText))
                    }
                }.padding(.vertical, 8).padding(.top, 4)
                
                
                Spacer()
            }.background(Color(.systemOrange))
            
        }
    }
    
    
    var coolCircle : some View{
        VStack(spacing: 0){
            HStack{
                VStack(alignment: .leading){
                    Text("April").font(.title).bold()
                    Text("12 days left").font(.headline).foregroundColor(Color(.lightGray)).bold()
                }
                
                Spacer()
                //Text("Edit").bold().foregroundColor(Color(.white)).padding(8).background(Color(.systemPurple)).cornerRadius(20).shadow(radius: 2).padding(.trailing)
            }.padding()

            HStack{
                VStack{
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            //Circle().frame(width: 7, height: 7).foregroundColor(Color(.lightGray))
                            Text("Budget").font(.system(size: 15)).foregroundColor(Color(.darkGray)).bold()
                        }.padding(.bottom ,5)
                        
                        Text("$5,000").font(.system(size: 25)).fontWeight(.semibold).bold()
                    }
                    Spacer()
                }.padding(.horizontal)
                
                VStack{
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            //Circle().frame(width: 7, height: 7).foregroundColor(Color(.lightGray))
                            Text("Spent").font(.system(size: 15)).foregroundColor(Color(.darkGray)).bold()
                        }.padding(.bottom ,5)
                        
                        Text("$2,434").font(.system(size: 25)).fontWeight(.semibold).bold()
                    }
                    Spacer()
                }.padding(.horizontal).padding(.bottom)
            }
            
            Spacer()
            bigCircle.padding(.bottom).padding(.bottom)
            Spacer()
            
            
            
            
            
            Divider().padding(.horizontal)
            
            HStack{
                
                Image(systemName: "checkmark.circle.fill").resizable().frame(width: 25.0, height: 25.0).foregroundColor(Color(.systemPurple)).padding(.leading).padding(.leading)
                
                VStack(alignment: .leading){
                    Text("Savings goal is on track.").font(.callout).foregroundColor(Color(.black)).bold()
                    
                    Text("$500").font(.footnote).foregroundColor(Color(.lightGray)).bold()
                }.padding(.horizontal)
                   Spacer()
                
            }.padding(.vertical)
            
     
        }
    }
    
    var detailedView : some View{
        VStack(spacing: 0){
        HStack{
            VStack(alignment: .leading){
                Text("April").font(.title).bold()
                Text("12 days left").font(.headline).foregroundColor(Color(.lightGray)).bold()
            }
            
            Spacer()
            //Text("Edit").bold().foregroundColor(Color(.white)).padding(8).background(Color(.systemPurple)).cornerRadius(20).shadow(radius: 2).padding(.trailing)
        }.padding(.horizontal).padding(.top)
        option4
        Spacer()
        
        
        Divider().padding(.horizontal)
        
        HStack{
            
            Image(systemName: "checkmark.circle.fill").resizable().frame(width: 25.0, height: 25.0).foregroundColor(Color(.systemGreen)).padding(.leading).padding(.leading)
            
            VStack(alignment: .leading){
                Text("Savings goal is on track.").font(.callout).foregroundColor(Color(.black)).bold()
                
                Text("$500").font(.footnote).foregroundColor(Color(.lightGray)).bold()
            }.padding(.horizontal)
               Spacer()
            
        }.padding(.vertical)
        }
    }
    
    
    var body: some View {
        
        coolCircle
            
            
            /*
            Divider().padding().padding(.top)
            
            HStack{
                
                
                
                    Spacer()
                    VStack{
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Circle().frame(width: 7, height: 7).foregroundColor(Color(.systemGreen))
                                Text("Income").foregroundColor(Color(.darkGray)).bold()
                            }.padding(.bottom ,5)
                            
                            Text("$5,000").font(.system(size: 22)).bold()
                        }
                        Spacer()
                    }.padding(.horizontal)
                    
                    VStack{
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Circle().frame(width: 7, height: 7).foregroundColor(Color(.systemRed))
                                Text("Expenses").foregroundColor(Color(.darkGray)).bold()
                            }.padding(.bottom ,5)
                            
                            Text("$2,434").font(.system(size: 22)).bold()
                        }
                        Spacer()
                    }.padding(.horizontal)
                    Spacer()

                }.padding(.bottom)
            
                */
        
        
    }
}

/*
#if DEBUG
struct BudgetCardView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCardView(viewData: BudgetCardViewData(remaining: "500", spent: "500", percentage: CGFloat(0.5)))
    }
}
#endif
*/


