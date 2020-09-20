//
//  LMTextStyleController.h
//  SimpleWord
//
//  Created by Chenly on 16/5/12.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDTextStyle;
@class ZDParagraphConfig;

@protocol ZDStyleSettingsControllerDelegate <NSObject>

- (void)lm_didChangedTextStyle:(ZDTextStyle *)textStyle;
- (void)lm_didChangedParagraphIndentLevel:(NSInteger)level;
- (void)lm_didChangedParagraphType:(NSInteger)type;

@end

@interface ZDStyleSettingsController : UITableViewController

@property (nonatomic, weak) id<ZDStyleSettingsControllerDelegate> delegate;
@property (nonatomic, strong) ZDTextStyle *textStyle;

- (void)reload;
- (void)setParagraphConfig:(ZDParagraphConfig *)paragraphConfig;

@end
