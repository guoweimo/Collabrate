//
//  UIImage+PDF.swift
//  Smarock
//
//  Created by MIX Family on 18/06/2019.
//  Copyright © 2019 Smarock. All rights reserved.
//

import Foundation
import PDFKit

extension URL {
  
  func pdfThumbnail(height: CGFloat) -> UIImage? {
    guard let data = try? Data(contentsOf: self),
      let page = PDFDocument(data: data)?.page(at: 0) else {
        return nil
    }
    
    let pageSize = page.bounds(for: .mediaBox)
    let pdfScale = height / pageSize.height
    let screenSize = CGSize(width: pageSize.width * pdfScale,
                            height: pageSize.height * pdfScale)
    
    return page.thumbnail(of: screenSize, for: .mediaBox)
  }
  
}

