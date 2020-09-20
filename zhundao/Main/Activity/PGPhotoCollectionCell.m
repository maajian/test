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
    [super setSelected:selected];
    self.selectedImageView.hidden = !selected;
}

@end
