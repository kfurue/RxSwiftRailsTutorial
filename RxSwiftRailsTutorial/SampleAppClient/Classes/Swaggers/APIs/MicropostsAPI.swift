//
// MicropostsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class MicropostsAPI {
    /**
     Destroy micropost with id.
     
     - parameter id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteApiV1MicropostsId(id: Int, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteApiV1MicropostsIdWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Destroy micropost with id.
     
     - parameter id: (path)  
     - returns: Observable<Void>
     */
    open class func deleteApiV1MicropostsId(id: Int) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            deleteApiV1MicropostsId(id: id) { error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(()))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Destroy micropost with id.
     - DELETE /api/v1/microposts/{id}
     - Destroy micropost with id.
     
     - parameter id: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func deleteApiV1MicropostsIdWithRequestBuilder(id: Int) -> RequestBuilder<Void> {
        var path = "/api/v1/microposts/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SampleAppClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SampleAppClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Create a new micropost.
     
     - parameter content: (form) Your micropost. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postApiV1Microposts(content: String, completion: @escaping ((_ data: Micropost?,_ error: Error?) -> Void)) {
        postApiV1MicropostsWithRequestBuilder(content: content).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Create a new micropost.
     
     - parameter content: (form) Your micropost. 
     - returns: Observable<Micropost>
     */
    open class func postApiV1Microposts(content: String) -> Observable<Micropost> {
        return Observable.create { observer -> Disposable in
            postApiV1Microposts(content: content) { data, error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Create a new micropost.
     - POST /api/v1/microposts
     - Create a new micropost.
     - examples: [{contentType=application/json, example={
  "user_id" : 6,
  "id" : 0,
  "content" : "content",
  "picture" : {
    "url" : "url"
  }
}}]
     
     - parameter content: (form) Your micropost. 

     - returns: RequestBuilder<Micropost> 
     */
    open class func postApiV1MicropostsWithRequestBuilder(content: String) -> RequestBuilder<Micropost> {
        let path = "/api/v1/microposts"
        let URLString = SampleAppClientAPI.basePath + path
        let formParams: [String:Any?] = [
            "content": content
        ]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Micropost>.Type = SampleAppClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
