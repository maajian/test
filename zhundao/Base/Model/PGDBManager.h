typedef void(^searchBlock) (BOOL isSuccess);
@interface PGDBManager : NSObject
@property(nonatomic,strong)FMDatabase *dataBase;
@property(nonatomic,copy)searchBlock  searchBlock;
+ (PGDBManager *)shareManager ;
- (void)createDatabase  ;
- (void)createTable :(NSString *)sqlStr;
- (void)deleteData:(NSString *)sqlStr;
- (void)searchData:(NSString *)sqlStr;
@end
