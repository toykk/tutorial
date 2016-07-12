//
//  XCache.swift
//  缓存操作
//
//  Created by ChenPeter on 16/7/10.
//  Copyright © 2016年 ChenPeter. All rights reserved.
//

import UIKit

class XCache: NSObject {
    /**
     *  读取缓存大小
     */
    static func returnCacheSize()->String{
        return String(format:"%.2f",XCache.forderSizeAtPath(NSHomeDirectory()))
    }
    /**
     计算单个文件的大小 单位MB
     
     - parameter path: 文件路径
    
     - returns: 返回文件的大小
     */
    static func returnFileSize(path:String)->Double{
        let manage = NSFileManager.defaultManager()
        var fileSize:Double = 0
        do {
            fileSize = try manage.attributesOfItemAtPath(path)["NSFileSize"] as! Double//字典型
        }catch{
            
        }
        return fileSize/1024/1024
    }
    /**
     遍历所有子目录并计算大小
     
     - parameter folderParh: 目录路径
     
     - returns: 返回文件大小
     */
    static func forderSizeAtPath(folderParh:String)->Double{
        let manage = NSFileManager.defaultManager()
        if !manage.fileExistsAtPath(folderParh){
            return 0 //若路径不存在直接返回0
        }
        let childFilePath = manage.subpathsAtPath(folderParh)//获取子文件夹
        var fileSize:Double = 0
        for path in childFilePath!{
            let fileAbsoluePath = folderParh+"/"+path
            fileSize += XCache.returnFileSize(fileAbsoluePath)//大小等于所有目录相加
        }
        return fileSize//返回所有子目录大小
    }
    /**
     *  清除缓存
     */
    static func cleanCache(competion:()->Void){
        XCache.deleteFoler(NSHomeDirectory()+"/Documents")
        XCache.deleteFoler(NSHomeDirectory()+"/Library")
        XCache.deleteFoler(NSHomeDirectory()+"/tmp")
        competion()
    }
    /**
     *  删除单个文件
     */
    static func deleteFile(path:String){
        let manage = NSFileManager.defaultManager()
        do{
            try manage.removeItemAtPath(path)
        }catch{
            
        }

        
    }
    /**
     删除文件夹下的所有文件
     
     - parameter path: 文件夹路径
     */
    static func deleteFoler(folderParh:String){
        let manage = NSFileManager.defaultManager()
        if !manage.fileExistsAtPath(folderParh){
          
        }
        let childFilePath = manage.subpathsAtPath(folderParh)//获取子文件夹
        for path in childFilePath!{
            let fileAbsoluePath = folderParh+"/"+path
            XCache.deleteFile(fileAbsoluePath)
     }
    
   }
}
