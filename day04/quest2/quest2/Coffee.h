#import <Foundation/Foundation.h>

@interface Coffee : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) float price;

- (instancetype)initWithName:(NSString *)name andPrice:(float)price;

@end
