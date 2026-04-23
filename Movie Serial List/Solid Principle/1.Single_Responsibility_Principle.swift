//
//  1.Single Responsibility Principle (SRP)
//  A class should have only ONE reason to change.
//

class SingleResponsibilityPrinciple {
    
    class Streaming {
        func play() {}
        func pause() {}
        func lyrics() {}
        func quality() {}
    }
    
    //----------------------//
    
    class Action {
        func play() {}
        func pause() {}
    }
    
    class Lyrics {
        func fontSize() {}
    }
    
    class Resolution {
        func quality() {}
    }
}
