//
//  BlogRouter.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 05/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import Alamofire

enum BlogRouter {
    case blogs(pageNo : Int)
}

extension BlogRouter : APIRouter {
    var path: String {
        switch self {
        case .blogs(let pageNo):
            return "/blogs?page=\(pageNo)&limit=10"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    
}
