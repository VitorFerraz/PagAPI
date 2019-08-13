//
//  HomeViewModel.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
protocol HomeViewModelPresentable: ViewModelPresentable {
    var numberOfRows: Int { get }
    func getDetail() -> Beer?
    func select(index: IndexPath)
    func getDataFor(indexPath: IndexPath) -> PunkBeerCellViewModel
    func fetchData(page: Int?, completion: @escaping ((Result<PaginationResultType, Error>) -> Void))
}
final class HomeViewModel: HomeViewModelPresentable {
    private var repository: HomeRepository = HomeRemoteRepository()
    private var dataSource: [PunkBeerCellViewModel] {
        return paginableList.result?.compactMap({$0}).map({PunkBeerCellViewModel(model: $0)}) ?? []
    }
    var numberOfSections: Int = 1
    private var isLoading: Bool = false
    private var paginableList = GenericList<Beer>()
    private var selectedBeer: Beer?

    
    convenience init(repository: HomeRepository) {
        self.init()
        self.repository = repository
    }
    var numberOfRows: Int {
        return dataSource.count
    }
    
    func select(index: IndexPath) {
        if dataSource.indices.contains(index.row) {
            selectedBeer = dataSource[index.row].model
        }
    }
    
    func getDetail() -> Beer? {
        return selectedBeer

    }
    
    
    
    func getDataFor(indexPath: IndexPath) -> PunkBeerCellViewModel {
        return dataSource[indexPath.row]
    }
    
    func fetchData(page: Int?, completion: @escaping ((Result<PaginationResultType, Error>) -> Void)) {
        let nextPage = page ?? (paginableList.page ?? 1) + 1
        if let totalPages = paginableList.totalPages, (totalPages < nextPage || isLoading) {
            completion(.success((.noData)))
            return
        }
        isLoading = true
        paginableList.page = nextPage
        repository.fetch(page: paginableList.page ?? 1, parPage: paginableList.limit ?? 10) { [weak self] result in
            switch result {
            case .failure(let error):
                    completion(.failure(error))
            case .success(var list):
                if nextPage == 1 {
                    self?.paginableList.result = list
                    completion(.success(.newData))
                } else {
                    let startIndex = (self?.paginableList.result?.count ?? 1) - 1
                    let endIndex = startIndex + list.count - 1
                    let newindexs = (startIndex...endIndex).map({ IndexPath(row: $0, section: 0) })
                    let newList = (self?.paginableList.result ?? []) + (list)
                    list = newList
                    self?.paginableList.result = list
                    completion(.success(.insertData(indexs: newindexs)))
                }
            }
            self?.isLoading = false
        }
    }

}
