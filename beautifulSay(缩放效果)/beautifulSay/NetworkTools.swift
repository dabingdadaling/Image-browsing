//
//  NetworkTools.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/15.
//  Copyright © 2016年 xiebin. All rights reserved.
//

enum requestType{
    case GET
    case POST
}
import UIKit
import AFNetworking
class NetworkTools: AFHTTPSessionManager {
    // 创建单例
    static let tools : NetworkTools = {
        let netTool = NetworkTools()
        netTool.responseSerializer.acceptableContentTypes?.insert("text/html")
        return netTool
    }()
    
    
}
// 集成网络请求
extension NetworkTools{
    func requestData(type:requestType,urlString:String,parameters:[String :NSObject],finishCallBack:(result : AnyObject?,error :NSError?)->()){
        let successCallBack = {(task : NSURLSessionDataTask,result:AnyObject?) in finishCallBack(result :result ,error :nil)
        }
        
        let errorCallBack = {(task:NSURLSessionDataTask?,error :NSError) in finishCallBack(result: nil, error: error)
        }
        
        if type == .GET {
            GET(urlString, parameters: parameters,progress: nil, success: successCallBack, failure: errorCallBack)
        }else{
            POST(urlString, parameters: parameters,progress: nil, success: successCallBack, failure: errorCallBack)
        }
    }
}