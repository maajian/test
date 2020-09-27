#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, PGActivityType) {
    PGActivityTypeAll,
    PGActivityTypeOn,
    PGActivityTypeClose
};
NS_ASSUME_NONNULL_BEGIN
@interface PGActivityViewModel : NSObject
- (instancetype)initWithType:(PGActivityType)activityType;
- (void)getAllActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Str)failure;
- (void)getOnActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Str)failure;
- (void)getCloseActivityListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Str)failure;
- (void)checkIsCanpost:(ZDBlock_ID)successBlock error:(ZDBlock_Error)errorBlock;
- (void)getMeMessageListSuccess:(ZDBlock_Int)success failure:(ZDBlock_Error_Str)failure;
@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic, strong) NSMutableArray *onDataArray;
@property (nonatomic, strong) NSMutableArray *closeDataArray;
@property (nonatomic, strong) NSMutableArray *allSearchArray;
@property (nonatomic, strong) NSMutableArray *onSearchArray;
@property (nonatomic, strong) NSMutableArray *closeSearchArray;
@property (nonatomic, strong) NSMutableArray *allTitleArray;
@property (nonatomic, strong) NSMutableArray *onTitleArray;
@property (nonatomic, strong) NSMutableArray *closeTitleArray;
@end
NS_ASSUME_NONNULL_END
