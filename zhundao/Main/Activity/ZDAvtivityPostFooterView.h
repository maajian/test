//
//  ZDAvtivityPostFooterView.h
//  zhundao
//
//  Created by zhundao on 2017/9/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDAvtivityFooterDelegate <NSObject>

- (void)pushToXieyi;

- (void)post;

@end

@interface ZDAvtivityPostFooterView : UIView

@property(nonatomic,weak) id<ZDAvtivityFooterDelegate> footerDelegate;

@end
