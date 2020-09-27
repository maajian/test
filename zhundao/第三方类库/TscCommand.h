#import <Foundation/Foundation.h>
@interface TscCommand : NSObject
@property(nonatomic, assign) BOOL hasResponse;
-(void) addSize:(int) width :(int) height;
-(void) addGapWithM:(int) m withN:(int) n;
-(void) addReference:(int) x :(int)y;
-(void) addSpeed:(int) speed;
-(void) addDensity:(int) density;
-(void) addDirection:(int) direction;
-(void) addCls;
-(void) addTextwithX:(int)x withY:(int) y withFont:(NSString*) font
        withRotation:(int) rotation withXscal:(int) Xscal withYscal:(int) Yscal withText:(NSString*) text;
-(void) addBitmapwithX:(int)x withY:(int) y withWidth:(int) width
            withHeight:(int) height withMode:(int) mode withData:(NSData*) data;
-(void) add1DBarcode:(int)x :(int)y :(NSString*)barcodetype :(int)height
                    :(int)readable :(int)rotation :(int)Narrow :(int)Wide :(NSString*)content;
-(void) addQRCode:(int)x :(int)y :(NSString*)ecclever :(int)cellwidth
                    :(NSString*)mode :(int)rotation :(NSString*)content;
-(void) addPrint:(int) m :(int) n;
-(NSData*) getCommand;
-(void) addStrToCommand:(NSString *) str;
-(void) addNSDataToCommand:(NSData*) data;
-(void) addComonCommand;
-(void) addSelfTest;
-(void) queryPrinterType;
-(void) addPeel:(NSString *) strpar;
-(void) addTear:(NSString *) strpar;
-(void) addCutter:(NSString *) strpar;
-(void) addPartialCutter:(NSString *) strpar;
-(void) addSound:(int) level :(int) interval;
-(void) addCashdrawer:(int) m :(int) t1 :(int) t2;
-(void) addBar:(int) x :(int) y :(int) width :(int) height;
-(void) addBox:(int) xstart :(int) ystart :(int) xend :(int) yend :(int) linethickness;
-(void) queryPrinterStatus;
-(void) addReverse:(int) xstart :(int) ystart :(int) xwidth :(int) yheight;
@end
