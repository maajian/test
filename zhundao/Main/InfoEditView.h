//
//  InfoEditView.h
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InfoEditViewDelegate<NSObject>
 // 返回
- (void)backPop;
 // 完成内容编辑
- (void)finishEditWithName:(NSString *)name passWord:(NSString *)passWord;

@end

@interface InfoEditView : UIView
 // 初始化 
- (instancetype)initWithFrame:(CGRect)frame phoneStr:(NSString *)phoneStr;
 // 代理
@property (nonatomic, weak) id<InfoEditViewDelegate> infoEditViewDelegate;

@end
