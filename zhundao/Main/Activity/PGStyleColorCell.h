//
//  PGStyleColorCell.h
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGStyleSettings.h"

@interface PGStyleColorCell : UITableViewCell

@property (nonatomic, weak) id<PGStyleSettings> delegate;

@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, copy) NSArray *colors;

@end
