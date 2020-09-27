#import <Foundation/Foundation.h>
@interface PGMeContactModel : NSObject
@property(nonatomic,copy)NSString *HeadImgurl;  
@property(nonatomic,copy)NSString *TrueName;    
@property(nonatomic,assign)NSInteger ContactGroupID;  
@property(nonatomic,assign)NSInteger ID;   
@property(nonatomic,copy)NSString *Address; 
@property(nonatomic,copy)NSString *GroupName; 
@property(nonatomic,copy)NSString *Company;    
@property(nonatomic,copy) NSString *Mobile;
@property(nonatomic,assign)NSInteger Sex;   
@property(nonatomic,copy)NSString *Duty;    
@property(nonatomic,copy)NSString *Email;    
@property(nonatomic,copy)NSString *Remark;    
@property(nonatomic,copy)NSString *SerialNo;    
@property(nonatomic,copy)NSString *IDcard;   
@end
