#import <Foundation/Foundation.h>
@interface PGDiscoverPrintVM : NSObject
- (void)checkWithboolArray :(NSMutableArray *)boolArray
                  tableView:(UITableView *)tableView
                   section :(NSInteger)section;
- (NSMutableArray *)changeArray :(NSMutableArray *)array
                            row :(NSInteger )row;
- (void)printTextIsPrint :(BOOL)isPrint
                 offsetx :(int )x
                 offsety :(int)y
               textArray :(NSArray *)textArray;
- (void)printQRCode :(NSString *)linkStr
            isPrint :(BOOL)isPrint
            offsetx :(int )x
            offsety :(int)y;
- (void)printQRCode :(NSString *)linkStr
               name :(NSString *)name
            isPrint :(BOOL)isPrint
            offsetx :(int )x
            offsety :(int)y;
- (void)printQRCode :(NSString *)linkStr
            isPrint :(BOOL)isPrint
            offsetx :(int )x
            offsety :(int)y
          textArray :(NSArray *)textArray;
- (NSArray *)getModel;
- (NSArray *)getActive;
- (NSString *)getOffsetX;
- (NSString *)getOffsetY;
- (BOOL)getFlag;
@end
