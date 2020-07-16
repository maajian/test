//
//  代码地址: https://github.com/Gfengwei/ZDActionSheet.git
//
//  ZDActionSheet.h
//  ZDActionSheet
//
//  Created by guifengwei on 2017/3/21.
//  Copyright © 2017年 Gfengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDActionSheet;

@protocol ZDActionSheetDelegate <NSObject>

- (void)actionSheet:(ZDActionSheet *)actionSheet clickButtonAtIndex:(NSInteger )buttonIndex;

@end

@interface ZDActionSheet : UIView

// 支持代理
@property (nonatomic,weak) id <ZDActionSheetDelegate> delegate;

// 支持block
@property (nonatomic,copy) void (^ClickIndex) (NSInteger index);

//@property (nonatomic,strong)UILabel *titleLabel ;
/**
 根据数组进行文字显示,返回index
 @param titleArr 传入显示的数组
 @param show 是否显示取消按钮
 @return return value description
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArr
                     WithRedIndex :(NSInteger)index
                     andShowCancel:(BOOL )show;

@end
