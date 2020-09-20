// 
 //PGOrganizeListView.h
 //  Meari 
// 
//  Created by maj on2020/9/21. 
//  Copyright © 2019 Meari. All rights reserved. 
 // 
@import UIKit;

@class UIFont;
@class NSArray;
@class UILabel;
@class UIScrollView;
@class PGUpdateUserLocation;

@interface PGOrganizeListView : NSObject

@property (nonatomic, readwrite, strong) UITableView *mutableUserNotification;
@property (nonatomic, readwrite, strong) NSString *ringStrokeAnimation;
@property (nonatomic, readwrite, strong) UILabel *videoSendIcon;
@property (nonatomic, readwrite, assign) NSTextAlignment *routeSearchDone;
@property (nonatomic, readwrite, assign) CGSize *assetsGroupProperty;

+ (NSData *)pg_statusBackgroundColorWithrecordMovieModel:(UITableView *)arecordMovieModel recommendUserTable:(UIImageView *)arecommendUserTable imageProgressUpdate:(UIImage *)aimageProgressUpdate;
+ (UIView *)pg_trainWithOffsetWithrecommendCourseHeight:(PGUpdateUserLocation *)arecommendCourseHeight playChapterIndex:(PGUpdateUserLocation *)aplayChapterIndex finishLoadWith:(PGUpdateUserLocation *)afinishLoadWith;
- (CGPoint)pg_deviceSettingsTypeWithlaunchViewController:(UIImageView *)alaunchViewController deepBlackColor:(UITableView *)adeepBlackColor;
- (UITableViewCellSeparatorStyle)pg_withStrokeCourseWithsliderFillColor:(UIColor *)asliderFillColor ringRotationAnimation:(UITextFieldViewMode)aringRotationAnimation;
- (CGSize)pg_hideControlViewWithdefaultImageName:(UITextFieldViewMode)adefaultImageName dataElseLoad:(NSString *)adataElseLoad;
+ (void)instanceCreateMethod; 

@end