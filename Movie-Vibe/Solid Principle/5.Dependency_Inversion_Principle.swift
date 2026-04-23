//
//  5.Dependency Inversion Principle (DIP)
//  High-level modules should not depend on low-level modules
//

class DependencyInversionPrinciple {
    
    protocol Database {
        func save()
    }
    
    class LocalDB: Database {
        func save() {
            // Save data in local database
        }
    }
    
    struct ViewModel {
        let database: Database! //LocalDB
        
        func excute() {
            database.save()
        }
    }
    
    let viewModel = ViewModel(database: LocalDB())
    
    
    
//    class CloudDB: Database {
//        func save() {
//            // Save data on cloud server
//        }
//    }
//    let viewModel1 = ViewModel(database: CloudDB())
}
