#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GuideViewCleanMode) {
    GuideViewCleanModeRect, 
    GuideViewCleanModeRoundRect,      
    GuideViewCleanModeOval     
};
@interface GuideView : UIView
@property(nonatomic)CGRect showRect;    
@property(nonatomic)BOOL fullShow;  
@property(nonatomic,strong)UIColor *guideColor; 
@property(nonatomic)BOOL showMark;  
@property(nonatomic,copy)NSString *markText;    
@property(nonatomic)GuideViewCleanMode model;   
@end
