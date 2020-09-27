#import <Foundation/Foundation.h>
#import "MyPeripheral.h"
@interface BLKWrite : NSObject<MyPeripheralDelegate>
@property (nonatomic, strong) MyPeripheral *connectedPeripheral;
@property (nonatomic, assign) BOOL bWiFiMode; 
@property (nonatomic, strong) NSString *serverIP;
@property (nonatomic, assign) int port;
+(BLKWrite*) Instance;
-(void) writeTscData:(NSData*) data withResponse:(BOOL) flag;
-(void) writeEscData:(NSData*) data withResponse:(BOOL) flag;
-(BOOL) isConnecting;
-(void) setPeripheral:(MyPeripheral*) peripheral;
#pragma mark-Wi-Fi Mode
-(void) initWiFiClient;
#pragma mark-
-(int) PrintWidth;
@end
