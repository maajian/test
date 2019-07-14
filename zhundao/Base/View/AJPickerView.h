//
//  AJPickerView.h
//  AJPickerView
//
//  Created by zhundao on 2017/6/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backBlock)(NSString  *str);


@interface AJPickerView : UIView
@property(nonatomic,copy)backBlock backBlock;
- (instancetype)initWithFrame:(CGRect)frame
                   dataArray : (NSArray *)dataArray
                  currentStr :(NSString *)str
                   backBlock :(backBlock)selectBlock ;

- (void)fadeIn; 
@end
