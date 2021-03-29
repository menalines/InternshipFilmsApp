//
//  FilmsView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 22.03.21.
//

import Combine
import SwiftUI

final class FilmsState: ObservableObject {
    @Published var films = [Films.Results]()
    
    weak var controller: FilmsController?
    private var cancellable = Set<AnyCancellable>()

    func loadData() {
        NetworkService.loadFilms()
            .receive(on: RunLoop.main)
            .sink { error in
                print(error)
            } receiveValue: { results in
                self.films = results
            }
            .store(in: &cancellable)
    }
}

final class FilmsController: UIHostingController<FilmsView> {
    private let state = FilmsState()
    private let networkService = NetworkService()
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        cancellable?.cancel()
    }
    
    init() {
        let view = FilmsView(state: state)
        super.init(rootView: view)
        cancellable = NetworkService.loadFilms().sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] items in
                DispatchQueue.main.async {
                    self?.state.films = items
                }
            })
        state.controller = self
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        let view = FilmsView(state: state)
        super.init(coder: aDecoder, rootView: view)
        state.controller = self
    }
    
    func openDetailView(item: Films.Results) {
        let detailController = FilmDetailController(item)
        detailController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailController, animated: true)
    }
}
