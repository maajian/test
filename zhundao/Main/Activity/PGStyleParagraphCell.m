#import "PGDeviceOrientationFace.h"
//
//  PGStyleParagraphCell.m
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "PGStyleParagraphCell.h"

@interface PGStyleParagraphCell ()

@property (weak, nonatomic) IBOutlet UIButton *listButton;
@property (weak, nonatomic) IBOutlet UIButton *numberListButton;
@property (weak, nonatomic) IBOutlet UIButton *checkboxButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation PGStyleParagraphCell

- (void)awakeFromNib {
dispatch_async(dispatch_get_main_queue(), ^{
    CGSize locationWithSuccessp3 = CGSizeZero;
        UIImageView * failLoadWithU3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    failLoadWithU3.contentMode = UIViewContentModeCenter; 
    failLoadWithU3.clipsToBounds = NO; 
    failLoadWithU3.multipleTouchEnabled = YES; 
    failLoadWithU3.autoresizesSubviews = YES; 
    failLoadWithU3.clearsContextBeforeDrawing = YES; 
    PGDeviceOrientationFace *natatoriumListData= [[PGDeviceOrientationFace alloc] init];
[natatoriumListData pg_pushNotificationTriggerWithaffineTransformIdentity:locationWithSuccessp3 modelWithAsset:failLoadWithU3 ];
});
    [super awakeFromNib];
    
    for (UIButton *button in @[_listButton, _numberListButton, _checkboxButton, _leftButton, _rightButton]) {
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setType:(NSInteger)type {
dispatch_async(dispatch_get_main_queue(), ^{
    CGSize updateStatuMandatoryR2 = CGSizeZero;
        UIImageView * audioSessionCategoryN5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    audioSessionCategoryN5.contentMode = UIViewContentModeCenter; 
    audioSessionCategoryN5.clipsToBounds = NO; 
    audioSessionCategoryN5.multipleTouchEnabled = YES; 
    audioSessionCategoryN5.autoresizesSubviews = YES; 
    audioSessionCategoryN5.clearsContextBeforeDrawing = YES; 
    PGDeviceOrientationFace *loginWithPerson= [[PGDeviceOrientationFace alloc] init];
[loginWithPerson pg_pushNotificationTriggerWithaffineTransformIdentity:updateStatuMandatoryR2 modelWithAsset:audioSessionCategoryN5 ];
});
    self.listButton.selected = type == 1;
    self.numberListButton.selected = type == 2;
    self.checkboxButton.selected = type == 3;
}

- (NSInteger)type {
    if (self.listButton.selected) {
        return 1;
    }
    else if (self.numberListButton.selected) {
        return 2;
    }
    else if (self.checkboxButton.selected) {
        return 3;
    }
    return 0;
}

- (BOOL)isList {
    return self.listButton.selected;
}

- (BOOL)isNumberList {
    return self.numberListButton.selected;
}

- (BOOL)isCheckBox {
    return self.checkboxButton.selected;
}

- (void)buttonAction:(UIButton *)sender {
    
    if (sender == self.leftButton) {
        [self.delegate lm_paragraphChangeIndentWithDirection:LMStyleIndentDirectionLeft];
    }
    else if (sender == self.rightButton) {
        [self.delegate lm_paragraphChangeIndentWithDirection:LMStyleIndentDirectionRight];
    }
    else {
        __block NSInteger type = 0;
        NSArray *buttons = @[self.listButton, self.numberListButton, self.checkboxButton];
        [buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            if (sender == button) {
                button.selected = !button.selected;
                if (button.selected) {
                    type = [@[self.listButton, self.numberListButton, self.checkboxButton] indexOfObject:button] + 1;
                }
                else {
                    type = 0;
                }
            }
            else {
                button.selected = NO;
            }
        }];
        [self.delegate lm_paragraphChangeType:type];
    }
}

@end
