#import <Foundation/Foundation.h>
typedef void(^getAllBlock) (NSArray *dataArray,NSArray *timeArray,NSArray *noAnswerArray,NSArray *hadAnswerArray);
@interface PGActivityConsultViewModel : NSObject
- (void)getAllConsult :(NSDictionary *)dic  getAllBlock:(getAllBlock)getAllBlock;
- (NSArray *)getHeight:(NSArray *)array;
@end
