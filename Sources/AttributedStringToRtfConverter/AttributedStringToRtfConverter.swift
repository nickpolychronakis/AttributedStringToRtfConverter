import SwiftUI

@available(iOS 11, macOS 10.13, *)
public extension NSAttributedString {
    /// Δημιουργεί ένα NSAttributedString απο ένα αρχείο rtf που βρίσκεται στο Bundle.
    /// Δηλαδή πρέπει να έχεις προσθέσει στο Bundle το αρχείο απο πρίν.
    /// Εισάγεις μόνο το όνομα του αρχείου για να το ανοίξει.
    convenience init(rtfFilename: String, bundle: Bundle = Bundle.main) {
        if let url = bundle.url(forResource: rtfFilename, withExtension: nil) {
            if let attributedStringFromRTF: NSAttributedString = try? NSAttributedString(url: url, options: [DocumentReadingOptionKey.documentType : DocumentType.rtf], documentAttributes: nil) {
                
                self.init(attributedString: attributedStringFromRTF)
                return
            }
        }
        self.init(string: "")
    }
    
    /// Δημιουργεί ένα NSAttributedString απο ένα αρχείο rtf.
    /// Εισάγεις το URL του αρχείου.
    convenience init(rtfURL url: URL) {
        if let attributedStringFromRTF: NSAttributedString = try? NSAttributedString(url: url, options: [DocumentReadingOptionKey.documentType : DocumentType.rtf], documentAttributes: nil) {
            
            self.init(attributedString: attributedStringFromRTF)
            return
        } else {
            self.init(string: "")
        }
    }
    
    /// Αποθηκεύει τα δεδομένα σε αρχείο στο URL που εισάγουμε.
    /// Σε περίπτωση σφάλματος επιστρέφει error του τύπου writeRtfError.
    func writeAsRTF(to url: URL) throws {
        let documentAttibutes: [DocumentAttributeKey: Any] = [.documentType:NSAttributedString.DocumentType.rtf]
        let range = NSRange(location: 0, length: self.length)
        guard let data = try? self.data(from: range, documentAttributes: documentAttibutes) else { throw writeRtfError.couldNotReadDataFromAttributedString }
        do {
            try data.write(to: url)
        } catch {
            throw writeRtfError.couldNotWriteDataToFile
        }
    }
    
    /// Είναι ο τύπος των error που επιστρέφει η writeAsRTF method
    enum writeRtfError: Error {
        case couldNotReadDataFromAttributedString
        case couldNotWriteDataToFile
    }
}
