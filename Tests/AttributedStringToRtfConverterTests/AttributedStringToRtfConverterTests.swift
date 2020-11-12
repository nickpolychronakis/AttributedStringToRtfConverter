import XCTest
@testable import AttributedStringToRtfConverter

final class AttributedStringToRtfConverterTests: XCTestCase {
    /// Εδώ θα δοκιμάζω την εγγραφή και ανάγνωση των method writeAsRTF(to:) και init(rtfURL:)
    func testWriteAndRead() {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempfile.rtf")
        // writing file
        let testingAttr = NSAttributedString(string: "Hello world!")
        do {
            try testingAttr.writeAsRTF(to: tempURL)
        } catch {
            XCTAssertEqual(error as! NSAttributedString.writeRtfError, .couldNotReadDataFromAttributedString)
            XCTAssertEqual(error as! NSAttributedString.writeRtfError, .couldNotWriteDataToFile)
        }
        // read file
        let newAttr = NSAttributedString(rtfURL: tempURL)
        
        // Ότι έγραψε η πρώτη διαβάστηκε απο την δεύτερη. Έβαλα το .string γιατί τα attributedStrings δεν είναι τα ίδια. Όταν αποθηκεύεται στο αρχείο προσθέτει και κάποια προεπιλεγμένα attributes που δεν υπάρχουν (όπως τα fonts).
        XCTAssertEqual(testingAttr.string, newAttr.string)
    }
    
    func testReadRtfFromBundle() {
        let filename = "testingFile.rtf"
        let testingAttr = NSAttributedString(string: "Hello world!")
        
        let readingAttrFromFile = NSAttributedString(rtfFilename: filename, bundle: Bundle.module)
        
        XCTAssertEqual(testingAttr.string, readingAttrFromFile.string)
    }
}
