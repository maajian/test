#import "PGNotificationPresentationOption.h"
//
//  PGAvtivitySignUpView.m
//  zhundao
//
//  Created by xhkj on 2018/4/24.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGAvtivitySignUpView.h"

#import "AAChartKit.h"
#import "PGAvtivitySignUpModel.h"

@interface PGAvtivitySignUpView() {
    NSArray *_xLabels;
    NSMutableArray *_dataArray;
    NSString *_title;
}
/*! 付款人数数组 */
@property (nonatomic, strong) NSMutableArray *personArray;
/*! 项目收入 */
@property (nonatomic, strong) NSMutableArray *comeInArray;

@end

@implementation PGAvtivitySignUpView

- (instancetype)initWithFrame:(CGRect)frame xLabels:(NSArray *)xLabels dataArray:(NSArray *)dataArray title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        _xLabels = [xLabels copy];
        _dataArray = [NSMutableArray array];
        _title = title;
        
        for (NSString *str in dataArray) {
            [_dataArray addObject:@([str integerValue])];
        }
        [self setupLineUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame personArray:(NSArray *)personArray comeInArray:(NSArray *)comeInArray{
    if (self = [super initWithFrame:frame]) {
        _personArray = [personArray copy];
        _dataArray = [NSMutableArray array];
        
        for (PGAvtivitySignUpModel *model in comeInArray) {
            [_dataArray addObject:@[model.title, [NSNumber numberWithFloat:model.amount]]];
        }
        [self setupPieUI];
    }
    return self;
}

#pragma mark --- 添加折线图

- (void)setupLineUI {
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *collectionOriginalModelr4= [[UISwitch alloc] initWithFrame:CGRectMake(2,61,116,24)]; 
    collectionOriginalModelr4.on = YES; 
    collectionOriginalModelr4.onTintColor = [UIColor whiteColor]; 
        UIImageView * recommendCellDelegateC0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    recommendCellDelegateC0.contentMode = UIViewContentModeCenter; 
    recommendCellDelegateC0.clipsToBounds = NO; 
    recommendCellDelegateC0.multipleTouchEnabled = YES; 
    recommendCellDelegateC0.autoresizesSubviews = YES; 
    recommendCellDelegateC0.clearsContextBeforeDrawing = YES; 
    PGNotificationPresentationOption *collectionViewCell= [[PGNotificationPresentationOption alloc] init];
[collectionViewCell recordVideoCameraWithobjectsUsingBlock:collectionOriginalModelr4 trainViewModel:recommendCellDelegateC0 ];
});
    AAChartView *chartView = [[AAChartView alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth - 20, self.frame.size.height - 40)];
    chartView.scrollEnabled = YES;
    [self addSubview:chartView];
    
    AAChartModel *chartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)
    .titleSet(@"")
    .yAxisMinSet(@(0))
    .zoomTypeSet(AAChartZoomTypeX)
    .subtitleSet(@"")
    .categoriesSet(_xLabels)
    .yAxisTitleSet(@"")
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(_title)
                 .dataSet(_dataArray),
                 ]
               );
    [chartView aa_drawChartWithChartModel:chartModel];
}

#pragma mark --- 添加饼图
- (void)setupPieUI {
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *userInfoHeaderN6= [[UISwitch alloc] initWithFrame:CGRectZero]; 
    userInfoHeaderN6.on = YES; 
    userInfoHeaderN6.onTintColor = [UIColor whiteColor]; 
        UIImageView * changePreviousRouteL5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    changePreviousRouteL5.contentMode = UIViewContentModeCenter; 
    changePreviousRouteL5.clipsToBounds = NO; 
    changePreviousRouteL5.multipleTouchEnabled = YES; 
    changePreviousRouteL5.autoresizesSubviews = YES; 
    changePreviousRouteL5.clearsContextBeforeDrawing = YES; 
    PGNotificationPresentationOption *coachDetailModel= [[PGNotificationPresentationOption alloc] init];
[coachDetailModel recordVideoCameraWithobjectsUsingBlock:userInfoHeaderN6 trainViewModel:changePreviousRouteL5 ];
});
    /*! 付款人数 */
    AAChartView *payChartView = [[AAChartView alloc] initWithFrame:CGRectMake(10, self.frame.size.height/2 , kScreenWidth - 20, (self.frame.size.height - 40)/2)];
    payChartView.scrollEnabled = NO;
    [self addSubview:payChartView];
    
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypePie)
    .colorsThemeSet(@[@"#0c9674",@"#999999"])
    .titleSet(@"")
    .subtitleSet(@"")
    .yAxisTitleSet(@"摄氏度")
    .seriesSet(
               @[
                 AAObject(AASeriesElement)
                 .nameSet(@"人数")
                 .innerSizeSet(@"20%")//内部圆环半径大小占比
                 .allowPointSelectSet(false)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
                 .dataLabelsSet(AAObject(AADataLabels)
                                .enabledSet(true)
                                .formatSet(@"<b>{point.y}</b>"))
                 .dataSet(_personArray),]);
    aaChartModel.dataLabelsEnabled = YES;
    [payChartView aa_drawChartWithChartModel:aaChartModel];
    
    /*! 收入 */
    AAChartView *comeInChartView = [[AAChartView alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth - 20, (self.frame.size.height - 40)/2)];
    comeInChartView.scrollEnabled = NO;
    [self addSubview:comeInChartView];
    
    AAChartModel *comeInModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypePie)
    .colorsThemeSet(@[@"#0c9674",@"#7dffc0",@"#d11b5f",@"#facd32",@"#ffffa0",@"#EA007B",@"#49C1B6", @"#FDC20A", @"#F78320", @"#068E81", @"#EA007B"])
    .titleSet(@"")
    .subtitleSet(@"")
    .yAxisTitleSet(@"摄氏度")
    .seriesSet(
               @[
                 AAObject(AASeriesElement)
                 .nameSet(@"收入")
                 .innerSizeSet(@"20%")//内部圆环半径大小占比
                 .dataLabelsSet(AAObject(AADataLabels)
                                .enabledSet(true)
                                .formatSet(@"<b>{point.y}</b>"))
                 .allowPointSelectSet(false)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
                 .dataSet(_dataArray),]);
    comeInModel.dataLabelsEnabled = YES;
    [comeInChartView aa_drawChartWithChartModel:comeInModel];
                 
}

@end
