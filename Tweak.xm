@interface SBUILegibilityLabel : UIView
@property (nonatomic,copy) NSString *string;
@end

@interface NCNotificationListSectionRevealHintView : UIView
-(void)_updateHintTitle;
@end

static BOOL enabled;
static NSString* customText = @"";

#define kIdentifier @"com.yaypixxo.cnonprefs"
#define kSettingsChangedNotification (CFStringRef)@"com.yaypixxo.cnonprefs/ReloadPrefs"
#define kSettingsPath @"/var/mobile/Library/Preferences/com.yaypixxo.cnonprefs.plist"

%hook NCNotificationListSectionRevealHintView

-(void)layoutSubviews {
	%orig;
	if (enabled) {
		[MSHookIvar<UILabel *>(self, "_revealHintTitle") setString:customText];
	}
}

%end

static void reloadPrefs() {
	CFPreferencesAppSynchronize((CFStringRef)kIdentifier);

	NSDictionary *prefs = nil;
	if ([NSHomeDirectory() isEqualToString:@"/var/mobile"]) {
		CFArrayRef keyList = CFPreferencesCopyKeyList((CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
		if (keyList != nil) {
			prefs = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, (CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
			if (prefs == nil)
				prefs = [NSDictionary dictionary];
			CFRelease(keyList);
		}
	} 
	else {
		prefs = [NSDictionary dictionaryWithContentsOfFile:kSettingsPath];
	}

	enabled = [prefs objectForKey:@"enabled"] ? [(NSNumber *)[prefs objectForKey:@"enabled"] boolValue] : true;
	customText = [prefs objectForKey:@"customText"] ? [prefs objectForKey:@"customText"] : changeNotiTxt;

	}

%ctor {
    reloadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, kSettingsChangedNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}