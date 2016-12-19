//
//  JPVideoCachePathTool.m
//  JPVideoPlayerDemo
//
//  Created by lava on 2016/11/8.
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles

#import "JPVideoCachePathTool.h"

@implementation JPVideoCachePathTool

// Combine temporary file path.
// 拼接临时文件缓存存储路径
+(NSString *)fileCachePath{
    return [self getFilePathWithAppendingString:jp_tempPath];
}

// Combine complete file path.
// 拼接完整文件存储路径
+(NSString *)fileSavePath{
    return [self getFilePathWithAppendingString:jp_savePath];
}

+(NSString *)getFilePathWithAppendingString:(NSString *)apdStr{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:apdStr];
    
    // Make folder.
    // 创建文件夹
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
//    if (!isExist || !isDir) {
//        if (isExist) {
//            [fileManager removeItemAtPath:path error:nil];
//        }
    if (!isExist) {
        NSError *error = nil;
        BOOL succeed = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (!succeed) {
            NSLog(@"Create directory error: %@", error);
        }
    }
    
    return path;
}

// cache file Name.
// 缓存的文件名字
+(NSString *)suggestFileNameWithURL:(NSURL*)url{
#warning filename maybe is empty!
    NSString *fileName = [url.absoluteString.lastPathComponent componentsSeparatedByString:@"?"].firstObject;
    
    if (fileName.length == 0) {
        fileName = [url.absoluteString.lastPathComponent componentsSeparatedByString:@"&"].firstObject;
        fileName = [[fileName componentsSeparatedByString:@"="] lastObject];
    }
    if ([fileName componentsSeparatedByString:@"."].count < 2) {
        fileName = [fileName stringByAppendingString:@".mp4"];
    }
    return fileName;
}

@end
