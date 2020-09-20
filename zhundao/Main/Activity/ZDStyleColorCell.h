//
//  ZDStyleColorCell.h
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDStyleSettings.h"

@interface ZDStyleColorCell : UITableViewCell

@property (nonatomic, weak) id<ZDStyleSettings> delegate;

@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, copy) NSArray *colors;

@end
