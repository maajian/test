//
//  LMWordViewController.h
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMWordView;

@interface LMWordViewController : BaseViewController

@property (nonatomic, strong) LMWordView *textView;
@property(nonatomic,copy)NSArray *imageArray;
- (NSString *)exportHTML;

@end
