#import <Foundation/Foundation.h>
typedef void(^addBlock) (NSInteger isSuccess);
typedef void(^feeBlock) (NSInteger feeid);
@interface PGActivityNewPersonViewModel : NSObject
@property(nonatomic,copy)addBlock blcok;
- (void)addPersonNetWork :(NSDictionary *)dic feeid :(NSInteger)feeid;
- (NSMutableArray *)getBaseName :(NSString *)str;
- (NSMutableArray *)getRightArray :(NSArray *)baseArray allOptionArray:(NSArray *)allOptionArray;
- (NSMutableArray *)getFeeArray :(NSArray *)feeArray;
- (NSMutableArray *)getBaseRightArray :(NSArray *)allRight count :(NSInteger )count;
- (void)getFeeidFromArray :(NSArray *)feeArray selectStr :(NSString *)str feeidBlock : (feeBlock) feeBlock ;
@end
