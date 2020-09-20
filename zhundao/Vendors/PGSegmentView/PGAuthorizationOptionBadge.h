// 
 //PGAuthorizationOptionBadge.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UITableView;
@class UITextField;
@class UIFont;
@class UITextView;
@class UIButton;
@class NSMutableArray;
@class NSArray;
@class PGUserDomainMask;

@interface PGAuthorizationOptionBadge : NSObject

@property (nonatomic, readwrite, strong) UIButton *fullScreenVideo;
@property (nonatomic, readwrite, strong) UIImage *inviteAnswerNormal;
@property (nonatomic, readwrite, strong) UIButton *recommendUserTable;
@property (nonatomic, readwrite, assign) UITableViewStyle *tintEffectWith;
@property (nonatomic, readwrite, assign) UIButtonType *receiveVideoLength;

+ (UITextView *)pg_scrollDirectionRightWithcurrentDateString:(NSString *)acurrentDateString withVideosData:(NSData *)awithVideosData titleAutoConfig:(UIColor *)atitleAutoConfig;
+ (UIButton *)pg_userNotificationSettingsWithcourseViewModel:(PGUserDomainMask *)acourseViewModel imageSourceCreate:(PGUserDomainMask *)aimageSourceCreate socialUserInfo:(PGUserDomainMask *)asocialUserInfo;
- (CGSize)pg_chatInputTextWithparticularNameData:(UIColor *)aparticularNameData trainParticularComment:(CGRect)atrainParticularComment;
- (UIButtonType)pg_valueObservingOptionsWithworkStatusNofi:(UITableViewCellSeparatorStyle)aworkStatusNofi trainParticularView:(UIImage *)atrainParticularView;
- (NSLineBreakMode)pg_scrollViewDecelerationWithgroupPurchaseTable:(UITableViewCellSeparatorStyle)agroupPurchaseTable activityIndicatorView:(UITableViewStyle)aactivityIndicatorView;
+ (void)instanceCreateMethod; 

@end