//
//  ZDPhotoCollectionCell.m
//  SimpleWord
//
//  Created by Chenly on 16/5/16.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "ZDPhotoCollectionCell.h"

@interface ZDPhotoCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation ZDPhotoCollectionCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.selectedImageView.hidden = !selected;
}

@end
