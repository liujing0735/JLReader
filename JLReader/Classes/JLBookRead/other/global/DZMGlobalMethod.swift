//
//  JLGlobalMethod.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

// MARK: -- 颜色
/// RGB
func RGB(_ r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return RGBA(r, g: g, b: b, a: 1.0)
}

/// RGBA
func RGBA(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}


// MARK: -- 尺寸计算 以iPhone6为比例
func JLSizeW(_ size:CGFloat) ->CGFloat {
    return size * (screenWidth / 375)
}

func JLSizeH(_ size:CGFloat) ->CGFloat{
    return size * (screenHeight / 667)
}

// MARK: 截屏
/// 获得截屏视图（无值获取当前Window）
func ScreenCapture(_ view:UIView? = nil, _ isSave:Bool = false) ->UIImage {
    
    let captureView = (view ?? (UIApplication.shared.keyWindow ?? UIApplication.shared.windows.first))!
    
    UIGraphicsBeginImageContextWithOptions(captureView.frame.size, false, 0.0)
    
    captureView.layer.render(in: UIGraphicsGetCurrentContext()!)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    if isSave { UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil) }
    
    return image!
}

// MARK: -- 创建分割线
/// 给一个视图创建添加一条分割线 高度 : HJSpaceLineHeight
func SpaceLineSetup(view:UIView, color:UIColor? = nil) ->UIView {
    
    let spaceLine = UIView()
    
    spaceLine.backgroundColor = color != nil ? color : UIColor.lightGray
    
    view.addSubview(spaceLine)
    
    return spaceLine
}

// MARK: -- 获取时间
/// 获取当前时间传入 时间格式 "YYYY-MM-dd-HH-mm-ss"
func GetCurrentTimerString(dateFormat:String) ->String {
    
    let dateformatter = DateFormatter()
    
    dateformatter.dateFormat = dateFormat
    
    return dateformatter.string(from: Date())
}

/// 将 时间 根据 类型 转成 时间字符串
func GetTimerString(dateFormat:String, date:Date) ->String {
    
    let dateformatter = DateFormatter()
    
    dateformatter.dateFormat = dateFormat
    
    return dateformatter.string(from: date)
}

/// 获取当前的 TimeIntervalSince1970 时间字符串
func GetCurrentTimeIntervalSince1970String() -> String {
    
    return String(format: "%.0f",Date().timeIntervalSince1970)
}


// MARK: -- 阅读ViewFrame
/// 阅读TableView的位置
func GetReadTableViewFrame() ->CGRect {
    
    if isIPhoneXAll {
        
        // Y = 刘海高度 + 状态View高 + 间距
        let y =  TopLiuHeight + JLSpace_2 + JLSpace_6
        
        let bottomHeight = TopLiuHeight
        
        return CGRect(x: JLSpace_1, y: y, width: screenWidth - 2 * JLSpace_1, height: screenHeight - y - bottomHeight)
        
    }else{
        
        // Y =  状态View高 + 间距
        let y =  JLSpace_2 + JLSpace_6
        
        return CGRect(x: JLSpace_1, y: y, width: screenWidth - 2 * JLSpace_1, height: screenHeight - 2 * y)
    }
}

// MARK: 阅读视图位置
/* 阅读视图位置
 
 需要做横竖屏的可以在这里修改阅读View的大小
 
 GetReadViewFrame 会使用与 阅读View的Frame 以及计算分页的范围
 
 */
func GetReadViewFrame() ->CGRect {
   
    return CGRect(x: 0, y: 0, width: GetReadTableViewFrame().width, height: GetReadTableViewFrame().height)
}

// MARK: -- 创建文件夹
/// 创建文件夹 如果存在则不创建
func CreatFilePath(_ filePath:String) ->Bool {
    
    let fileManager = FileManager.default
    
    // 文件夹是否存在
    if fileManager.fileExists(atPath: filePath) {
        
        return true
    }
    
    do{
        try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        
        return true
        
    }catch{}
    
    return false
}


// MARK: -- 文件链接处理
/// 文件类型
func GetFileExtension(_ url:URL) ->String {
    
    return url.path.pathExtension()
}

/// 文件名称
func GetFileName(_ url:URL) ->String {
    
    return url.path.lastPathComponent().stringByDeletingPathExtension()
}


// MARK: -- 阅读页面获取文件方法

/// 主文件夹名称
private let ReadFolderName:String = "JLBookRead"

/// 归档阅读文件文件
func ReadKeyedArchiver(folderName:String,fileName:String,object:AnyObject) {
    
    var path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!) + "/\(ReadFolderName)/\(folderName)"
    
    if (CreatFilePath(path)) { // 创建文件夹成功或者文件夹存在
        
        path = path + "/\(fileName)"
        
        NSKeyedArchiver.archiveRootObject(object, toFile: path)
    }
}

/// 解档阅读文件文件
func ReadKeyedUnarchiver(folderName:String,fileName:String) ->AnyObject? {
    
    let path = ((NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/\(ReadFolderName)/\(folderName)") + "/\(fileName)"
    
    return NSKeyedUnarchiver.unarchiveObject(withFile: path) as AnyObject?
}

/// 删除阅读归档文件
func ReadKeyedRemoveArchiver(folderName:String,fileName:String? = nil) {
    
    var path = ((NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/\(ReadFolderName)/\(folderName)")
    
    if fileName != nil { path +=  "/\(fileName!)" }
    
    do{
        try FileManager.default.removeItem(atPath: path)
    }catch{}
}

/// 是否存在了该归档文件
func ReadKeyedIsExistArchiver(folderName:String,fileName:String? = nil) ->Bool {
    
    var path = ((NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/\(ReadFolderName)/\(folderName)")
    
    if fileName != nil { path +=  "/\(fileName!)" }
    
    return FileManager.default.fileExists(atPath: path)
}
