#import <Foundation/Foundation.h>
#import "PGMeNoticeModel.h"
typedef void(^allBlock) (NSArray *array);
@interface PGMeNoticeViewModel : NSObject
@property (nonatomic, copy) PGMeNoticeModel *noticeModel;
- (void)netWorkWithPage:(NSInteger)page Block :(allBlock)allBlock ;
- (void)getNoticeDetail:(NSInteger)ID successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock;
- (void)savaData:(NSArray *)array;
- (void)sava :(NSArray *)array;
- (void)removeData;
- (NSArray *)getData;
- (void)signIsReadWithID :(NSInteger)ID;
- (void)saveTime :(PGMeNoticeModel *)model;
@end
