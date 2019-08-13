//
//  PunkBeerTests.swift
//  PunkBeerTests
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import XCTest
import Moya

@testable import PunkBeer

class PunkBeerTests: XCTestCase {
    var sut: HomeViewModel!
    override func setUp() {
        super.setUp()
        let mockProvider = ProviderBuilder<HomeService>().buildMock()
        
        sut = HomeViewModel.init(repository: HomeRemoteRepository(provider: mockProvider))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoadData_ExpectNewData_NotNil() {
        sut.fetchData(page: 1) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let value):
                switch value {
                case .newData:
                    XCTAssertTrue(true)
                default:
                    XCTFail()
                }
                XCTAssertGreaterThanOrEqual(self.sut.numberOfRows, 0)
            }
        }
    }
    
    func testPagination_ExpectNewElement(){
        sut.fetchData(page: 1) { (_) in
            
        }
        
        func testLoadData_ExpectNewData_NotEmpty() {
            sut.fetchData(page: 2) { (result) in
                switch result {
                case .failure(let error):
                    XCTAssertNil(error)
                case .success(let value):
                    switch value {
                    case .insertData(let indexs):
                        XCTAssertTrue(!indexs.isEmpty)
                    default:
                        XCTFail()
                    }
                    XCTAssertGreaterThanOrEqual(self.sut.numberOfRows, 0)
                }
            }
        }
    }
    
    func testPagination_ExpectNoContent(){
        func testLoadData_ExpectNewData_NotEmpty() {
            sut.fetchData(page: 999) { (result) in
                switch result {
                case .failure(let error):
                    XCTAssertNil(error)
                case .success(let value):
                    switch value {
                    case .noData:
                        XCTAssertTrue(true)
                    default:
                        XCTFail()
                    }
                    XCTAssertGreaterThanOrEqual(self.sut.numberOfRows, 0)
                }
            }
        }
    }
    
    func testCreateItem_ExpectNotNil() {
        sut.fetchData(page: 1) { result in
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let value):
                switch value {
                case .newData:
                    XCTAssertTrue(true)
                    let item = self.sut.getDataFor(indexPath: IndexPath.init(row: 0, section: 0))
                    XCTAssertEqual(item.value, "4.50%")
                    XCTAssertEqual(item.name, "Buzz")
                    XCTAssertNotNil(item.imageUrl)
                    XCTAssertEqual(item.imageUrl, URL(string: "https://images.punkapi.com/v2/keg.png")!)
                default:
                    XCTFail()
                }
                XCTAssertGreaterThanOrEqual(self.sut.numberOfRows, 0)
            }
        }
    }
    
    func testSelectValidDetail_ExpectNotNil() {
        sut.fetchData(page: 1) { result in
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let value):
                switch value {
                case .newData:
                    XCTAssertTrue(true)
                    self.sut.select(index: IndexPath.init(row: 0, section: 0))
                    XCTAssertNotNil(self.sut.getDetail())
                 
                default:
                    XCTFail()
                }
                XCTAssertGreaterThanOrEqual(self.sut.numberOfRows, 0)
            }
        }
    }
    
    func testSelectInvalidDetail_ExpectNotNil() {
        self.sut.select(index: IndexPath.init(row: 0, section: 0))
        XCTAssertNil(self.sut.getDetail())
    }
    
    func testCreateDetailViewModel_ExpectValidData() {
        sut.fetchData(page: 1) { result in
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let value):
                switch value {
                case .newData:
                    XCTAssertTrue(true)
                    self.sut.select(index: IndexPath.init(row: 0, section: 0))
                    let model = self.sut.getDetail()
                    XCTAssertNotNil(model)
                    let vm = DetailViewModel.init(model: model)
                    XCTAssertNotNil(vm.model)
                    XCTAssertEqual(vm.name, "Buzz | Tagline: A Real Bitter Experience.")
                    XCTAssertEqual(vm.description, "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.")
                    XCTAssertNotNil(vm.ibu, "Escala de amargor: 60.00")
                    XCTAssertNotNil(vm.abv, "Teor alcoólico: 4.50%")
                    XCTAssertEqual(vm.logoUrl, URL(string: "https://images.punkapi.com/v2/keg.png")!)
                default:
                    XCTFail()
                }
                XCTAssertGreaterThanOrEqual(self.sut.numberOfRows, 0)
            }
        }
    }

}
