//
//  ImageView2.swift
//  WikiMap
//
//  Created by 양원모 on 2022/04/08.
//

import SwiftUI

@IBAction func pressedAddButton(_ sender: UIButton) {
        
    let imagePicker = ImagePickerController()
    imagePicker.settings.selection.max = 5
    imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        
    let vc = self.window?.rootViewController
        
    vc?.presentImagePicker(imagePicker, select: { (asset) in
            
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
   
    }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
  
    }, cancel: { (assets) in
            // User canceled selection.

    }, finish: { (assets) in
            // User finished selection assets.
            
        for i in 0..<assets.count {
            self.selectedAssets.append(assets[i])
         }
         self.convertAssetToImages()
         self.delegate?.didPickImagesToUpload(images: self.userSelectedImages)
     })
        
        
}
