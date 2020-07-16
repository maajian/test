//
//  ChangeInfoViewController.h
//  zhundao
//
//  Created by zhundao on 2017/11/1.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"

typedef void(^infoBlock)(NSString *str);

@interface ChangeInfoViewController : ZDBaseVC
/*! 传入的字符串 */
@property(nonatomic,strong)NSString *oriStr;
/*! 第几个cell点击进来 */
@property(nonatomic,assign)NSInteger cellTag;


@property(nonatomic,copy)infoBlock infoBlock;

@end
