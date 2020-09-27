#import <Foundation/Foundation.h>
#import "NSObject+block.h"
@interface PGActivityGroupSendViewModel : NSObject
#pragma mark ---- network
- (void)openMessage:(ZDSuccessBlock)successBlock
              error:(ZDErrorBlock)error ;
- (void)getAdminInfo:(ZDSuccessBlock)successBlock
               error:(ZDErrorBlock)errorBlock;
- (void)topUpSMS :(NSString *)password
           count :(NSInteger)count
     successBlock:(ZDSuccessBlock)successBlock
            error:(ZDErrorBlock)errorBlock;
- (void)sendWithSelectArray :(NSArray *)selectArray
                 modelArray :(NSArray *)modelArray
                        esid:(NSInteger)esid
                  activityId:(NSInteger)activityId
                    content :(NSString *)content
                successBlock:(ZDSuccessBlock)successBlock
                       error:(ZDErrorBlock)errorBlock;
- (void)getContent:(ZDSuccessBlock)successBlock
             error:(ZDErrorBlock)errorBlock;
#pragma mark --- tableView
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)heightForFooterInSection:(NSInteger)section;
- (NSInteger)heightForHeaderInSection:(NSInteger)section;
- (NSInteger)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
