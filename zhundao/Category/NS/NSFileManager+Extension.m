//
//  NSFileManager+Extension.m
//  zhundao
//
//  Created by maj on 2021/4/9.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "NSFileManager+Extension.h"

static NSString *logFolderName = @"zhundao/Log";

@implementation NSFileManager (Extension)
//系统文件夹
+ (NSString *)libraryFolder {
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
}

//自定义文件夹
+ (NSString *)logFolder {
    return [self createSubFolder:logFolderName superFolder:[self libraryFolder]];
}

+ (NSString *)createSubFolder:(NSString *)subFolderName superFolder:(NSString *)superFolder {
    NSString *path = [superFolder stringByAppendingPathComponent:subFolderName];
    if (![[self defaultManager] fileExistsAtPath:path]) {
        [[self defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

@end
