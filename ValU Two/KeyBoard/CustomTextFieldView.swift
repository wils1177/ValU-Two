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

    let textField = UITextFieldWithKeyboardObserver(frame: .zero) // just any
    
    let placeHolderText : String
    let alignment : NSTextAlignment
    var textSize : UIFont
    var delegate : KeyboardDelegate?
    var key : String?
    var button1 : UIBarButtonItem?
    var button2 : UIBarButtonItem?
    var button3 : UIBarButtonItem?
    var style : UITextField.BorderStyle?
    
    init(text: Binding<String>, placeHolderText:String, textSize: UIFont, alignment : NSTextAlignment, delegate : KeyboardDelegate?, key : String?, style: UITextField.BorderStyle?=nil){
        self.placeHolderText = placeHolderText
        self.alignment = alignment
        self._text = text
        self.textSize = textSize
        self.delegate = delegate
        self.key = key
        self.style = style
        
    }
    

    func makeUIView(context: UIViewRepresentableContext<CustomInputTextField>) -> UITextField {
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.placeholder = self.placeHolderText
        textField.font = self.textSize
        textField.textAlignment = self.alignment
        textField.adjustsFontForContentSizeCategory = true

        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        if style != nil{
            textField.borderStyle = style!
        }
        
        textField.setupKeyboardObserver()
        
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
                    
                    if let parentScrollView = owner.textField.superview(of: UIScrollView.self) {
                        if !(parentScrollView.currentFirstResponder() is UITextFieldWithKeyboardObserver) {
                            parentScrollView.contentInset = .zero
                        }
                    }
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
 
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if let parentScrollView = textField.superview(of: UIScrollView.self) {
                if !(parentScrollView.currentFirstResponder() is UITextFieldWithKeyboardObserver) {
                    parentScrollView.contentInset = .zero
                }
            }
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.owner.text = textField.text ?? ""
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            return true
        }

    }
}

class UITextFieldWithKeyboardObserver: UITextField {
    
    private var keyboardPublisher: AnyCancellable?
    
    func setupKeyboardObserver() {
        keyboardPublisher = KeybordManager.shared.$keyboardFrame
            .receive(on: DispatchQueue.main)
            .sink { [weak self] keyboardFrame in
                
                if let strongSelf = self, let keyboardFrame = keyboardFrame  {
                    strongSelf.update(with: keyboardFrame)
                }
        }
    }
    
    private func update(with keyboardFrame: CGRect) {
        if let parentScrollView = superview(of: UIScrollView.self), isFirstResponder {
            
            let keyboardFrameInScrollView = parentScrollView.convert(keyboardFrame, from: UIScreen.main.coordinateSpace)
            
            let scrollViewIntersection = parentScrollView.bounds.intersection(keyboardFrameInScrollView).height
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: scrollViewIntersection, right: 0.0)
            
            parentScrollView.contentInset = contentInsets
            parentScrollView.scrollIndicatorInsets = contentInsets
            
            //parentScrollView.scrollRectToVisible(frame, animated: true)
        }
    }
}



extension UIView {

    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview?.superview(of: type)
    }

}

extension UIView {
    func currentFirstResponder() -> UIResponder? {
        if self.isFirstResponder {
            return self
        }
        
        for view in self.subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }
        
        return nil
     }
}

