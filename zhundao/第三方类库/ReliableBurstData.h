#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@protocol ReliableBurstDataDelegate;
@interface ReliableBurstData : NSObject
- (NSUInteger)transmitSize;
- (void)reliableBurstTransmit:(NSData *)data withTransparentCharacteristic:(CBCharacteristic *)transparentDataWriteChar;
- (BOOL)canSendReliableBurstTransmit;
- (BOOL)canDisconnect;
- (void)decodeReliableBurstTransmitEvent:(NSData *)eventData;
- (void)enableReliableBurstTransmit:(CBPeripheral *)peripheral andAirPatchCharacteristic:(CBCharacteristic *)airPatchCharacteristic;
- (BOOL)isReliableBurstTransmit:(CBCharacteristic *)transparentDataWriteChar;
- (NSString *)version;
@property (nonatomic,weak)id<ReliableBurstDataDelegate>delegate;
@end
@protocol ReliableBurstDataDelegate <NSObject>
- (void)reliableBurstData:(ReliableBurstData *)reliableBurstData didSendDataWithCharacteristic:(CBCharacteristic *)transparentDataWriteChar;
@end
