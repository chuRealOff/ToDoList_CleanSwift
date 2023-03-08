//
//  Interactor.swift
//  TodoList
//
//  Created by CHURILOV DMITRIY on 02.03.2023.
//

import Foundation

protocol IMainInteractor {
	func didTaskSelected(at indexPath: IndexPath)
}

final class MainInteractor: IMainInteractor {
	private var sectionManager: ISectionForTaskManagerAdapter!
	private var presenter: IMainPresenter?
	
	init(sectionManager: ISectionForTaskManagerAdapter, presenter: IMainPresenter) {
		self.sectionManager = sectionManager
		self.presenter = presenter
	}
	
	func didTaskSelected(at indexPath: IndexPath) {
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.completed.toggle()
		presenter?.present(sectionManager: sectionManager)
	}
}

