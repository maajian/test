//
//  PGFontSizePickerView.h
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGFontSizePickerView;

@protocol LMFontSizePickerViewDataSource <NSObject>

- (NSInteger)lm_numberOfItemsInPickerView:(PGFontSizePickerView *)pickerView;
- (NSString *)lm_pickerView:(PGFontSizePickerView *)pickerView titleForItemAtIndex:(NSInteger)index;

@end

@protocol PGFontSizePickerViewDelegate <NSObject>

@optional
- (void)lm_pickerView:(PGFontSizePickerView *)pickerView didSelectIndex:(NSInteger)index;

@end

@interface PGFontSizePickerView : UIView

@property (nonatomic, weak) id<LMFontSizePickerViewDataSource> dataSource;
@property (nonatomic, weak) id<PGFontSizePickerViewDelegate> delegate;

@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIFont *selectedFont;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, readonly) NSInteger numberOfItems;
@property (nonatomic, readonly) NSInteger selectedIndex;

- (void)reloadData;

- (void)selectIndex:(NSInteger)index animated:(BOOL)animated;

@end
