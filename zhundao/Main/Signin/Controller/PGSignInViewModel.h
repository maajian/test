#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, PGSignype) {
    PGSignypeAll,
    PGSignypeOn,
    PGSignypeClose
};
@interface PGSignInViewModel : NSObject
- (instancetype)initWithType:(PGSignype)signType;
- (void)getAllSignListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure;
- (void)getOnSignListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure;
- (void)getCloseSignListWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Arr)success failure:(ZDBlock_Void)failure;
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
