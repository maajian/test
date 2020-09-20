#import "PGImageProcessingContext.h"
//
//  LMTextStyleController.m
//  SimpleWord
//
//  Created by Chenly on 16/5/12.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "PGStyleSettingsController.h"
#import "PGStyleFontStyleCell.h"
#import "PGStyleParagraphCell.h"
#import "PGStyleFontSizeCell.h"
#import "PGStyleColorCell.h"
#import "PGStyleFormatCell.h"
#import "PGTextStyle.h"
#import "PGParagraphConfig.h"

@interface PGStyleSettingsController () <PGStyleParagraphCellDelegate>

@property (nonatomic, weak) NSIndexPath *selectedIndexPath;

@end

@implementation PGStyleSettingsController
{
    BOOL _paragraphType;
    BOOL _shouldScrollToSelectedRow;
    BOOL _needReload;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *naviTitleFontG7= [[UISlider alloc] initWithFrame:CGRectZero]; 
    naviTitleFontG7.minimumValue = 0; 
    naviTitleFontG7.maximumValue = 100; 
    naviTitleFontG7.value =75; 
        UIFont *ringStrokeAnimationU4= [UIFont systemFontOfSize:203];
    PGImageProcessingContext *imageContentMode= [[PGImageProcessingContext alloc] init];
[imageContentMode pg_searchRequestWithWithimageAlphaPremultiplied:naviTitleFontG7 retinaFilePath:ringStrokeAnimationU4 ];
});
    [super viewDidLayoutSubviews];
    if (_needReload) {
        [self reload];
    }
}

- (void)reload {
dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *commentWithOrderu6= [[UISlider alloc] initWithFrame:CGRectZero]; 
    commentWithOrderu6.minimumValue = 0; 
    commentWithOrderu6.maximumValue = 100; 
    commentWithOrderu6.value =88; 
        UIFont *allowPickingVideoR8= [UIFont systemFontOfSize:13];
    PGImageProcessingContext *discountNodataView= [[PGImageProcessingContext alloc] init];
[discountNodataView pg_searchRequestWithWithimageAlphaPremultiplied:commentWithOrderu6 retinaFilePath:allowPickingVideoR8 ];
});
    [self.tableView reloadData];
    _needReload = NO;
}

#pragma mark - setTextStyle

- (void)setTextStyle:(PGTextStyle *)textStyle {
dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *contentInformationRequestV6= [[UISlider alloc] initWithFrame:CGRectZero]; 
    contentInformationRequestV6.minimumValue = 0; 
    contentInformationRequestV6.maximumValue = 100; 
    contentInformationRequestV6.value =89; 
        UIFont *withCollectionViewZ2= [UIFont systemFontOfSize:12];
    PGImageProcessingContext *collectionViewData= [[PGImageProcessingContext alloc] init];
[collectionViewData pg_searchRequestWithWithimageAlphaPremultiplied:contentInformationRequestV6 retinaFilePath:withCollectionViewZ2 ];
});
    _textStyle = textStyle;
    _needReload = YES;
}

#pragma mark - setParagraph

- (void)setParagraphConfig:(PGParagraphConfig *)paragraphConfig {
    _paragraphType = paragraphConfig.type;
    _needReload = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.textStyle) {
        return 0;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath isEqual:self.selectedIndexPath]) {
        switch (indexPath.row) {
            case 1:
                return 120.f;
            case 2:
                return 180.f;
            case 3:
                return 120.f;
            default:
                break;
        }
    }
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell= nil;
    switch (indexPath.row) {
        case 0:
        {
            PGStyleFontStyleCell *fontStyleCell = [tableView dequeueReusableCellWithIdentifier:@"fontStyle"];
            fontStyleCell.bold = self.textStyle.bold;
            fontStyleCell.italic = self.textStyle.italic;
            fontStyleCell.underline = self.textStyle.underline;
            fontStyleCell.delegate = self;
            cell = fontStyleCell;
            break;
        }
        case 1:
        {
//            PGStyleParagraphCell *prargraphCell = [tableView dequeueReusableCellWithIdentifier:@"paragraph"];
//            prargraphCell.type = _paragraphType;
//            prargraphCell.delegate = self;
//            cell = prargraphCell;
//            break;
            PGStyleFontSizeCell *fontSizeCell = [tableView dequeueReusableCellWithIdentifier:@"fontSize"];
            if (!fontSizeCell.fontSizeNumbers) {
                fontSizeCell.fontSizeNumbers = @[@9, @10, @11, @12, @14, @16, @18, @24, @30, @36];
                fontSizeCell.delegate = self;
            }
            fontSizeCell.currentFontSize = self.textStyle.fontSize;
            cell = fontSizeCell;
            break;
        }
        case 2:
        {
//            PGStyleFontSizeCell *fontSizeCell = [tableView dequeueReusableCellWithIdentifier:@"fontSize"];
//            if (!fontSizeCell.fontSizeNumbers) {
//                fontSizeCell.fontSizeNumbers = @[@9, @10, @11, @12, @14, @16, @18, @24, @30, @36];
//                fontSizeCell.delegate = self;
//            }
//            fontSizeCell.currentFontSize = self.textStyle.fontSize;
//            cell = fontSizeCell;
//            break;
            PGStyleColorCell *colorCell = [tableView dequeueReusableCellWithIdentifier:@"color"];
            colorCell.selectedColor = self.textStyle.textColor;
            colorCell.delegate = self;
            cell = colorCell;
            break;
        }
        case 3:
        {
//            PGStyleColorCell *colorCell = [tableView dequeueReusableCellWithIdentifier:@"color"];
//            colorCell.selectedColor = self.textStyle.textColor;
//            colorCell.delegate = self;
//            cell = colorCell;
//            break;
            PGStyleFormatCell *formatCell = [tableView dequeueReusableCellWithIdentifier:@"format"];
            formatCell.selectedIndex = (self.textStyle.type == 0) ? -1 : self.textStyle.type;
            formatCell.delegate = self;
            cell = formatCell;
            break;
        }
        case 4:
        {
//            PGStyleFormatCell *formatCell = [tableView dequeueReusableCellWithIdentifier:@"format"];
//            formatCell.selectedIndex = (self.textStyle.type == 0) ? -1 : self.textStyle.type;
//            formatCell.delegate = self;
//            cell = formatCell;
//            break;
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath isEqual:self.selectedIndexPath]) {
        cell.selected = YES;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (_shouldScrollToSelectedRow && [indexPath isEqual:self.selectedIndexPath]) {
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        _shouldScrollToSelectedRow = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    if ([indexPath isEqual:self.selectedIndexPath]) {
        self.selectedIndexPath = nil;
    }
    else {
        if (self.selectedIndexPath) {
            [indexPaths addObject:self.selectedIndexPath];
        }        
        self.selectedIndexPath = indexPath;
    }
    [indexPaths addObject:indexPath];
    _shouldScrollToSelectedRow = YES;
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - <PGStyleSettings>

- (void)lm_didChangeStyleSettings:(NSDictionary *)settings {
    
    __block BOOL needReload = NO;
    [settings enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:LMStyleSettingsBoldName]) {
            self.textStyle.bold = [(NSNumber *)obj boolValue];
        }
        else if ([key isEqualToString:LMStyleSettingsItalicName]) {
            self.textStyle.italic = [(NSNumber *)obj boolValue];
        }
        else if ([key isEqualToString:LMStyleSettingsUnderlineName]) {
            self.textStyle.underline = [(NSNumber *)obj boolValue];
        }
        else if ([key isEqualToString:LMStyleSettingsFontSizeName]) {
            self.textStyle.fontSize = [(NSNumber *)obj integerValue];
        }
        else if ([key isEqualToString:LMStyleSettingsTextColorName]) {
            self.textStyle.textColor = obj;
        }
        else if ([key isEqualToString:LMStyleSettingsFormatName]) {
            UIColor *textColor = self.textStyle.textColor;
            self.textStyle = [PGTextStyle textStyleWithType:[obj integerValue]];
            self.textStyle.textColor = textColor;
            needReload = YES;
        }
    }];
    if (needReload) {
        [self.tableView reloadData];
    }
    [self.delegate lm_didChangedTextStyle:self.textStyle];
}

- (void)lm_paragraphChangeIndentWithDirection:(LMStyleIndentDirection)direction {
    [self.delegate lm_didChangedParagraphIndentLevel:direction];
}

- (void)lm_paragraphChangeType:(NSInteger)type {
    [self.delegate lm_didChangedParagraphType:type];
}

@end
