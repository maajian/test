#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "PGMaskLabel.h"
#import "MyButton.h"
#import "MyLabel.h"
#import "MyImage.h"
#import "PGMyHud.h"
#import "myTextField.h"
#import "ActivityModel.h"
@interface PGSignManager : NSObject
{
    UIViewController *SaveCtr;
}
@property(nonatomic,copy)NSString *accesskey;
@property(nonatomic,strong)FMDatabase *dataBase;
@property(nonatomic,assign)CGRect imageRect;
+(PGSignManager *)shareManager;
- (NSString *)getaccseekey; 
- (NSString *)getToken;
- (void)createDatabase; 
- (void)showNotHaveNet:(UIView *)View;  
- (void)saveImageWithFrame:(CGRect) rect
                WithCtr:(UIViewController *)Ctr
;
- (void)shareImagewithModel:(ActivityModel *)model withCTR:(UIViewController *)ctr Withtype:(NSInteger)type withImage :(UIImage *)image;  
- (void)shareWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle thumImage:(UIImage *)thumImage webpageUrl:(NSString *)webpageUrl withCTR:(UIViewController *)ctr Withtype:(NSInteger)type;
- (void)saveData:(NSArray *)array name :(NSString *)name; 
- (NSArray *)getArray :(NSString *)name; 
@end
