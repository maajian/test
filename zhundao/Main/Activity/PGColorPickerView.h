//
//  PGColorPickerView.h
//  PGColorPickerView
//
//  Created by Chenly on 16/5/14.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGColorPickerView;

@protocol PGColorPickerViewDataSource <NSObject>

- (NSInteger)lm_numberOfColorsInColorPickerView:(PGColorPickerView *)pickerView;
- (UIColor *)lm_colorPickerView:(PGColorPickerView *)pickerView colorForItemAtIndex:(NSInteger)index;

@end

@protocol PGColorPickerViewDelegate <NSObject>

@optional
- (void)lm_colorPickerView:(PGColorPickerView *)pickerView didSelectIndex:(NSInteger)index;
- (void)lm_colorPickerView:(PGColorPickerView *)pickerView didSelectColor:(UIColor *)color;

@end

@interface PGColorPickerView : UIView

@property (nonatomic, weak) id<PGColorPickerViewDataSource> dataSource;
@property (nonatomic, weak) id<PGColorPickerViewDelegate> delegate;

@property (nonatomic, assign) NSInteger spacingBetweenColors; // default is 20.f

@property (nonatomic, readonly) NSInteger numberOfColors;
@property (nonatomic, readonly) NSInteger selectedIndex;

- (void)reloadData;
- (void)selectIndex:(NSInteger)index;

@end
