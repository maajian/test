//
//  LBFinderItem.h
//  LBFinder
//
//  Created by 李兵 on 2018/1/11.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LBFinderItemType){
    LBFinderItemTypeUnknown,
    LBFinderItemTypeFolder,
    LBFinderItemTypeFileImage,
    LBFinderItemTypeFileText,
    LBFinderItemTypeFileAudio,
    LBFinderItemTypeFileVideo,
    LBFinderItemTypeFilePlist,
};

@interface LBFinderItem : NSObject

@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) LBFinderItemType type;
@property (nonatomic, assign, getter=isFolder, readonly) BOOL folder;
@property (nonatomic, assign, readonly) NSInteger size;
@property (nonatomic, copy, readonly) NSString *sizeString;

@property (nonatomic, assign, readonly) NSInteger subItemsCount;
@property (nonatomic, strong, readonly) NSArray <LBFinderItem *> *subItems;

+ (instancetype)instanceWithPath:(NSString *)path;

@end
