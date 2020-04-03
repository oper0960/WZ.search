//
//  UIImage+.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/24.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

extension UIImage {
    func blurImage(radius: CGFloat, forRect rect: CGRect) -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: self)
//        let originalOrientation = self.imageOrientation
//        let originalScale = self.scale

        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(radius, forKey: kCIInputRadiusKey)
        let outputImage = filter?.outputImage

        var cgImage: CGImage?

        if let output = outputImage {
            cgImage = context.createCGImage(output, from: inputImage!.extent)
        }

        if let cgImageA = cgImage {
            return UIImage(cgImage: cgImageA)
        }

        return nil
    }
    
    func imageWithColor(forRect rect: CGRect, tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        tintColor.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
