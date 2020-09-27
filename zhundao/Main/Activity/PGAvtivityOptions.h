#import <Foundation/Foundation.h>
typedef void(^netBlock) (NSArray *optionsArray);
@interface PGAvtivityOptions : NSObject
@property(nonatomic,copy)netBlock block;
- (void)networkwithBlock :(netBlock)netBlock;
@end
