//
//  LMTextStyleController.h
//  SimpleWord
//
//  Created by Chenly on 16/5/12.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGTextStyle;
@class PGParagraphConfig;

@protocol PGStyleSettingsControllerDelegate <NSObject>

- (void)lm_didChangedTextStyle:(PGTextStyle *)textStyle;
- (void)lm_didChangedParagraphIndentLevel:(NSInteger)level;
- (void)lm_didChangedParagraphType:(NSInteger)type;

@end

@interface PGStyleSettingsController : UITableViewController

@property (nonatomic, weak) id<PGStyleSettingsControllerDelegate> delegate;
@property (nonatomic, strong) PGTextStyle *textStyle;

- (void)reload;
- (void)setParagraphConfig:(PGParagraphConfig *)paragraphConfig;

@end
