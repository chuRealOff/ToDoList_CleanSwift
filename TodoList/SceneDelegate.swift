//
//  SceneDelegate.swift


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		
		window.rootViewController = assembly()
		window.makeKeyAndVisible()
		
		self.window = window
	}
	
	private func assembly() -> UIViewController {
		
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		guard let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
				as? MainViewController
		else {
			fatalError("Нету на Main.storyboard MainViewController!")
		}
		
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)
		let presenter = MainPresenter(view: viewController)
		let interactor = MainInteractor(sectionManager: sections, presenter: presenter)
		viewController.interactor = interactor
		
		return viewController
	}
}
