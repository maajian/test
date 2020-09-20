//
//  ZDMeAllAccountViewController.h
//  zhundao
//
//  Created by zhundao on 2017/9/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDBaseVC.h"

@protocol AllAccountDelegate <NSObject>

- (void)post:(NSString *)account BankName :(NSString *)BankName ID :(NSInteger)ID;

@end

@interface ZDMeAllAccountViewController : ZDBaseVC

@property(nonatomic,weak) id<AllAccountDelegate> AllAccountDelegate;

@end
