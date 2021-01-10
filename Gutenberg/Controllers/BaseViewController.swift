//
//  BaseViewController.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import UIKit
import SCLAlertView
import ProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Navigation Bar
    
    func setUpNavigationBar(title: String, isShowBackButton: Bool = false)
    {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        let navigationLeftView = UIView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        let backButton = UIButton(frame: CGRect.init(x: 0, y: 0, width: 35, height: 35))
        backButton.setImage(UIImage(named: "Back"), for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonTapped(_:)), for: .touchUpInside)
        
        let titleLbl = UILabel(frame: CGRect(x: isShowBackButton ? 40 : 0, y: 0, width: self.view.frame.size.width - 40, height: 30))
        titleLbl.text = title
        titleLbl.font = Font.semiBoldLargeFontStyle
        titleLbl.textColor = Color.primaryAppColor
        
        if(isShowBackButton)
        {
            navigationLeftView.addSubview(backButton)
        }
        navigationLeftView.addSubview(titleLbl)

        let leftBarButtonItem = UIBarButtonItem(customView: navigationLeftView)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func backButtonTapped(_ button: UIButton) {
        print("backButonTapped")
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Alert Views
    
    func showNoInternetConnectionAlert()
    {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: Font.semiBoldMediumFontStyle!,
            kTextFont: Font.semiBoldMediumFontStyle!,
            kButtonFont: Font.semiBoldMediumFontStyle!,
            showCloseButton: false,
            dynamicAnimatorActive: true,
            buttonsLayout: .horizontal
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton("Ok") {
            
        }
        
        alertView.showWarning(NSLocalizedString("APP_NAME", comment: ""), subTitle: NSLocalizedString("NO_INTERNET_MESSAGE", comment: ""))
    }
    
    func showWarningAlertViewWithMessage(message:String)
    {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: Font.semiBoldMediumFontStyle!,
            kTextFont: Font.semiBoldMediumFontStyle!,
            kButtonFont: Font.semiBoldMediumFontStyle!,
            showCloseButton: false,
            dynamicAnimatorActive: true,
            buttonsLayout: .horizontal
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton("Ok") {
            
        }
        
        alertView.showWarning("Clan", subTitle: message)
    }
    
    func showSuccessAlertViewWithMessage(message:String, action: @escaping () -> ())
    {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: Font.semiBoldMediumFontStyle!,
            kTextFont: Font.semiBoldMediumFontStyle!,
            kButtonFont: Font.semiBoldMediumFontStyle!,
            showCloseButton: false,
            dynamicAnimatorActive: true,
            buttonsLayout: .horizontal
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton("Ok") {
            action()
        }
        
        alertView.addButton("Cancel") {
            
        }
        
        alertView.showSuccess("Clan", subTitle: message)
    }
    
    func showErrorAlertViewWithMessage(message:String, action: @escaping () -> ())
    {
        let kSubtitle = message
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false,
            dynamicAnimatorActive: true,
            buttonsLayout: .horizontal
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton("Ok") {
            action()
        }
        
        alertView.showError("Clan", subTitle: kSubtitle)
    }
    
    //MARK: Activity Indicator
    
    func showActivityIndicator(message:String){
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.colorBackground = .clear
        ProgressHUD.colorHUD = .clear
        ProgressHUD.fontStatus = .boldSystemFont(ofSize: 24)
        ProgressHUD.animationType = .circleRotateChase

        ProgressHUD.show(message)
    }
    
    func hideActivityIndicator() {
        ProgressHUD.dismiss()
        
    }
}
