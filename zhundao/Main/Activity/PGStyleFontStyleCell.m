#import "PGSelectorFromString.h"
//
//  PGStyleFontStyleCell.m
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "PGStyleFontStyleCell.h"

@interface PGStyleFontStyleCell ()

@property (weak, nonatomic) IBOutlet UIButton *boldButton;
@property (weak, nonatomic) IBOutlet UIButton *italicButton;
@property (weak, nonatomic) IBOutlet UIButton *underLineButton;

@end

@implementation PGStyleFontStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIButton *button in @[_boldButton, _italicButton, _underLineButton]) {
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)buttonAction:(UIButton *)button {
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment networkStatusReachableviaw9 = NSTextAlignmentCenter; 
        UIScrollView *reusableCellWithk1= [[UIScrollView alloc] initWithFrame:CGRectZero]; 
    reusableCellWithk1.showsHorizontalScrollIndicator = NO; 
    reusableCellWithk1.showsVerticalScrollIndicator = NO; 
    reusableCellWithk1.bounces = NO; 
    reusableCellWithk1.maximumZoomScale = 5; 
    reusableCellWithk1.minimumZoomScale = 1; 
    PGSelectorFromString *tintEffectWith= [[PGSelectorFromString alloc] init];
[tintEffectWith pg_lineHeadIndentWithlikeTweetSucc:networkStatusReachableviaw9 playerBeginInterruption:reusableCellWithk1 ];
});
    button.selected = !button.selected;
    
    NSDictionary *settings;
    if (button == self.boldButton) settings = @{ LMStyleSettingsBoldName: @(self.bold) };
    if (button == self.italicButton) settings = @{ LMStyleSettingsItalicName: @(self.italic) };
    if (button == self.underLineButton) settings = @{ LMStyleSettingsUnderlineName: @(self.underline) };
    [self.delegate lm_didChangeStyleSettings:settings];
}

- (void)setBold:(BOOL)bold {
    self.boldButton.selected = bold;
}

- (BOOL)bold {
    return self.boldButton.selected;
}

- (void)setItalic:(BOOL)italic {
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment tweetPhotoModelx5 = NSTextAlignmentCenter; 
        UIScrollView *fileTypeQuickH5= [[UIScrollView alloc] initWithFrame:CGRectZero]; 
    fileTypeQuickH5.showsHorizontalScrollIndicator = NO; 
    fileTypeQuickH5.showsVerticalScrollIndicator = NO; 
    fileTypeQuickH5.bounces = NO; 
    fileTypeQuickH5.maximumZoomScale = 5; 
    fileTypeQuickH5.minimumZoomScale = 1; 
    PGSelectorFromString *finishPickingVideo= [[PGSelectorFromString alloc] init];
[finishPickingVideo pg_lineHeadIndentWithlikeTweetSucc:tweetPhotoModelx5 playerBeginInterruption:fileTypeQuickH5 ];
});
    self.italicButton.selected = italic;
}

- (BOOL)italic {
    return self.italicButton.selected;
}

- (void)setUnderline:(BOOL)underline {
    self.underLineButton.selected = underline;
}

- (BOOL)underline {
    return self.underLineButton.selected;
}

@end
