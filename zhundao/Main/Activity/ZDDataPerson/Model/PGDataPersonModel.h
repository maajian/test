#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ZDDataPersonStatus) {
    ZDDataPersonStatusReview,
    ZDDataPersonStatusPass,
    ZDDataPersonStatusReject,
};
NS_ASSUME_NONNULL_BEGIN
@interface PGDataPersonModel : NSObject
@property (nonatomic, assign) NSInteger ActivityId;
@property (nonatomic, copy) NSString *AddByName;
@property (nonatomic, copy) NSString *UserName;
@property (nonatomic, copy) NSString *Phone;
@property (nonatomic, copy) NSString *AddTime;
@property (nonatomic, assign) ZDDataPersonStatus dataPersonStatus;
@property (nonatomic, assign) NSInteger number; 
@end
NS_ASSUME_NONNULL_END
