import Foundation
import PDFKit

let directoryURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
let fileNamePattern: String = "Account_statement_"


var dirItems = try FileManager.default.contentsOfDirectory(atPath: directoryURL.absoluteURL.path())
for item in dirItems
{
    if item.hasPrefix(fileNamePattern) && item.hasSuffix(".pdf") {
        print(item)
        let inputFileURL = URL(fileURLWithPath: item, relativeTo: directoryURL)
        
        guard let pdf = PDFDocument(url: inputFileURL) else {
            continue
        }
        
        let fileURL = URL(fileURLWithPath: inputFileURL.absoluteString, relativeTo: directoryURL).appendingPathExtension("txt")
        
        if FileManager.default.createFile(atPath: fileURL.absoluteURL.path(), contents: nil) {
            
            let fHandle = try FileHandle.init(forWritingTo: fileURL)
            try fHandle.seekToEnd()
            
            for i in (0...pdf.pageCount) {
                do {
                    try fHandle.write(contentsOf: (pdf.page(at: i)?.string ?? "").data(using: .utf8)!)
                }
                catch {
                    print(error)
                }
            }
            try fHandle.close()
        } else {
            print("Output file not created.")
        }
    }
}
