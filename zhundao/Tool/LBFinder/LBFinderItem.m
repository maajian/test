//
//  LBFinderItem.m
//  LBFinder
//
//  Created by 李兵 on 2018/1/11.
//

#import "LBFinderItem.h"

@implementation LBFinderItem
#pragma mark - Private
NSArray *lbf_images(void) {
    return @[@"png", @"jpg", @"jpeg", @"tmp", @"ktx"];
}
NSArray *lbf_texts(void) {
    return @[@"text",@"log"];
}
NSArray *lbf_videos(void) {
    return @[@"mp4", @"rmvb", @"mpeg"];
}
NSArray *lbf_audios(void) {
    return @[@"mp3", @"caf"];
}
NSArray *lbf_plists(void) {
    return @[@"plist"];
}
NSString *lbf_suffix(NSString *filename) {
    __block NSInteger index = -1;
    [filename enumerateSubstringsInRange:NSMakeRange(0, filename.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if ([substring isEqualToString:@"."]) {
            index = substringRange.location;
            *stop = YES;
        }
    }];
    if (index > 0 && index < filename.length - 1) {
        return [filename substringFromIndex:index+1];
    }
    return @"";
}

#pragma mark - Public
- (NSString *)name {
    return self.path.lastPathComponent;
}
- (LBFinderItemType)type {
    BOOL isFolder;
    [[NSFileManager defaultManager] fileExistsAtPath:self.path isDirectory:&isFolder];
    if (isFolder) {
        return LBFinderItemTypeFolder;
    }
    
    NSString *name = self.name;
    NSString *suffix = lbf_suffix(name);
    if (suffix.length <= 0) {
        return LBFinderItemTypeUnknown;
    }
    if ([lbf_images() containsObject:suffix]) {
        return LBFinderItemTypeFileImage;
    }else if ([lbf_texts() containsObject:suffix]) {
        return LBFinderItemTypeFileText;
    }else if ([lbf_audios() containsObject:suffix]) {
        return LBFinderItemTypeFileAudio;
    }else if ([lbf_videos() containsObject:suffix]) {
        return LBFinderItemTypeFileVideo;
    }else if ([lbf_plists() containsObject:suffix]) {
        return LBFinderItemTypeFilePlist;
    }
    return LBFinderItemTypeUnknown;
}
- (BOOL)isFolder {
    return self.type == LBFinderItemTypeFolder;
}
- (NSInteger)size {
    if (self.isFolder) {
        return 0;
    }
    NSError *error;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:self.path error:&error];
    if (error) {
        DDLogVerbose(@"read file attributes failed, error:%@", error);
        return 0;
    }
    return [attributes[NSFileSize] integerValue];
}
- (NSString *)sizeString {
    CGFloat size = (CGFloat)self.size;
    NSString *unit = @"B";
    if (size >= 1024) {
        size /= 1024;
        unit = @"KB";
    }
    if (size >= 1024) {
        size /= 1024;
        unit = @"MB";
    }
    if (size >= 1024) {
        size /= 1024;
        unit = @"GB";
    }
    if (size >= 1024) {
        size /= 1024;
        unit = @"TB";
    }
    return [NSString stringWithFormat:@"%.2f%@", size, unit];
}
- (NSArray<LBFinderItem *> *)subItems {
    if (!self.isFolder) {
        return nil;
    }
    NSError *error;
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
    if (error) {
        DDLogVerbose(@"read contents failed, error:%@", error);
        return nil;
    }
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSString *name in arr) {
        LBFinderItem *item = [LBFinderItem new];
        item.path = [self.path stringByAppendingPathComponent:name];
        [items addObject:item];
    }
    return items;
}
- (NSInteger)subItemsCount {
    return self.subItems.count;
}

+ (instancetype)instanceWithPath:(NSString *)path {
    LBFinderItem *instance = [LBFinderItem new];
    instance.path = path;
    return instance;
}

@end
