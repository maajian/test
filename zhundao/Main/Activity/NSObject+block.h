#import <Foundation/Foundation.h>
typedef void(^ZDSuccessBlock)( id responseObject);
typedef void(^ZDErrorBlock)(NSError *error);
@interface NSObject (block)
@property(nonatomic,copy)ZDSuccessBlock  ZDSuccessBlock;
@property(nonatomic,copy)ZDErrorBlock ZDErrorBlock;
@end
