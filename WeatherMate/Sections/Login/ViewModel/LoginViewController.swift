//
//  LoginViewController.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import UIKit
import FirebaseAuth

enum LoginViewControllerType {
    case login
    case signup
    case autoLogin
    
    var labelText: String {
        switch self {
        case .login:
            return AppStrings.Login.loginButtonText
        case .signup:
            return AppStrings.Login.signUpButtonText
        default:
            return ""
        }
    }
}

class LoginViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginSignUpButton: UIButton!
    @IBOutlet weak var mainImageViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var goToSignupButton: UIButton!
    
    var screenType: LoginViewControllerType = .autoLogin
    
    // MARK: ViewModel
    var viewModel: LoginViewModelProtocol! {
        didSet {
            viewModel.vcTypeDidChange = { [unowned self] vcType in
                DispatchQueue.main.async {
                    self.setupUI(as: vcType)
                }
            }
            
            viewModel.didReturnError = { error in
                DispatchQueue.main.async {
                    LoaderManager.instance.hide()
                    BannerManager.instance.showBanner(title: AppStrings.Banner.Title.error, message: error)
                }
            }
            
            viewModel.loginSignupCompleted = {  [unowned self] in
                DispatchQueue.main.async {
                    LoaderManager.instance.hide()
                    self.moveToHomeScreen()
                }
            }
        }
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: Private Methods
extension LoginViewController {
    
    private func setupUI(as screenType: LoginViewControllerType = .autoLogin, shouldAnimate: Bool = true) {
        
        self.screenType = screenType
        loginSignUpButton.setTitle(screenType.labelText, for: .normal)

        switch screenType {
        case .login:
            setupAsLogin(shouldAnimate)
        case .signup:
            setupAsSignup(shouldAnimate)
        case .autoLogin:
            setupAsAutoLogin()
            tryAutoLogin()
        }
    }
    
    private func setupAsLogin(_ shouldAnimate: Bool = true) {
        
        if shouldAnimate {
            UIView.animate(withDuration: 1) {
                self.mainImageViewCenterConstraint.constant = -200
                self.view.layoutIfNeeded()
            } completion: { (complete) in
                if complete {
                    self.loginSignUpButton.isHidden = false
                    self.mainStackView.isHidden     = false
                    self.goToSignupButton.isHidden  = false
                    self.crossButton.isHidden       = false
                }
            }
        } else {
            self.mainImageViewCenterConstraint.constant = -200
            self.loginSignUpButton.isHidden = false
            self.mainStackView.isHidden     = false
            self.goToSignupButton.isHidden  = false
            self.crossButton.isHidden       = false
            self.view.layoutIfNeeded()
        }
        
        goToSignupButton.setTitle(AppStrings.Login.dontHaveAnAccount, for: .normal)
    }
    
    private func setupAsSignup(_ shouldAnimate: Bool = true) {
        if shouldAnimate {
            UIView.animate(withDuration: 1) {
                self.mainImageViewCenterConstraint.constant = -200
                self.view.layoutIfNeeded()
            } completion: { (complete) in
                if complete {
                    self.loginSignUpButton.isHidden = false
                    self.mainStackView.isHidden     = false
                    self.goToSignupButton.isHidden  = false
                    self.crossButton.isHidden       = false
                }
            }
        } else {
            self.mainImageViewCenterConstraint.constant = -200
            self.loginSignUpButton.isHidden = false
            self.mainStackView.isHidden     = false
            self.goToSignupButton.isHidden  = false
            self.crossButton.isHidden       = false
            self.view.layoutIfNeeded()
        }

        goToSignupButton.setTitle(AppStrings.Login.alreadyHaveAnAccount, for: .normal)
    }
    
    private func setupAsAutoLogin() {
        self.loginSignUpButton.isHidden         = true
        self.mainStackView.isHidden             = true
        self.goToSignupButton.isHidden          = true
        self.crossButton.isHidden               = true
        mainImageViewCenterConstraint.constant  = 0
    }
}

// MARK: API Calls
extension LoginViewController {
    func tryAutoLogin() {
        self.viewModel.tryAutoLogin()
    }
    
    func signUp(with email: String, password: String) {
        LoaderManager.instance.show()
        self.viewModel.signUp(with: email, password: password)
    }
    
    func login(with email: String, password: String) {
        LoaderManager.instance.show()
        self.viewModel.login(with: email, password: password)
    }
}

extension LoginViewController {
    
    @IBAction func onPressGoToSignUpButton(_ sender: Any) {
        switch screenType {
        case .login:
            setupUI(as: .signup, shouldAnimate: false)
        case .signup:
            setupUI(as: .login, shouldAnimate: false)
        default:
            break
        }
    }
    
    @IBAction func onPressCrossButton(_ sender: Any) {
        self.moveToHomeScreen()
    }
    
    @IBAction func onPressSignUpButton(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        switch screenType {
            
        case .login:
            if email.isValidEmail() && password.isValidPassword() {
                login(with: email, password: password)
            } else {
                BannerManager.instance.showBanner(title: AppStrings.Banner.Title.invalidData, message: AppStrings.Banner.Body.invalidData)
            }
        case .signup:
            if email.isValidEmail() && password.isValidPassword() {
                signUp(with: email, password: password)
            } else {
                BannerManager.instance.showBanner(title: AppStrings.Banner.Title.invalidData, message: AppStrings.Banner.Body.invalidData)
            }
        default:
            return
        }
    }
}

extension LoginViewController {
    
    func moveToHomeScreen() {
        let tabBar = ViewControllerFactory.makeTabBar()
        UIApplication.shared.mainKeyWindow?.rootViewController = tabBar
        UIApplication.shared.mainKeyWindow?.makeKeyAndVisible()
    }
}
