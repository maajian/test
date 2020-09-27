#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface PGSignInModel : NSObject
@property(nonatomic,copy)NSString *Name;   
@property(nonatomic,copy)NSString *ActivityName;   
@property(nonatomic,assign)NSInteger CheckInType;  
@property(nonatomic,copy)NSString *AddTime;
@property(nonatomic,assign)NSInteger Status;   
@property (nonatomic,assign)NSInteger NumShould;   
@property (nonatomic,assign)NSInteger NumFact;   
@property(nonatomic,assign)NSInteger SignObject;  
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger ActivityID;
@end
NS_ASSUME_NONNULL_END
