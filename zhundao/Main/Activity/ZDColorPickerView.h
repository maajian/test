//
//  ZDColorPickerView.h
//  ZDColorPickerView
//
//  Created by Chenly on 16/5/14.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDColorPickerView;

@protocol ZDColorPickerViewDataSource <NSObject>

- (NSInteger)lm_numberOfColorsInColorPickerView:(ZDColorPickerView *)pickerView;
- (UIColor *)lm_colorPickerView:(ZDColorPickerView *)pickerView colorForItemAtIndex:(NSInteger)index;

@end

@protocol ZDColorPickerViewDelegate <NSObject>

@optional
- (void)lm_colorPickerView:(ZDColorPickerView *)pickerView didSelectIndex:(NSInteger)index;
- (void)lm_colorPickerView:(ZDColorPickerView *)pickerView didSelectColor:(UIColor *)color;

@end

@interface ZDColorPickerView : UIView

@property (nonatomic, weak) id<ZDColorPickerViewDataSource> dataSource;
@property (nonatomic, weak) id<ZDColorPickerViewDelegate> delegate;

@property (nonatomic, assign) NSInteger spacingBetweenColors; // default is 20.f

@property (nonatomic, readonly) NSInteger numberOfColors;
@property (nonatomic, readonly) NSInteger selectedIndex;

- (void)reloadData;
- (void)selectIndex:(NSInteger)index;

@end
