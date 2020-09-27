#import <Foundation/Foundation.h>
typedef void(^upBlock) (NSString *str);
@interface PGNewOrEditMV : NSObject
- (NSMutableAttributedString *)setAttrbriteStrWithText:(NSString *)text;  
- (void)setKeyboardTypeWithtextf :(UITextField *)TextField;   
- (void)isNoDataTextField:(UITextField *)TextField ;   
+ (void)changeToNetImage :(UIImage *)image block:(upBlock)block;  
- (NSMutableArray *)sexChangeWithArray :(NSArray *)dataArray  muArray :(NSMutableArray *)array; 
- (NSString *)sexChangeToStr :(NSString * )str ;
- (NSString *)searchContactGroupIDFromID:(NSInteger )ID;  
@end
