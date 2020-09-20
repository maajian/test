#import "PGDailyTrainView.h"
//
//  PGPhotoCollectionCell.m
//  SimpleWord
//
//  Created by Chenly on 16/5/16.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "PGPhotoCollectionCell.h"

@interface PGPhotoCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation PGPhotoCollectionCell

- (void)setSelected:(BOOL)selected {
dispatch_async(dispatch_get_main_queue(), ^{
    UILabel *fontAttributeNamej4= [[UILabel alloc] initWithFrame:CGRectZero]; 
    fontAttributeNamej4.text = @"animationRightTick";
    fontAttributeNamej4.textColor = [UIColor whiteColor]; 
    fontAttributeNamej4.font = [UIFont systemFontOfSize:211];
    fontAttributeNamej4.numberOfLines = 0; 
    fontAttributeNamej4.textAlignment = NSTextAlignmentCenter; 
        UIEdgeInsets succViewControllerZ7 = UIEdgeInsetsZero;
    PGDailyTrainView *styleLightContent= [[PGDailyTrainView alloc] init];
[styleLightContent imageContentModeWithplayImageView:fontAttributeNamej4 dailyTrainChapter:succViewControllerZ7 ];
});
    [super setSelected:selected];
    self.selectedImageView.hidden = !selected;
}

@end
