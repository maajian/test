//
//  PGActivityMoreLabelVC.h
//  zhundao
//
//  Created by zhundao on 2017/6/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^strBlock) (NSString *backStr);
@interface PGActivityMoreLabelVC : PGBaseVC
@property(nonatomic,copy)strBlock strBlock;
@property(nonatomic,assign)BOOL isMust;
@property(nonatomic,strong)NSString *textfTitle;
@property(nonatomic,assign)BOOL isADMark;
@end
