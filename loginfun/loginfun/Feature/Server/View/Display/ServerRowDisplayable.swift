import SwiftUI

extension Server {
    struct ServerRowDisplayable: Identifiable {
        let id: String
        let name: String
        let distance: String
        
        init(name: String, distance: Double) {
            self.id = "\(name)#\(distance)"
            self.name = name
            self.distance = "\(Int(distance)) km"
        }
    }
}
