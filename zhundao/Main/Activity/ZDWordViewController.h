//
//  ZDWordViewController.h
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDWordView;

@interface ZDWordViewController : ZDBaseVC

@property (nonatomic, strong) ZDWordView *textView;
@property(nonatomic,copy)NSArray *imageArray;
- (NSString *)exportHTML;

@end
