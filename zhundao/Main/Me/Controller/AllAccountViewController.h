//
//  AllAccountViewController.h
//  zhundao
//
//  Created by zhundao on 2017/9/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"

@protocol AllAccountDelegate <NSObject>

- (void)post:(NSString *)account BankName :(NSString *)BankName ID :(NSInteger)ID;

@end

@interface AllAccountViewController : BaseViewController

@property(nonatomic,weak) id<AllAccountDelegate> AllAccountDelegate;

@end
