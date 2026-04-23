import Foundation

class AllPrinciple {
    
    // --------------------
    // HIGH-LEVEL MODULE
    // --------------------
    
    class Hotel {
        let services: [Service]
        
        init(services: [Service]) {
            self.services = services
        }
        
        func runServices() {
            for service in services {
                service.execute()
            }
        }
    }
    
    // --------------------
    // ABSTRACTION (OCP + DIP)
    // --------------------
    
    protocol Service {
        func execute()
    }
    
    // --------------------
    // OPERATION FEATURE
    // --------------------
    
    class OperationService: Service {
        let usecase: OperationUsecase
        
        init(_ usecase: OperationUsecase) {
            self.usecase = usecase
        }
        
        func execute() {
            print(usecase.checkOutCall())
        }
    }
    
    protocol OperationUsecase {
        func checkOutCall() -> String
    }
    
    class OperationUsecaseImpl: OperationUsecase {
        func checkOutCall() -> String {
            return "Check-Out Calling"
        }
    }
    
    // --------------------
    // BILLING FEATURE
    // --------------------
    
    class BillingService: Service {
        let usecase: BillingUsecase
        
        init(_ usecase: BillingUsecase) {
            self.usecase = usecase
        }
        
        func execute() {
            print(usecase.billingCall())
        }
    }
    
    // ISP: Split interfaces
    protocol BillingReader {
        func billingCall() -> String
    }
    
    protocol BillingWriter {
        func generateInvoice()
    }
    
    // Combine only what is needed
    protocol BillingUsecase: BillingReader { }
    
    class BillingUsecaseImpl: BillingUsecase {
        func billingCall() -> String {
            return "Check pending bills"
        }
    }
    
    // --------------------
    // MAIN
    // --------------------
    
    func main() {
        let hotel = Hotel(services: [
            OperationService(OperationUsecaseImpl()),
            BillingService(BillingUsecaseImpl())
        ])
        
        hotel.runServices()
    }
    
}
