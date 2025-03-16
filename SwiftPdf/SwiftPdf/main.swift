//
//  main.swift
//  SwiftPdf
//
//  Created by Jan on 16.03.2025.
//

import Foundation
import PDFKit

print("Hello, World!")

let inputFileURL = FileManager.default.homeDirectoryForCurrentUser.appending(
    path: "Downloads/Account_statement_0-3161711093_from_20250131.pdf")

let pdf = PDFDocument(url: inputFileURL)!

print(pdf.documentAttributes)

let page0 = pdf.page(at: 0)
let string = page0?.string

print(string)

