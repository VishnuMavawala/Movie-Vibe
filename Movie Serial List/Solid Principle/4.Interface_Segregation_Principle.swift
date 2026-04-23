//
//  4.Interface Segregation Principle (ISP)
//  Don’t force classes to implement methods they don’t need
//

class InterfaceSegregationPrinciple {
    
    protocol Player {
        func play()
        func pause()
        func lyrics()
        func resolution()
    }
    
    class Audio: Player {
        func play() {}
        func pause() {}
        func lyrics() {}
        func resolution() {}  // Audio don't have resolution
    }
    
    //-----------------------//
    
    protocol Action {
        func play()
        func pause()
    }
    
    protocol Lyrics {
        func lyrics()
    }
    
    protocol Resolution {
        func quality()
    }
    
    class Audio1: Action, Lyrics {
        func play() {}
        func pause() {}
        func lyrics() {}
    }
    
    class Video1: Action, Lyrics, Resolution {
        func play() {}
        func pause() {}
        func lyrics() {}
        func quality() {}
    }
}
