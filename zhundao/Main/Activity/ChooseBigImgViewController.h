//
//  ChooseBigImgViewController.h
//  zhundao
//
//  Created by zhundao on 2017/10/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"

@protocol ChooseBigImgDelegate<NSObject>

- (void)ChooseImgStr:(NSString *)urlStr isPost :(BOOL)isPostImg indexPath :(NSIndexPath *)indexPath;

@end

@interface ChooseBigImgViewController : ZDBaseVC

@property(nonatomic,copy)NSArray *imageArray;
/*!  选择的图片路径 */
@property(nonatomic,strong)NSString *selectUrl;
/*! 第几个item */
@property(nonatomic,assign)NSInteger currentItem;
/*! 哪个view */
@property(nonatomic,assign)NSInteger collectIndex;

@property(nonatomic,weak) id <ChooseBigImgDelegate>  ChooseBigImgDelegate;

@end
