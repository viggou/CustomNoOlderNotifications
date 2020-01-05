@interface SBUILegibilityLabel : UIView
@property (nonatomic,copy) NSString *string;
@end

@interface NCNotificationListSectionRevealHintView : UIView 
//-(void)_updateHintTitle;
//-(void)setRevealHintTitle;
@property (nonatomic,retain)SBUILegibilityLabel *revealHintTitle;
@end

// prefs
@interface NSUserDefaults (CnonPrefs)
-(id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
-(void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString *nsDomainString = @"com.yaypixxo.cnon";
static NSString *nsNotificationString = @"com.yaypixxo.cnon/preferences.changed";

// declare switch and string
static BOOL enabled;
static NSString *customText = @"";

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    NSNumber *eEnabled = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enabled" inDomain:nsDomainString];
    NSString *eCustomText = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"customText" inDomain:nsDomainString];

    enabled = (eEnabled) ? [eEnabled boolValue]:NO;
    customText = eCustomText; //(eCustomText) ? [eCustomText value]:@"";
}

/*#ifndef kCFCoreFoundationVersionNumber_iOS_13_0
#define kCFCoreFoundationVersionNumber_iOS_13_0 1665.15
#endif

#define kSLSystemVersioniOS13 kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_13_0*/

/*%group ios13

%hook NCNotificationListSectionRevealHintView

-(void)setRevealHintTitle:(SBUILegibilityLabel *)arg1 {
	if (enabled) {
		arg1 = customText;
	}
}

%end

%end*/

//%group ios12

%hook NCNotificationListSectionRevealHintView

-(void)didMoveToWindow {
	%orig;
	if (enabled) {
		self.revealHintTitle.string = customText;
	}
}

%end

//%end

%ctor {
	// check iOS version
    /*if (kSLSystemVersioniOS13) {
        %init(ios13);
    }
    else {
        %init(ios12);
    }*/

    notificationCallback(NULL, NULL, NULL, NULL, NULL);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);
}