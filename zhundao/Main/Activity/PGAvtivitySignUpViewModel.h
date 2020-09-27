#import <Foundation/Foundation.h>
#import "PGAvtivitySignUpModel.h"
@interface PGAvtivitySignUpViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<NSString *> *xLabelArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *personCountArray;
- (void)getActivityListDate:(NSInteger)activityId
                  beginDate:(NSString *)beginDate
                    endDate:(NSString *)endDate
               successBlock:(kZDCommonSucc)successBlock
                  failBlock:(kZDCommonFail)failBlock ;
- (void)getActivityReadDate:(NSInteger)activityId
                  beginDate:(NSString *)beginDate
                    endDate:(NSString *)endDate
               successBlock:(kZDCommonSucc)successBlock
                  failBlock:(kZDCommonFail)failBlock;
- (void)getFeePeopleNoDate:(NSInteger)activityId
              successBlock:(kZDCommonSucc)successBlock
                 failBlock:(kZDCommonFail)failBlock;
- (void)getEachFeeDate:(NSInteger)activityId
          successBlock:(kZDCommonSucc)successBlock
             failBlock:(kZDCommonFail)failBlock;
@end
