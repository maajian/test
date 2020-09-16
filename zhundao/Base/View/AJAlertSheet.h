//
//  AJAlertSheet.h
//  AJAlertSheet
//
//  Created by zhundao on 2017/6/28.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^backBlock) (NSInteger index);
@interface AJAlertSheet : UIView

@property(nonatomic,copy)backBlock backBlock;

+ (void)showWithArray :(NSArray *)dataArray
   title :(NSString *)title
isDelete :(BOOL)isDelete
          selectBlock :(backBlock)selectBlock;

- (void)fadeIn;
- (instancetype)initWithFrame:(CGRect)frame
                       array :(NSArray *)dataArray
                       title :(NSString *)title
                    isDelete :(BOOL)isDelete
                 selectBlock :(backBlock)selectBlock;

@end
