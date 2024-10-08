#import <Foundation/Foundation.h>
#import "Barista.h"

@implementation Barista

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName andExperienceYears:(int)experienceYears {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _experienceYears = experienceYears;
    }
    return self;
}

- (void)brew:(Coffee *)coffee {
    NSLog(@"Processing brewing coffee...");
    NSLog(@"Your %@ is ready!", coffee.name);
}

@end
