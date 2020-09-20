//
//  LMStyleFontCell.h
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDStyleSettings.h"

@interface ZDStyleFontSizeCell : UITableViewCell

@property (nonatomic, weak) id<ZDStyleSettings> delegate;

@property (nonatomic, copy) NSArray<NSNumber *> *fontSizeNumbers;
@property (nonatomic, assign) NSInteger currentFontSize;

@end
