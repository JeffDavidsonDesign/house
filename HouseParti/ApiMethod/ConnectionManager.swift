//
//  ConnectionManager.swift
//  Rilyo
//
//  Created by Developer on 09/04/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import NVActivityIndicatorView
import AlamofireObjectMapper

class ConnectionManager  {
	static let shared = ConnectionManager()
	typealias completion = ( _ result: Dictionary<String, Any>, _ error: Error?) -> ()

	func getRequest(methodName: String, parameters: Dictionary<String, Any>,onCompletion: @escaping completion) {
		if NetworkManager.isConnectedToNetwork() {
			let url = APP_BASE_URL + methodName
			let headerDictionary : [String : String] = [:]
			Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headerDictionary).responseJSON { (responseObject) in
				if responseObject.response?.statusCode == 401 && responseObject.response?.statusCode == 400 {
				} else {
					switch(responseObject.result) {
					case .success(_):
						if let data = responseObject.result.value{
							onCompletion(data as! Dictionary<String, Any>,nil)
						}
						break
						
					case .failure(_):
						onCompletion([:], responseObject.result.error as NSError?)
						break
						
					}
				}
			}
		}
        else{
            let alertController = UIAlertController(title: "Error", message: "OOPS Network is not Available", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                 UIApplication.shared.keyWindow?.rootViewController?.stopAnimating()
        }
	}
    
	func postRequest(methodName: String, parameters: Dictionary<String, Any>,onCompletion: @escaping completion) {
		if NetworkManager.isConnectedToNetwork() {
			let url = APP_BASE_URL + methodName
		let headerDictionary : [String : String] = [:]
		Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headerDictionary).responseJSON { (responseObject) in
			if responseObject.response?.statusCode == 401 && responseObject.response?.statusCode == 400 {
			} else {
				switch(responseObject.result) {
				case .success(_):
					if let data = responseObject.result.value{
						onCompletion(data as! Dictionary<String, Any>,nil)
					}
					break
					
				case .failure(_):
					onCompletion([:], responseObject.result.error as NSError?)
					break
				}
			}
		}
        }else{
            let alertController = UIAlertController(title: "Error", message: "OOPS Network is not Available", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
           UIApplication.shared.keyWindow?.rootViewController?.stopAnimating()
        }
	}
     //MARK:- POAST MEDIA -
    func postMediaRequest(methodName: String,image:Data?,video:Data?,videoExt:String?, parameters: Dictionary<String, Any>,onCompletion: @escaping completion) {
		if NetworkManager.isConnectedToNetwork() {
            let url = APP_BASE_URL + methodName
			Alamofire.upload(
				         multipartFormData: { multipartFormData in
                            if let imageData = image {
                               multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                            }
                            if let videoData = video {
                                multipartFormData.append(videoData, withName: "video", fileName: "video."+videoExt!, mimeType: "video/"+videoExt!)

                            }
                            for (key, val) in parameters {
                            multipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
   
                             }
					     },
				         to: url,
				         encodingCompletion: { encodingResult in
				             switch encodingResult {
				             case .success(let upload, _, _):
				                 upload.responseJSON { responseObject in
													if responseObject.response?.statusCode == 401 && responseObject.response?.statusCode == 400 {
													} else {
													switch(responseObject.result) {
													case .success(_):
														if let data = responseObject.result.value{
															onCompletion(data as! Dictionary<String, Any>,nil)
														}
														break
														
													case .failure(_):
														onCompletion([:], responseObject.result.error as NSError?)
														break
														
													}
                                                }
                                            }
				             case .failure(let encodingError):
				                 onCompletion([:], encodingError)
				             }
				     }
				    )
		}
        else{
            let alertController = UIAlertController(title: "Error", message: "OOPS Network is not Available", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                 UIApplication.shared.keyWindow?.rootViewController?.stopAnimating()
        }
	}
    
}


