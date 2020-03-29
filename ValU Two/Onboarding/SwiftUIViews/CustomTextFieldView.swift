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

    let textField = UITextField(frame: .zero) // just any
    
    let placeHolderText : String
    let alignment : NSTextAlignment
    var textSize : UIFont
    var delegate : KeyboardDelegate?
    var key : String?
    var button1 : UIBarButtonItem?
    var button2 : UIBarButtonItem?
    var button3 : UIBarButtonItem?
    
    init(text: Binding<String>, placeHolderText:String, textSize: UIFont, alignment : NSTextAlignment, delegate : KeyboardDelegate?, key : String?){
        self.placeHolderText = placeHolderText
        self.alignment = alignment
        self._text = text
        self.textSize = textSize
        self.delegate = delegate
        self.key = key
    }
    

    func makeUIView(context: UIViewRepresentableContext<CustomInputTextField>) -> UITextField {
        textField.keyboardType = UIKeyboardType.numberPad
        textField.placeholder = self.placeHolderText
        textField.font = self.textSize
        textField.textAlignment = self.alignment
        textField.adjustsFontForContentSizeCategory = true

        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomInputTextField>) {
        self.textField.text = text
    }
    
    
    func makeToolBar(coordinator : KeyCoordinator){
        
        
        let toolbar = UIToolbar()
        toolbar.setItems([
            // just moves the Done item to the right
            UIBarButtonItem(
              title: self.text
              , style: UIBarButtonItem.Style.plain
                , target: coordinator
                , action: nil
            ),
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
    }

    func makeCoordinator() -> CustomInputTextField.KeyCoordinator {
        let coordinator = KeyCoordinator(self)
        makeToolBar(coordinator: coordinator)
        return coordinator
    }

    typealias UIViewType = UITextField

    class KeyCoordinator: NSObject {
        let owner: CustomInputTextField
        private var subscriber: AnyCancellable
        private var otherSubscriber : AnyCancellable

        init(_ owner: CustomInputTextField) {
            self.owner = owner
            
            
            otherSubscriber = NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification, object: owner.textField)
                .sink(receiveValue: {_ in
                    
                    // Trigger the action to the delegate
                    owner.delegate?.onKeyBoardSet(text: owner.text, key: owner.key)
                })
            
            subscriber = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: owner.textField)
            .sink(receiveValue: { _ in
                owner.$text.wrappedValue = owner.textField.text ?? ""
           })
           
        }
        
        

        @objc fileprivate func onSet() {
            owner.textField.resignFirstResponder()
            
            // Trigger the action to the delegate
            owner.delegate?.onKeyBoardSet(text: owner.text, key: owner.key)
        }

    }
}


