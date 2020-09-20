//
//  PGStyleColorCell.m
//  SimpleWord
//
//  Created by Chenly on 16/5/13.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "PGStyleColorCell.h"
#import "PGColorPickerView.h"

@interface PGStyleColorCell () <PGColorPickerViewDataSource, PGColorPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *colorDisplayView;
@property (weak, nonatomic) IBOutlet PGColorPickerView *colorPickerView;

@end

@implementation PGStyleColorCell
{
    CAShapeLayer *_lineLayer;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!_lineLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineDashPattern = @[@5, @2];
        shapeLayer.lineWidth = 1.f;
        _lineLayer = shapeLayer;
        [self.layer addSublayer:_lineLayer];
    }
    
    _colors = @[
                [UIColor blackColor],
                [UIColor colorWithRed:1/255.f green:122/255.f blue:171/255.f alpha:1],
                [UIColor colorWithRed:137/255.f green:137/255.f blue:137/255.f alpha:1],
                [UIColor colorWithRed:255/255.f green:25/255.f blue:5/255.f alpha:1],
                [UIColor colorWithRed:1/255.f green:209/255.f blue:0/255.f alpha:1],
                [UIColor colorWithRed:255/255.f green:169/255.f blue:1/255.f alpha:1],
                [UIColor colorWithRed:255/255.f green:173/255.f blue:213/255.f alpha:1],
                [UIColor colorWithRed:251/255.f green:251/255.f blue:0/255.f alpha:1],
                [UIColor colorWithRed:0/255.f green:253/255.f blue:253/255.f alpha:1],
                [UIColor colorWithRed:163/255.f green:125/255.f blue:207/255.f alpha:1],
                [UIColor colorWithRed:164/255.f green:195/255.f blue:108/255.f alpha:1],
                [UIColor colorWithRed:244/255.f green:169/255.f blue:135/255.f alpha:1],
                ];
    
    self.colorPickerView.dataSource = self;
    self.colorPickerView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.colorPickerView.hidden = !selected;
    _lineLayer.hidden = !selected;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (!self.selected) {
        return;
    }
    
    CGRect layerFrame = rect;
    layerFrame.origin.x = 20.f;
    layerFrame.origin.y = 60.f;
    layerFrame.size.width -= 20.f * 2;
    layerFrame.size.height = 1.f;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0.5f)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(layerFrame), 0.5f)];
    _lineLayer.path = path.CGPath;
    _lineLayer.frame = layerFrame;
}

- (void)setColors:(NSArray *)colors {
    _colors = [colors copy];    
    [self.colorPickerView reloadData];
}

#pragma mark - set Color

- (void)setSelectedColor:(UIColor *)selectedColor {
    if (self.colors.count == 0) {
        return;
    }
    [self.colors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:selectedColor]) {
            _selectedColor = selectedColor;
            self.colorDisplayView.backgroundColor = selectedColor;
            [self.colorPickerView selectIndex:idx];
            *stop = YES;
        }
    }];
}

#pragma mark - <PGColorPickerViewDataSource, PGColorPickerViewDelegate>

- (NSInteger)lm_numberOfColorsInColorPickerView:(PGColorPickerView *)pickerView {
    return self.colors.count;
}

- (UIColor *)lm_colorPickerView:(PGColorPickerView *)pickerView colorForItemAtIndex:(NSInteger)index {
    return self.colors[index];
}

- (void)lm_colorPickerView:(PGColorPickerView *)pickerView didSelectColor:(UIColor *)color {
    self.colorDisplayView.backgroundColor = color;
    [self.delegate lm_didChangeStyleSettings:@{LMStyleSettingsTextColorName: color}];
}

@end
