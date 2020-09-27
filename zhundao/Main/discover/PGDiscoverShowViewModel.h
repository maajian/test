#import <Foundation/Foundation.h>
@interface PGDiscoverShowViewModel : NSObject
- (void)saveData :(NSMutableDictionary *)dic
        textView :(UITextView *)textView;
- (void)saveImageData :(NSMutableDictionary *)dic
            imageView :(UIImageView *)imageView;
- (void)savaToPlist :(NSArray *)fixArray
        customArray :(NSArray *)customArray
                 str:imageStr
               name :(NSString *)name;
- (NSArray *)writeFixArray:(NSString *)name;
- (NSArray *)writeCustomArray :(NSString *)name;
- (void)setTextViewFrame :(UITextView *)textView;
@end
