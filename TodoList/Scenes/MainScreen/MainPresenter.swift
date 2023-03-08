//
//  MainPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import Foundation

protocol IMainPresenter {
	func present(sectionManager: ISectionForTaskManagerAdapter)
}

class MainPresenter: IMainPresenter {

	private weak var view: IMainViewController!

	init(view: IMainViewController) {
		self.view = view
	}
	
	func present(sectionManager: ISectionForTaskManagerAdapter) {
		view.render(viewData: mapViewData(sectionManager: sectionManager))
	}
	
	private func mapViewData(sectionManager: ISectionForTaskManagerAdapter) -> MainModel.ViewData {
		var sections = [MainModel.ViewData.Section]()
		for section in sectionManager.getSections() {
			let sectionData = MainModel.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section) )
			)
			
			sections.append(sectionData)
		}
		
		return MainModel.ViewData(tasksBySections: sections)
	}
	
	private func mapTasksData(tasks: [Task]) -> [MainModel.ViewData.Task] {
		tasks.map{ mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> MainModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let result = MainModel.ViewData.ImportantTask(
				name: task.title,
				isDone: task.completed,
				isOverdue: task.deadLine < Date(),
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(MainModel.ViewData.RegularTask(name: task.title, isDone: task.completed))
		}
	}
}
