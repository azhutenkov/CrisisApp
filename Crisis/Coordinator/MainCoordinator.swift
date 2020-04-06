//
//  MainCoordinator.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 01/03/2020.
//

import UIKit

final class MainCoordinator: AppCoordinator, AddChildRouting {

	weak var transitionHandler: UIViewController?
	weak var dashboardVC: DashboardVC?
	weak var launchVC: LaunchVC?
	    
    init(transitionHandler: UIViewController) {
        self.transitionHandler = transitionHandler
    }
    
    override func start() {
        super.start()
		showLaunch()
    }
	
	private func showLaunch() {
		guard let transitionHandler = self.transitionHandler else { return }
		let vc = LaunchVC()
		var vm = LaunchVM()
		vm.closeAction = { [weak self] in
			self?.showDashboard()
		}
		vc.viewModel = vm
		launchVC = vc
		addChild(childController: vc, toParentController: transitionHandler)
	}
	
	private func showDashboard() {
		guard let transitionHandler = self.transitionHandler else { return }
		let vc = DashboardVC()
		let vm = DashboardVM()
		vc.viewModel = vm
		dashboardVC = vc
		replaceChild(viewController: vc, to: transitionHandler)
		
		vm.updateCallback = { [weak vc, weak self] result in
			switch result {
			case .failure(let error):
				self?.showAlert(error)
				
			default:
				break
			}
			
			vc?.stopAnimation()
			vc?.reloadData()
			debugPrint("stop")
		}
		
		vm.onPressed = { [weak self] (generalCurrency, secondaryCurrency) in
			self?.showCalculator(generalCurrency, secondaryCurrency)
		}
		
		vm.loadDataCallback = { [weak vc] in
			vc?.startAnimation()
		}
		
		vm.fetchRates()
	}
	
	private func showAlert(_ error: Error) {
		
		var errorMessage: String = "Что-то пошло не так"
		if let afError = error.asAFError {
			switch afError {
			case .sessionTaskFailed(let error as NSError):
				if error.code == NSURLErrorNotConnectedToInternet {
					errorMessage = "Вероятно, соединение с интернетом прервано"
				} else {
					errorMessage = error.localizedDescription
				}
			default:
				break
			}
		}
		
		let alertVC = UIAlertController(
			title: "Ошибка",
			message: errorMessage,
			preferredStyle: .alert
		)
		
		let okAction: UIAlertAction = UIAlertAction.init(title: "OK", style: .default) { [weak self] _ in
			self?.dashboardVC?.viewModel?.fetchRates()
		}
		
		alertVC.addAction(okAction)
		transitionHandler?.present(alertVC, animated: true)
	}
	
	private func showCalculator(_ generalCurrency: Currency, _ secondaryCurrency: Currency) {
		let vm = CalculatorVM(withGeneralCurrency: generalCurrency, secondaryCurrency: secondaryCurrency)
		let vc = CalculatorVC()
		vm.closeCallback = { [weak self] in
			self?.transitionHandler?.dismiss(animated: true)
		}
		vc.viewModel = vm
		transitionHandler?.present(UINavigationController(rootViewController: vc), animated: true)
	}
}
