#import <Foundation/Foundation.h>
#import "PGDiscoverCustomApplyModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGDiscoveEditApplyViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<NSString *> *dataArray;
@property (nonatomic, copy) NSArray<NSString *> *typeArray;
@property (nonatomic, assign) BOOL isNeedChoice;
@property (nonatomic, strong) PGDiscoverCustomApplyModel *model;
#pragma mark --- network
- (void)changeCustomtApplyWithTitle:(NSString *)title inputType:(ZDCustomType)inputType ID:(NSInteger)ID require:(BOOL)require tips:(NSString *)tips choiceArray:(NSArray *)choiceArray success:(kZDCommonSucc)success failure:(kZDCommonFail)failure;
- (void)newCustomApplyRequestWithTitle:(NSString *)title inputType:(ZDCustomType)inputType require:(BOOL)require tips:(NSString *)tips choiceArray:(NSArray *)choiceArray success:(ZDBlock_Dic)success failure:(kZDCommonFail)failure;
@end
NS_ASSUME_NONNULL_END
