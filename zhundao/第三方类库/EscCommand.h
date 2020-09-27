#import <Foundation/Foundation.h>
@interface EscCommand : NSObject
@property(nonatomic, assign) BOOL hasResponse;
-(void) addUPCAtest:(NSString*) content;
-(void) addText:(NSString*) text;
-(NSData*) getCommand;
-(void) addStrToCommand:(NSString *) str;
-(void) addInitializePrinter;
-(void) addPrintAndFeedLines:(int) n;
-(void) addPrintMode:(int) n;
-(void) addSetInternationalCharacterSet:(int) n;
-(void) addSet90ClockWiseRotatin:(int) n;
-(void) addSetJustification:(int) n;
-(void) addOpenCashDawer:(int) m :(int) t1 :(int) t2;
-(void) addSound:(int) m :(int) t :(int) n;
-(void) addLineSpacing:(int) n;
-(void) addSetUpsideDownMode:(int) n;
-(void) addSetCharcterSize:(int) n;
-(void) addSetReverseMode:(int) n;
-(void) queryRealtimeStatus:(int) n;
-(void) addCutPaperAndFeed:(int) n;
-(void) addCutPaper:(int) m;
-(void) addSetBarcodeHRPosition:(int) n;
-(void) addSetBarcodeHRIFont;
-(void) addSetBarcodeHeight:(int) n;
-(void) addSetBarcodeWidth:(int) n;
-(void) addEAN13:(NSString*) content;
-(void) addEAN8:(NSString*) content;
-(void) addUPCA:(NSString*) content;
-(void) addITF:(NSString*) content;
-(void) addCODE39:(NSString*) content;
-(void) addCODE128:(char) charset :(NSString*) content;
-(void) addCODE128ABC:(int) height :(int) width :(NSData*) data;
-(void) addNVLOGO:(int) n :(int) m;
-(void) addESCBitmapwithM:(int) m withxL:(int) xL withxH:(int) xH withyL:(int) yL
            withyH:(int) yH withData:(NSData*) data;
-(void) addQRCodeSizewithpL:(int) pL withpH:(int) pH withcn:(int) cn
            withyfn:(int) fn withn:(int) n;
-(void) addQRCodeLevelwithpL:(int) pL withpH:(int) pH withcn:(int) cn
            withyfn:(int) fn withn:(int) n;
-(void) addQRCodeSavewithpL:(int) pL withpH:(int) pH withcn:(int) cn
            withyfn:(int) fn withm:(int) m withData:(NSData*) data;
-(void) addQRCodePrintwithpL:(int) pL withpH:(int) pH withcn:(int) cn
            withyfn:(int) fn withm:(int) m;
-(void) addSetKanjiFontMode:(int) n;
-(void) addSelectKanjiMode;
-(void)addSetKanjiUnderLine:(int) n;
-(void) addCancelKanjiMode;
-(void) addSetCharacterRightSpace:(int) n;
-(void) addSetKanjiLefttandRightSpace:(int) n1 :(int) n2;
-(void) addTurnEmphasizedModeOnOrOff:(int) n;
-(void) addTurnDoubleStrikeOnOrOff:(int) n;
-(void) addNSDataToCommand:(NSData*) data;
@end