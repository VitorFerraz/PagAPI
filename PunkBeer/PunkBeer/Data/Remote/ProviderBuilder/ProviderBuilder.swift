//
//  ProviderBuilder.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya

struct ProviderBuilder<Target: TargetType>  {
    
    func build(_ plugins: PluginType...) -> MoyaProvider<Target> {
        var plugins: [PluginType] = plugins
        #if DEBUG
        plugins.append(NetworkPlugin.log.plugin)
        #endif
        return MoyaProvider<Target>(plugins: plugins)
    }
    
    func buildMock() -> MoyaProvider<Target> {
        return MoyaProvider<Target>(stubClosure: MoyaProvider.immediatelyStub,
                                    plugins: [NetworkPlugin.log.plugin])
    }
}
