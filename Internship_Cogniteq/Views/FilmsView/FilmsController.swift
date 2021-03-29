//
//  FilmsView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 22.03.21.
//

import Combine
import SwiftUI

protocol FilmsViewProtocol: class {
    func openDetailView(item: Films.Results)
}

final class FilmsController: UIHostingController<FilmsView> {
    private let state = FilmsState()
    private let networkService = NetworkService()
    
    init() {
        let view = FilmsView(state: state)
        super.init(rootView: view)
        state.controller = self
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        let view = FilmsView(state: state)
        super.init(coder: aDecoder, rootView: view)
        state.controller = self
    }
}

extension FilmsController: FilmsViewProtocol {
    func openDetailView(item: Films.Results) {
        let detailController = FilmDetailController(item)
        detailController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailController, animated: true)
    }
}
