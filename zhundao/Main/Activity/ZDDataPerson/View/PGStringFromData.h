// 
 //PGStringFromData.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;
@import WebKit;

@class UIImage;
@class UITableView;
@class UIFont;
@class NSData;
@class NSString;
@class UIImageView;
@class NSArray;
@class UISwitch;
@class UIActivityIndicatorView;
@class UIScrollView;
@class PGColumnistChildData;

@interface PGStringFromData : NSObject

@property (nonatomic, readwrite, strong) UIImage *pickerViewShow;
@property (nonatomic, readwrite, strong) NSData *pageContolAliment;
@property (nonatomic, readwrite, strong) NSData *assetCellType;
@property (nonatomic, readwrite, assign) CGSize *screehButtonClick;
@property (nonatomic, readwrite, assign) CGPoint *rankMedalView;

+ (UIButton *)pg_integralMainHeaderWithcommentArticleSucc:(UIImage *)acommentArticleSucc cacheUserModel:(UISwitch *)acacheUserModel articleContentModel:(NSString *)aarticleContentModel;
+ (UIFont *)pg_shareInfoViewWithintegralMainData:(PGColumnistChildData *)aintegralMainData pageContolAliment:(PGColumnistChildData *)apageContolAliment activityListWith:(PGColumnistChildData *)aactivityListWith;
- (UIEdgeInsets)pg_userInterfaceIdiomWithshaderFromString:(CGPoint)ashaderFromString inputTextureVertex:(UIScrollView *)ainputTextureVertex;
- (CGPoint)pg_rankMedalViewWithcollectionWithOffset:(CGPoint)acollectionWithOffset receiveLocalNotification:(UITableViewStyle)areceiveLocalNotification;
- (NSLineBreakMode)pg_chatInputTextWithrouteSearchDone:(UITableViewStyle)arouteSearchDone mainMessageData:(CGSize)amainMessageData;
+ (void)instanceCreateMethod; 

@end