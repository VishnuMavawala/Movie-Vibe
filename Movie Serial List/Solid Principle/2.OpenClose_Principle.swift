//
//  2.Open/Closed Principle (OCP)
//  Open for extension, closed for modification
//

class OpenClosePrinciple {
    
    class UPI {
        func payment(type: String) {
            if type == "GPAY" {
                //...
            } else if type == "PAYTM" {
                //...
            }
        }
    }
    
    //---------------------//
    
    protocol UPIProto {
        func payment()
    }
    
    class GPAY: UPIProto {
        func payment() {}
    }
    
    class PAYTM: UPIProto {
        func payment() {}
    }
    
//    class BharatPay: UPIProto {
//        func payment() {}
//    }
}
