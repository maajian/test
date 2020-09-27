#import <Foundation/Foundation.h>
@interface PGAvtivityInviteViewModel : NSObject
- (void)drawImage :(UIImageView *)imageview
           image1 :(UIImage *)image1
           image2 :(UIImage *)image2
           acName :(NSString *)acName
          timeStr :(NSString *)timeStr
          address :(NSString *)address
            index :(NSInteger)index;
- (NSString *)getTime :(NSString *)timeStr;
- (void)savaImageToSanBox :(NSInteger)acID image :(UIImage *)image index :(NSInteger)index;
- (void)getImageFromSanbox:(NSInteger)acID imageArray :(NSMutableArray *)imageArray;
@end
