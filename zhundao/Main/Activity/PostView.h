//
//  PostView.h
//  zhundao
//
//  Created by zhundao on 2017/9/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol postDelegate <NSObject>
/*! 跳转协议 */
- (void)pushXieYi;
/*! 发起活动 */
- (void)isCanPost:(NSString *)bigImage;
/*! 跳转编辑费用相 */
- (void)pushFee;
/*! 跳转编辑详情 */
- (void)pushEdit;
/*! 跳转编辑更多 */
- (void)pushMoreChoose;
/*! 跳转定位 */
- (void)pushLocation;
/*! 改图片 */
- (void)changeBigImage:(NSArray *)imageArray;

@end

@interface PostView : UIView

@property(nonatomic,weak) id<postDelegate>  postDelegate;

- (instancetype)initWithModel :(ActivityModel *)activityModel;

/*! 公开的属性 */
/*! 表视图 */
@property(nonatomic,strong)UITableView                        *tableview ;
/*! 费用 */
@property(nonatomic,strong)      UILabel *activityFeeRightLabel;
/*! 地点 */
@property(nonatomic,strong)      UITextField *activityPlaceTextField;
/*! 活动详情 */
@property(nonatomic,strong)       UIWebView *textview;
/*! 活动开始时间 */
@property(nonatomic,strong)      UILabel *beginTimeRightLabel;
/*! 报名截止时间 */
@property(nonatomic,strong)      UILabel *stopTimeRightLabel;
/*! 活动结束时间 */
@property(nonatomic,strong)      UILabel *endTimeRightLabel;
/*! 报名开始时间 */
@property(nonatomic,strong)      UILabel *startTimeRightLabel;
/*! 活动名称 */
@property(nonatomic,strong)      UITextField *activityTitleTextField;
/*! 活动人数 */
@property(nonatomic,strong)      UITextField *activityNumbertField;
@property(nonatomic,copy)NSAttributedString *textStr ;  //编辑器字符串
@property(nonatomic,copy)NSString *htmlStr ; //编辑器html字符串
@property(nonatomic,copy)       NSString *bigImageStr; //大图字符串
@property(nonatomic,strong)      NSArray<NSDictionary *> *feeArray; //费用数组
@end
