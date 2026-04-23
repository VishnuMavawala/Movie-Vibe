//
//  3.Liskov Substitution Principle (LSP)
//  Subclasses should be replaceable parent class without breaking behavior
//

class LiskovSubstitutionPrinciple {
    
    class Audio {
        func fileExtension() {}
        func lyrics() -> String {
            return "default"
        }
    }
    
    func play() {
        let audio = Audio()
        let lyrics = audio.lyrics()
        print(lyrics)  // Default
    }
    
    //------------------//
    
    class HindiAudio: Audio {
        override
        func lyrics() -> String {
            return "Hindi"
        }
    }
    
    func play1() {
        let audio: Audio = HindiAudio() //Parent-Audio()
        let lyrics = audio.lyrics()
        print(lyrics) // Hindi
    }
}
