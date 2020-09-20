//
//  ZDFontSizePickerView.h
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDFontSizePickerView;

@protocol LMFontSizePickerViewDataSource <NSObject>

- (NSInteger)lm_numberOfItemsInPickerView:(ZDFontSizePickerView *)pickerView;
- (NSString *)lm_pickerView:(ZDFontSizePickerView *)pickerView titleForItemAtIndex:(NSInteger)index;

@end

@protocol ZDFontSizePickerViewDelegate <NSObject>

@optional
- (void)lm_pickerView:(ZDFontSizePickerView *)pickerView didSelectIndex:(NSInteger)index;

@end

@interface ZDFontSizePickerView : UIView

@property (nonatomic, weak) id<LMFontSizePickerViewDataSource> dataSource;
@property (nonatomic, weak) id<ZDFontSizePickerViewDelegate> delegate;

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
