#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "BackGroundImageV4" asset catalog image resource.
static NSString * const ACImageNameBackGroundImageV4 AC_SWIFT_PRIVATE = @"BackGroundImageV4";

/// The "GameMode00" asset catalog image resource.
static NSString * const ACImageNameGameMode00 AC_SWIFT_PRIVATE = @"GameMode00";

#undef AC_SWIFT_PRIVATE
