# AttributedStringToRtfConverter

Αυτό το Package περιέχει extension του NSAttributedString με methods που μας διευκολύνουν να διαβάσουμε και να αποθηκεύσουμε αρχεία τύπου RTF.

## Δημιουργία NSAttributedString απο RTF

Μπορούμε να δημιουργήσουμε ένα NSAttributedSting απο ένα αρχείο RTF που έχουμε προσθέσει στο Bundle:
``` swift
let readingAttrFromFile = NSAttributedString(rtfFilename: filename)
```

Μπορούμε να δημιουργήσουμε ένα NSAttributedSting απο το URL ενός αρχείου RTF:
``` swift
let readingAttrFromFile = NSAttributedString(rtfURL: fileURL)
```

## Αποθήκευση ενός NSAttributedString σε RTF

Μπορούμε να αποθηκεύσουμε ένα NSAttributedString σε ένα αρχείο RTF:
``` swift
do {
    try testingAttr.writeAsRTF(to: fileURL)
} catch {
    // Το error είναι του τύπου
    // NSAttributedString.writeRtfError.couldNotReadDataFromAttributedString
    // NSAttributedString.writeRtfError.couldNotWriteDataToFile
}
```
