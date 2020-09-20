//
//  PGPickerView.h
//  PGPickerView
//
//  Created by zhundao on 2017/6/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backPickerBlock)(NSString  *str);


@interface PGPickerView : UIView
@property(nonatomic,copy)backPickerBlock backBlock;
- (instancetype)initWithFrame:(CGRect)frame
                   dataArray : (NSArray *)dataArray
                  currentStr :(NSString *)str
                   backBlock :(backPickerBlock)selectBlock ;

- (void)fadeIn; 
@end
