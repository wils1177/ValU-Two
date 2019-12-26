//
//  CustomTextFieldView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//


import SwiftUI
import UIKit
import Combine

struct CustomInputTextField : UIViewRepresentable {

    @Binding var text: String

    let textField = UITextField(frame: CGRect(x:0, y:0, width: 100, height: 32)) // just any
    

    func makeUIView(context: UIViewRepresentableContext<CustomInputTextField>) -> UITextField {
        textField.keyboardType = UIKeyboardType.numberPad
        textField.placeholder = "Your Income"
        textField.font = .systemFont(ofSize: 28)
        textField.textAlignment = .center
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomInputTextField>) {
        self.textField.text = text
    }

    func makeCoordinator() -> CustomInputTextField.Coordinator {
        let coordinator = Coordinator(self)

        // configure a toolbar with a Done button
        let toolbar = UIToolbar()
        toolbar.setItems([
            // just moves the Done item to the right
            UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace
                , target: nil
                , action: nil
            )
            , UIBarButtonItem(
                title: "Done"
                , style: UIBarButtonItem.Style.done
                , target: coordinator
                , action: #selector(coordinator.onSet)
            )
            ]
            , animated: true
        )
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()

        textField.inputAccessoryView = toolbar
        return coordinator
    }

    typealias UIViewType = UITextField

    class Coordinator: NSObject {
        let owner: CustomInputTextField
        private var subscriber: AnyCancellable

        init(_ owner: CustomInputTextField) {
            self.owner = owner
            subscriber = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: owner.textField)
                .sink(receiveValue: { _ in
                    owner.$text.wrappedValue = owner.textField.text ?? ""
                })
        }

        @objc fileprivate func onSet() {
            owner.textField.resignFirstResponder()
        }

    }
}

struct DemoCustomKeyboardInput : View {

    @State var email:String = ""

    var body: some View {
        VStack{
            CustomInputTextField(text: $email).frame(width: 40, height: 30)
                .padding(.horizontal)
                .frame(maxHeight: 32).keyboardType(.numberPad)
            Divider()
            Text("Entered text: \(email)")
        }
    }
}

struct DemoCustomKeyboardInput_Previews: PreviewProvider {
    static var previews: some View {
        DemoCustomKeyboardInput()
    }
}
