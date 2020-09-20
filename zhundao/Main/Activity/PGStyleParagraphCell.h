//
//  PGStyleParagraphCell.h
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGStyleSettings.h"

typedef NS_ENUM(NSUInteger, LMStyleIndentDirection) {
    LMStyleIndentDirectionLeft = -1,
    LMStyleIndentDirectionRight = 1,
};

@protocol PGStyleParagraphCellDelegate <PGStyleSettings>

- (void)lm_paragraphChangeIndentWithDirection:(LMStyleIndentDirection)direction;
- (void)lm_paragraphChangeType:(NSInteger)type;

@end

@interface PGStyleParagraphCell : UITableViewCell

@property (nonatomic, readonly) BOOL isList;
@property (nonatomic, readonly) BOOL isNumberList;
@property (nonatomic, readonly) BOOL isCheckbox;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, weak) id<PGStyleParagraphCellDelegate> delegate;

@end
