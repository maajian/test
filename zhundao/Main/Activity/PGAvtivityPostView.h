#import <UIKit/UIKit.h>
@protocol ZDAvtivityPostDelegate <NSObject>
- (void)pushXieYi;
- (void)isCanPost:(NSString *)bigImage;
- (void)pushFee;
- (void)pushEdit;
- (void)pushMoreChoose;
- (void)pushLocation;
- (void)changeBigImage:(NSArray *)imageArray;
@end
@interface PGAvtivityPostView : UIView
@property(nonatomic,weak) id<ZDAvtivityPostDelegate>  ZDAvtivityPostDelegate;
- (instancetype)initWithModel :(ActivityModel *)activityModel;
@property(nonatomic,strong)UITableView                        *tableview ;
@property(nonatomic,strong)      UILabel *activityFeeRightLabel;
@property(nonatomic,strong)      UITextField *activityPlaceTextField;
@property(nonatomic,strong)       WKWebView *textview;
@property(nonatomic,strong)      UILabel *beginTimeRightLabel;
@property(nonatomic,strong)      UILabel *stopTimeRightLabel;
@property(nonatomic,strong)      UILabel *endTimeRightLabel;
@property(nonatomic,strong)      UILabel *startTimeRightLabel;
@property(nonatomic,strong)      UITextField *activityTitleTextField;
@property(nonatomic,strong)      UITextField *activityNumbertField;
@property(nonatomic,copy)NSAttributedString *textStr ;  
@property(nonatomic,copy)NSString *htmlStr ; 
@property(nonatomic,copy)       NSString *bigImageStr; 
@property(nonatomic,strong)      NSArray<NSDictionary *> *feeArray; 
@end
