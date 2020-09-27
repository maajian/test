#import <Foundation/Foundation.h>
typedef void(^postBlock) (NSInteger isSuccess);
@interface PGActivityEditSignListViewModel : NSObject
@property(nonatomic,copy) postBlock postBlock;
- (void)postDataWithDic :(NSDictionary *)dic ;
- (NSMutableArray *)getMustArrayFromArray :(NSArray *)baseNameArray
                              customArray :(NSArray *)customArray ;
- (NSMutableArray *)getRequiredArray :(NSArray *)baseArray allOptionArray :(NSArray *)allOptionArray;
- (NSMutableArray *)getRightMustArray :(NSArray *)baseArray
                       allOptionArray :(NSArray *)allOptionArray
                                  dic :(NSDictionary *)optionDic ;
-(NSMutableArray *)getMustInputTypeFromArray :(NSArray *)baseNameArray
                                 customArray :(NSArray *)customArray;
- (NSMutableArray *)getLastPostArray :(NSArray *)array;
- (NSDictionary *)getDicWithStr :(NSString *)jsonStr ;
- (NSMutableAttributedString *)setAttrbriteStrWithText:(NSString *)text ;
- (void)setKeyboardTypeWithtextf : (UITextField *)textf
                            type :(NSInteger) type ;
- (NSArray *)getAllChooseArrayWithStr :(NSString *)titleStr
                           customArray:(NSArray *)customArray;
- (NSArray *)getNowChooseArrayWithStr :(NSString *)titleStr ;
- (NSDictionary *)SaveWithRightMustArray :(NSMutableArray *)rightMustArray
                 leftMustArray :(NSMutableArray *)_leftMustArray
                               baseArray :(NSArray *)baseArray
                          view :(UIView *)view;
- (NSInteger )getSexSelectStr :(NSString *)sexStr;
- (NSMutableArray *)getBaseRightArray :(NSArray *)allRight count :(NSInteger )count;
@end
