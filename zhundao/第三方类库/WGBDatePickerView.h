#import <UIKit/UIKit.h>
@protocol WGBDatePickerViewDelegate <NSObject>
@required
- (void)changeTime:(NSDate *)date;
@optional
- (void)determine:(NSDate *)date;
@end
@interface WGBDatePickerView : UIView
@property(nonatomic,strong)UIButton *button;
+ (instancetype)datePickerWithType:(UIDatePickerMode) type ;
- (instancetype)initWithFrame:(CGRect)frame type:(UIDatePickerMode)type;
@property (nonatomic,copy) void(^changeTimeBlock) (NSDate *date);
@property (nonatomic,copy) void(^determineBlock) (NSDate *date);
- (void)show;
- (void)setNowTime:(NSString *)dateStr;
@property (nonatomic,strong) NSDate *optionalMaxDate;
@property (nonatomic,strong) NSDate *optionalMinDate;
@property (nonatomic,copy) NSString *title;
- (NSString*)stringFromDate:(NSDate*)date;
- (NSDate*)dateFromString:(NSString*)dateString;
@property (assign,nonatomic) id<WGBDatePickerViewDelegate> delegate;
@end
