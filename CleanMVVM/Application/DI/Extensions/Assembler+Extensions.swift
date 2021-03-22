//
//  Assembler+Extensions.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 22/03/2021.
//

import Foundation
import Swinject

extension Assembler {
    
    static let sharedAssembler: Assembler = {
        let container = Container()
        
        let assembler = Assembler([
            ViewControllerAssembly(),
            ViewModelAssembly(),
            RepositoryAssembly(),
            UseCaseAssembly(),
            NetworkAssembly(),
            PersistenceAssembly()
        ], container: container)
        
        return assembler
    }()
}
